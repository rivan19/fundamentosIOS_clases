//
//  EpisodeDetailViewController.swift
//  AppOfThrones
//
//  Created by Ivan Llopis Guardado on 23/02/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var episode: Episode?
    var delegate: FavoriteDelegate?
    @IBOutlet weak var tableView: UITableView!
    
    convenience init(withEpisode episode: Episode){
        self.init()
        
        self.episode = episode
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        let nibImage = UINib.init(nibName: "ImageTableViewCell", bundle: nil)
        let nibDetail = UINib.init(nibName: "EpisodeDetailTableViewCell", bundle: nil)
        
        self.tableView.register(nibImage, forCellReuseIdentifier: "ImageTableViewCell")
        self.tableView.register(nibDetail, forCellReuseIdentifier: "EpisodeDetailTableViewCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    @objc func heartButtonAction(_ sender: UIButton) -> Void {
        if let episode = self.episode {
            if DataController.shared.isFavorite(episode){
                DataController.shared.removeFavorite(episode)
            } else {
                DataController.shared.addFavorite(episode)
            }
            
            sender.setImage(UIImage(systemName: DataController.shared.getImageHeart(episode)), for: .normal)
        }
        
        delegate?.didFavoriteChanged()
    }
    
    @objc func closeViewController(_ sender: Any) {
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
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as? ImageTableViewCell {
                if let ep = episode {
                    cell.episodeImage.image = UIImage.init(named: ep.image ?? "")
                }
                
                return cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeDetailTableViewCell", for: indexPath) as? EpisodeDetailTableViewCell{
                if let ep = episode {
                    cell.dateLabel.text = ep.date
                    cell.episodeLabel.text = "\(ep.episode)"
                    cell.seasonLabel.text = "\(ep.season)"
                    cell.overviewTextView.text = ep.overview
                }
                
                return cell
                
            }
        }
        
        fatalError("Could not create the Episode cell")
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 208
        default:
            return 500
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}
