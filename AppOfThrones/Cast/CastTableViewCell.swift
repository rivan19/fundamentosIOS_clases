//
//  CastTableViewCell.swift
//  AppOfThrones
//
//  Created by Ivan Llopis Guardado on 17/02/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit



class CastTableViewCell: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var role: UILabel!
    @IBOutlet weak var episodes: UILabel!
    @IBOutlet weak var heart: UIButton!
    
    private var cast: Cast?
    var delegate: FavoriteDelegate?
    
    override func awakeFromNib() {
        avatar.layer.cornerRadius = 8.0
        avatar.layer.borderWidth = 1.0
        avatar.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
    }
    
    
    func setCast(_ cast: Cast) {
        self.cast = cast
        let heartImageNamed = DataController.shared.isFavorite(cast) ? "heart.fill" : "heart"
        
        let heartImage = UIImage.init(systemName: heartImageNamed)
        self.heart.setImage(heartImage, for: .normal)
        
        self.episodes.text = "\(cast.episode ?? 0) episodes"
        self.name.text = cast.fullname
        self.role.text = cast.role
        self.avatar.image = UIImage.init(named: cast.avatar ?? "")
        
        
    }
    
    // MARK: - IBActions
    
    @IBAction func favoriteAction(_ sender: Any) {
        if let cast = self.cast {
            if DataController.shared.isFavorite(cast){
                DataController.shared.removeFavorite(cast)
            } else {
                DataController.shared.addFavorite(cast)
            }
            
            let noteName = Notification.Name(rawValue: "DidFavoritesUpdated")
            NotificationCenter.default.post(name: noteName, object: nil)
            
            delegate?.didFavoriteChanged()
        }
    }
}
