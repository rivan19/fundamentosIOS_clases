//
//  CastViewController.swift
//  AppOfThrones
//
//  Created by Ivan Llopis Guardado on 13/02/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class CastViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FavoriteDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cast : [Cast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.setupNotifications()
        self.setupData()
    }
    
    deinit {
        let noteName = Notification.Name(rawValue: "DidFavoritesUpdated")
        NotificationCenter.default.removeObserver(self, name: noteName, object: nil)
    }
    
    // MARK: - Setup
    
    func setupData(){
        
        cast = DataController.shared.setupDataCast() ?? []
        tableView.reloadData()
        
    }
    
    func setupUI() {
        self.title = "Cast"
        let nib = UINib.init(nibName: "CastTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CastTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupNotifications() {
        let noteName = Notification.Name(rawValue: "DidFavoritesUpdated")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didFavoriteChanged), name: noteName, object: nil)
    }
    
    // MARK: - CastTablaViewCellDelegate
    @objc func didFavoriteChanged() {
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCell", for: indexPath) as? CastTableViewCell {
            let actor = cast[indexPath.row]
            cell.setCast(actor)
            cell.delegate = self
            return cell
        }
        
        fatalError("Could not create the Episode cell")
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        let cst = self.cast[indexPath.row]
        
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
