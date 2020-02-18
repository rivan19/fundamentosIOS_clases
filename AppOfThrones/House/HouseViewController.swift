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
    
    let houses: [House] = [House.init(imageName: "Stark", name: "Stark", words: "Winter is Comming", seat: "Winterfall"), House.init(imageName: "Lannister", name: "Lannister", words: "Always pays his debts", seat: "Lannisport")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }

    func setupUI(){
        self.title = "House"
        let nib = UINib.init(nibName: "HouseTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HouseTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Se ha hecho tap en la celda con seccion \(indexPath.section) y fila \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
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
