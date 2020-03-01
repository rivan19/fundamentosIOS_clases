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
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
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
            
            cell.selectCell = {() -> Void in
                let castViewDetail = CastDetailViewController.init(actor)
                castViewDetail.delegate = self
                
                let navigationCastViewDetail = UINavigationController.init(rootViewController: castViewDetail)
                
                let rightButtonBar = DataController.shared.getRightBarButtonItem(actor, view: castViewDetail)
                 
                 let leftButtonBar = DataController.shared.getLeftBarButtonItem(actor, view: castViewDetail, image: "xmark.circle.fill")
                
                castViewDetail.title = actor.fullname
                
                castViewDetail.navigationItem.rightBarButtonItem = rightButtonBar
                castViewDetail.navigationItem.leftBarButtonItem = leftButtonBar
                
                self.present(navigationCastViewDetail, animated: true, completion: nil)
            }
            
            return cell
        }
        
        fatalError("Could not create the Episode cell")
    }
    
}
