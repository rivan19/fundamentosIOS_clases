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
    private var houses: [House] = []
    private let sections: [String] = ["Episodes", "Cast", "House"]
    
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
        setupDataFavorite()
    }
    
    func setupDataFavorite() {
        episodes = DataController.shared.episodeFavorite ?? []
        casts = DataController.shared.castsFavorite ?? []
        houses = DataController.shared.houseFavorite ?? []
        
        favoritesTableView.reloadData()
    }
    
    func setupUI() {
        let nibEpisode = UINib.init(nibName: "EpisodeTableViewCell", bundle: nil)
        favoritesTableView.register(nibEpisode, forCellReuseIdentifier: "EpisodeTableViewCell")
        
        let nibCast = UINib.init(nibName: "CastTableViewCell", bundle: nil)
        favoritesTableView.register(nibCast, forCellReuseIdentifier: "CastTableViewCell")
        
        let nibHouse = UINib.init(nibName: "HouseTableViewCell", bundle: nil)
        favoritesTableView.register(nibHouse, forCellReuseIdentifier: "HouseTableViewCell")
        
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
    }
    
    // MARK: -UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
            return 3
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section == 0){
            return episodes.count
        }else if (section == 1){
            return casts.count
        }else if (section == 2){
            return houses.count
        }
        
        fatalError("Error: numberOfRowsInSection")
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0)
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeTableViewCell", for: indexPath) as? EpisodeTableViewCell {
                let ep = episodes[indexPath.row]
                cell.setEpisode(ep)
                cell.delegate = self
                
                cell.selectCell = { () -> Void in
                    
                    let episodeDetailViewController = EpisodeDetailViewController.init(withEpisode: ep)
                    
                    let navigationDetailController = UINavigationController.init(rootViewController: episodeDetailViewController)
                    
                    episodeDetailViewController.title = ep.name ?? ""
                    
                    let rightButtonBar = DataController.shared.getRightBarButtonItem(ep, view: episodeDetailViewController)
                    
                    let leftButtonBar = DataController.shared.getLeftBarButtonItem(ep, view: episodeDetailViewController, image: "xmark.circle.fill")
                    
                    episodeDetailViewController.navigationItem.rightBarButtonItem = rightButtonBar
                    episodeDetailViewController.navigationItem.leftBarButtonItem = leftButtonBar
                    
                    episodeDetailViewController.delegate = self
                    
                    self.present(navigationDetailController, animated: true, completion: nil)
                }
                
                cell.rateBlock = { () -> Void in
                    let rateViewController = RateViewController.init(withEpisode: ep)
                    let navigationController = UINavigationController.init(rootViewController: rateViewController)
                    
                    let leftBarItem = DataController.shared.getLeftBarButtonItem(ep, view: rateViewController, image: "xmark.circle.fill")
                    
                    rateViewController.navigationItem.leftBarButtonItem = leftBarItem
                    
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
        }
        else if (indexPath.section == 2) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HouseTableViewCell", for: indexPath) as? HouseTableViewCell {
                let house = houses[indexPath.row]
                cell.setHouse(house)
                cell.delegate = self
                
                cell.selectCell = { () -> Void in
                    
                    let houseViewController = HouseDetailViewController.init(house: house)
                    houseViewController.delegate = self
                    
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
        }
        
        fatalError("Could not create the Episode cell")
    }
    
    
    //MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0)
        {
            return 123
        }
        else if (indexPath.section == 1)
        {
            return 135
        }
        else if (indexPath.section == 2){
            return 135
        }
        
        fatalError("Error: heightForRowAt")
    }
        
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let vista = UIView.init()
        
        vista.layer.cornerRadius = 3.0
        vista.layer.borderWidth = 1.0
        vista.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        
        let title = UILabel.init(frame: CGRect.init(x: 10, y: 0, width: 200, height: 30))
        title.font = UIFont.init(name: "Verdana", size: 15.0)
        title.text = sections[section]
        
        vista.backgroundColor = .black
        
        title.textColor = .white
        
        vista.addSubview(title)
        
        return vista
    
    }

}
