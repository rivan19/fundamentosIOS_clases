//
//  HouseViewController.swift
//  AppOfThrones
//
//  Created by Ivan Llopis Guardado on 13/02/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class HouseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var houses: [House] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
        // Do any additional setup after loading the view.
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
    
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        let hs = houses[indexPath.row]
        
        let houseViewController = HouseDetailViewController.init(house: hs)
        
        houseViewController.title = hs.name ?? ""
        
        let houseNavigationViewController = UINavigationController.init(rootViewController: houseViewController)
        
        let leftButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        
        leftButton.setImage(UIImage.init(systemName: "xmark.circle.fill"), for: .normal)
        
        leftButton.tintColor = .orange
        
        leftButton.addTarget(houseViewController.self, action: #selector(houseViewController.close), for: .touchUpInside)
        
        let leftBarButton = UIBarButtonItem.init(customView: leftButton)
        
        houseViewController.navigationItem.leftBarButtonItem = leftBarButton
        
        self.present(houseNavigationViewController, animated: true, completion: nil)
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
            return cell
        }
        
        fatalError("Could not create the Episode cell")
    }

}
