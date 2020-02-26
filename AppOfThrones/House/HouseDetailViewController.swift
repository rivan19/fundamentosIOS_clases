//
//  HouseDetailViewController.swift
//  AppOfThrones
//
//  Created by Ivan Llopis Guardado on 26/02/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var house: House?
    @IBOutlet weak var houseTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    convenience init(house: House)
    {
        self.init()
        
        self.house = house
    }
    
    func setupUI() {
        let nibImage = UINib.init(nibName: "ImageHouseTableViewCell", bundle: nil)
        let nibDetail = UINib.init(nibName: "HouseDetailTableViewCell", bundle: nil)
        
        houseTableView.register(nibImage, forCellReuseIdentifier: "ImageHouseTableViewCell")
        houseTableView.register(nibDetail, forCellReuseIdentifier: "HouseDetailTableViewCell")
        
        houseTableView.delegate = self
        houseTableView.dataSource = self
        
        
    }
    
    @objc func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ImageHouseTableViewCell", for: indexPath) as? ImageHouseTableViewCell {
                    
                    cell.houseImageView.image = UIImage.init(named: self.house?.imageName ?? "")
                
                    return cell
                }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HouseDetailTableViewCell", for: indexPath) as? HouseDetailTableViewCell{
                if let hs = self.house {
                    cell.seatLabel.text = "(\(hs.seat))"
                    cell.wordTextView.text = hs.words
                }
                
                return cell
                
            }
        }
        
        fatalError("Could not create the Episode cell")
    }
    
    // MARK - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 350
        default:
            return 130
        }
        
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}
