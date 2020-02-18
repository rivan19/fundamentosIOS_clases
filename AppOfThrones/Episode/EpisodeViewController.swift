//
//  EpisodeViewController.swift
//  AppOfThrones
//
//  Created by Ivan Llopis Guardado on 13/02/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RateViewCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var episodes: [Episode] = [Episode.init(id: 1, name: "Winter Is Comming", date: "April 17, 2011", image: "historia-de-la-casa-Targaryen", episode: 1, season: 1, overview: "Jon Arryn, the Hand of the King, is dead. King Robert..."), Episode.init(id: 2, name: "Winter Is Comming Too", date: "April 17, 2011", image: "historia-de-la-casa-Targaryen 2", episode: 2, season: 1, overview: "Jon Arryn, the Hand of the King, is dead. King Robert...")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.title = "Seasons"
        
        let nib = UINib.init(nibName: "EpisodeTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "EpisodeTableViewCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    // MARK: - EpisodeTableViewCellDelegate
    func didRateChanged() {
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
            
            cell.rateBlock = { () -> Void in
                let rateViewController = RateViewController.init(withEpisode: ep)
                let navigationController = UINavigationController.init(rootViewController: rateViewController)
                navigationController.title = ep.name ?? "Rate"
                rateViewController.delegate = self
                self.present(navigationController, animated: true, completion: nil)
            }
            return cell
        }
        
        fatalError("Could not create the Episode cell")
    }
    
}
