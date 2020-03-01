//
//  HouseViewController.swift
//  AppOfThrones
//
//  Created by Ivan Llopis Guardado on 13/02/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class HouseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FavoriteDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var houses: [House] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
        // Do any additional setup after loading the view.
    }
    
    deinit {
        let noteName = Notification.Name(rawValue: "DidFavoritesUpdated")
        NotificationCenter.default.removeObserver(self, name: noteName, object: nil)
    }

    func setupUI(){
        self.title = "House"
        let nib = UINib.init(nibName: "HouseTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HouseTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func setupData()
    {
        houses = DataController.shared.setupDataHouse() ?? []
        tableView.reloadData()
    }

    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HouseTableViewCell", for: indexPath) as? HouseTableViewCell {
            let house = houses[indexPath.row]
            cell.setHouse(house)
            cell.delegate = self
            
            cell.selectCell = { () -> Void in
                
                let houseViewController = HouseDetailViewController.init(house: house)
                
                houseViewController.title = house.name ?? ""
                
                let houseNavigationViewController = UINavigationController.init(rootViewController: houseViewController)
                
                let leftBarButton = DataController.shared.getLeftBarButtonItem(house, view: houseViewController, image: "xmark.circle.fill")
                
                let rightBarButton = DataController.shared.getRightBarButtonItem(house, view: houseViewController)
                
                houseViewController.navigationItem.leftBarButtonItem = leftBarButton
                houseViewController.navigationItem.rightBarButtonItem = rightBarButton
                
                self.present(houseNavigationViewController, animated: true, completion: nil)
            }
            
            return cell
        }
        
        fatalError("Could not create the Episode cell")
    }
    
    @objc func didFavoriteChanged() {
        self.tableView.reloadData()
    }
    
    func setupNotifications() {
        let noteName = Notification.Name(rawValue: "DidFavoritesUpdated")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didFavoriteChanged), name: noteName, object: nil)
        
    }

}
