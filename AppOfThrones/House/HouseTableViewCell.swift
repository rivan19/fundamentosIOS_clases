//
//  HouseTableViewCell.swift
//  AppOfThrones
//
//  Created by Ivan Llopis Guardado on 18/02/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class HouseTableViewCell: UITableViewCell {
    @IBOutlet weak var imageName: UIImageView!
    @IBOutlet weak var nameHouse: UILabel!
    @IBOutlet weak var words: UILabel!
    @IBOutlet weak var seat: UILabel!
    @IBOutlet weak var heart: UIButton!
    
    private var house: House?
    var delegate: FavoriteDelegate?
    var selectCell: (() -> Void)?
    
    override func awakeFromNib() {
        
        imageName.layer.cornerRadius = 8
        imageName.layer.borderWidth = 1.0
        imageName.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
    }
    
    @IBAction func favoriteAction(_ sender: Any) {
        
        if let hs = self.house {
            if DataController.shared.isFavorite(hs) {
                DataController.shared.removeFavorite(hs)
            } else {
                DataController.shared.addFavorite(hs)
            }
            
            let noteName = Notification.Name("DidFavoritesUpdated")
            
            NotificationCenter.default.post(name: noteName, object: nil)
            
            delegate?.didFavoriteChanged()
        }
    }
    
    
    func setHouse(_ house: House) {
        self.house = house
        
        let heartImageNamed = DataController.shared.isFavorite(house) ? "heart.fill" : "heart"
        
        let heartImage = UIImage.init(systemName: heartImageNamed)
        self.heart.setImage(heartImage, for: .normal)
        
        self.imageName.image = UIImage.init(named: house.imageName ?? "")
        
        self.nameHouse.text = house.name
        self.words.text = house.words
        self.seat.text = house.seat
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.selectCell?()
    }
}
