//
//  FavoriteViewController.swift
//  AppOfThrones
//
//  Created by Ivan Llopis Guardado on 26/02/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RateViewCellDelegate, FavoriteDelegate {
    
    @IBOutlet weak var favoritesTableView: UITableView!
    private var episodes : [Episode] = []
    private var casts : [Cast] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupDataFavorite()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    func didRateChanged() {
        self.favoritesTableView.reloadData()
    }
    
    @objc func didFavoriteChanged() {
        //self.favoritesTableView.reloadData()
        setupDataFavorite()
    }
    
    func setupDataFavorite() {
        episodes = DataController.shared.episodeFavorite ?? []
        casts = DataController.shared.castsFavorite ?? []
        
        favoritesTableView.reloadData()
        
    }
    
    func setupUI() {
        let nibEpisode = UINib.init(nibName: "EpisodeTableViewCell", bundle: nil)
        favoritesTableView.register(nibEpisode, forCellReuseIdentifier: "EpisodeTableViewCell")
        
        let nibCast = UINib.init(nibName: "CastTableViewCell", bundle: nil)
        favoritesTableView.register(nibCast, forCellReuseIdentifier: "CastTableViewCell")
        
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
    }
    
    // MARK: -UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
            return 2
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if (section == 0)
            {
                return episodes.count
            }else if (section == 1) {
                return casts.count
            }
            fatalError("Error: numberOfRowsInSection")
        }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0)
        {
            return "Episode"
        }
        else if (section == 1) {
            return "Cast"
        }
        
        fatalError("Error: titleForHeaderInSection")
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0)
        {
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
                    navigationController.title = ep.name ?? "Rate"
                    rateViewController.delegate = self
                    self.present(navigationController, animated: true, completion: nil)
                }
                return cell
            }
        }
        else if (indexPath.section == 1)
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCell", for: indexPath) as? CastTableViewCell {
                let actor = casts[indexPath.row]
                cell.setCast(actor)
                cell.delegate = self
                return cell
            }
        }
        
        fatalError("Could not create the Episode cell")
    }
    
    
    //MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0)
        {
            return 200
        }
        else if (indexPath.section == 1)
        {
            return 200
        }
        
        fatalError("Error: heightForRowAt")
    }
        
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tableViewHeader = UITableViewHeaderFooterView.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 30))
        
        tableViewHeader.backgroundColor = .orange
        tableViewHeader.tintColor = .white
        
        return tableViewHeader
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        let cst = self.casts[indexPath.row]
        
        let castViewDetail = CastDetailViewController.init(cst)
        castViewDetail.delegate = self
        
        let navigationCastViewDetail = UINavigationController.init(rootViewController: castViewDetail)
        
        let rightButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        let leftButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        
        castViewDetail.title = cst.fullname
            
        rightButton.setImage(UIImage.init(systemName: DataController.shared.getImageHeart(cst)), for: .normal)
        leftButton.setImage(UIImage.init(systemName: "xmark.circle.fill"), for: .normal)
        
        rightButton.tintColor = .red
        leftButton.tintColor = .orange
        
        rightButton.addTarget(castViewDetail.self, action: #selector(castViewDetail.heartButtonAction), for: .touchUpInside)
        leftButton.addTarget(castViewDetail.self, action: #selector(castViewDetail.close), for: .touchUpInside)
        
        let rightBarItem = UIBarButtonItem.init(customView: rightButton)
        let leftBarItem = UIBarButtonItem.init(customView: leftButton)
        
        castViewDetail.navigationItem.rightBarButtonItem = rightBarItem
        castViewDetail.navigationItem.leftBarButtonItem = leftBarItem
        
        self.present(navigationCastViewDetail, animated: true, completion: nil)
        
    }
}
