//
//  CastDetailViewController.swift
//  AppOfThrones
//
//  Created by Ivan Llopis Guardado on 25/02/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class CastDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var cast: Cast?
    var delegate: FavoriteDelegate?
    @IBOutlet weak var tableCastDetail: UITableView!
    
    
    convenience init(_ cast: Cast?){
        self.init()
        self.cast = cast
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI(){
        let nibImage = UINib.init(nibName: "ImageCastDetailTableViewCell", bundle: nil)
        let nibDetail = UINib.init(nibName: "CastDetailTableViewCell", bundle: nil)
        
        self.tableCastDetail.register(nibImage, forCellReuseIdentifier: "ImageCastDetailTableViewCell")
        self.tableCastDetail.register(nibDetail, forCellReuseIdentifier: "CastDetailTableViewCell")
        
        self.tableCastDetail.delegate = self
        self.tableCastDetail.dataSource = self
    }
    
    @objc func heartButtonAction(_ sender: UIButton) -> Void {
        if let cast = self.cast {
            if DataController.shared.isFavorite(cast){
                DataController.shared.removeFavorite(cast)
            } else {
                DataController.shared.addFavorite(cast)
            }
            
            sender.setImage(UIImage(systemName: DataController.shared.getImageHeart(cast)), for: .normal)
        }
        
        let noteName = Notification.Name(rawValue: "DidFavoritesUpdated")
        NotificationCenter.default.post(name: noteName, object: nil)
        
        delegate?.didFavoriteChanged()
    }
    
    @objc func close(_ sender: UIButton) -> Void {
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
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCastDetailTableViewCell", for: indexPath) as? ImageCastDetailTableViewCell {
                if let cst = cast {
                    cell.castImageView.image = UIImage.init(named: cst.avatar ?? "")
                }
                
                return cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CastDetailTableViewCell", for: indexPath) as? CastDetailTableViewCell{
                if let cst = cast {
                    cell.roleLabel.text = cst.role
                    if let episode = cst.episode {
                        cell.birthLabel.text = "\(episode)"
                    } else {
                        cell.birthLabel.text = ""
                    }
                    cell.birthLabel.text = cst.birth
                    cell.placeBithTextView.text = cst.placeBirth
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
            return 330
        default:
            return 500
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}
