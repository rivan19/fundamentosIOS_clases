//
//  EpisodeViewController.swift
//  AppOfThrones
//
//  Created by Ivan Llopis Guardado on 13/02/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RateViewCellDelegate, FavoriteDelegate {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var episodes: [Episode] = []
    
    //var reloadTable: (() -> Void)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        self.setupData(1)
    }
    
    deinit {
        let noteName = Notification.Name(rawValue: "DidFavoritesUpdated")
        NotificationCenter.default.removeObserver(self, name: noteName, object: nil)
    }
    
    func setupData(_ seasonNumber: Int){
        episodes = DataController.shared.setupDataEpisode(seasonNumber) ?? []
        self.tableView.reloadData()
    }
    
    func setupUI() {
        self.title = "Seasons"
        
        let nib = UINib.init(nibName: "EpisodeTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "EpisodeTableViewCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func setupNotifications() {
        let noteName = Notification.Name(rawValue: "DidFavoritesUpdated")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didFavoriteChanged), name: noteName, object: nil)
        
        let rateName = Notification.Name(rawValue: "DidRateUpdated")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didRateChanged), name: rateName, object: nil)
    }
    
    // MARK: - EpisodeTableViewCellDelegate
    @objc func didFavoriteChanged() {
        self.tableView.reloadData()
    }
    
    
    @objc func didRateChanged() {
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeTableViewCell", for: indexPath) as? EpisodeTableViewCell {
            let ep = episodes[indexPath.row]
            cell.setEpisode(ep)
            cell.delegate = self
            
            cell.selectCell = { () -> Void in
                
                let heartImageNamed = DataController.shared.getImageHeart(ep)
                
                let rightButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
                rightButton.setImage(UIImage.init(systemName: heartImageNamed), for: .normal)
                rightButton.tintColor = .red
                
                let leftButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
                leftButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
                leftButton.tintColor = .orange
                
                let episodeDetailViewController = EpisodeDetailViewController.init(withEpisode: ep)
                
                let navigationDetailController = UINavigationController.init(rootViewController: episodeDetailViewController)
                
                episodeDetailViewController.title = ep.name ?? ""
                
                rightButton.addTarget(episodeDetailViewController.self, action: #selector(episodeDetailViewController.heartButtonAction), for: .touchUpInside)
                
                let rightButtonBar = UIBarButtonItem.init(customView: rightButton)
                
                leftButton.addTarget(episodeDetailViewController.self, action: #selector(episodeDetailViewController.closeViewController), for: .touchUpInside)
                
                let leftButtonBar = UIBarButtonItem.init(customView: leftButton)
                
                episodeDetailViewController.navigationItem.rightBarButtonItem = rightButtonBar
                
                episodeDetailViewController.navigationItem.leftBarButtonItem = leftButtonBar
                
                episodeDetailViewController.delegate = self
                
                self.present(navigationDetailController, animated: true, completion: nil)
            }
            
            cell.rateBlock = { () -> Void in
                let rateViewController = RateViewController.init(withEpisode: ep)
                let navigationController = UINavigationController.init(rootViewController: rateViewController)
                
                let leftButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
                
                leftButton.setImage(UIImage.init(systemName: "xmark.circle.fill"), for: .normal)
                
                leftButton.tintColor = .orange
                
                leftButton.addTarget(rateViewController.self, action: #selector(rateViewController.close), for: .touchUpInside)
                
                let leftBarItem = UIBarButtonItem.init(customView: leftButton)
                
                rateViewController.navigationItem.leftBarButtonItem = leftBarItem
                
                navigationController.title = ep.name ?? "Rate"
                
                rateViewController.delegate = self
                self.present(navigationController, animated: true, completion: nil)
            }
            return cell
        }
        
        fatalError("Could not create the Episode cell")
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        print("La fila \(indexPath.row), y sección \(indexPath.section)")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
    }
    
    // MARK: - IBActions
    
    @IBAction func seasonChanged(_ sender: UISegmentedControl) {
        let seasonNumber = sender.selectedSegmentIndex + 1
        setupData(seasonNumber)
    }
    
    
}
