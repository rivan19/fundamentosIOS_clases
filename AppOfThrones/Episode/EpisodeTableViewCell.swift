//
//  EpisodeTableViewCell.swift
//  AppOfThrones
//
//  Created by Ivan Llopis Guardado on 17/02/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit



class EpisodeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var star01: UIImageView!
    @IBOutlet weak var star02: UIImageView!
    @IBOutlet weak var star03: UIImageView!
    @IBOutlet weak var star04: UIImageView!
    @IBOutlet weak var star05: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    
    var rateBlock: (() -> Void)?
    private var episode:Episode?
    var delegate: FavoriteDelegate?
    
    override func awakeFromNib() {
        //se ejecuta cuando se ha cogido la celda se instancia
        
        thumb.layer.cornerRadius = 2.0
        thumb.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        thumb.layer.borderWidth = 1.0
        rateButton.layer.cornerRadius = 4
        
    }
    
    @IBAction func fireFavorite(_ sender: Any) {
        if let episode = self.episode {
            if DataController.shared.isFavorite(episode){
                DataController.shared.removeFavorite(episode)
            } else {
                DataController.shared.addFavorite(episode)
            }
            delegate?.didFavoriteChanged()
        }
        
    }
    
    
    func setEpisode(_ episode: Episode) {
        self.episode = episode
        let heartImageNamed = DataController.shared.isFavorite(episode) ? "heart.fill" : "heart"
        
        let heartImage = UIImage.init(systemName: heartImageNamed)
        self.heartButton.setImage(heartImage, for: .normal)
        
        thumb.image = UIImage.init(named: episode.image ?? "")
        title.text = episode.name
        date.text = episode.date
        
        if let rating = DataController.shared.ratingForEpisode(episode) {
            switch rating.rate {
            case .rated(let value):
                self.setRating(value)
            case .unrated:
                self.modeRate()
            }
        } else {
            modeRate()
        }
    }
    
    @IBAction func fireRate(_ sender: Any) {
        self.rateBlock?()
    }
    
    // MARK: - Rating
    func modeRate() {
        rateButton.isHidden = false
        star01.isHidden = true
        star02.isHidden = true
        star03.isHidden = true
        star04.isHidden = true
        star05.isHidden = true
    }
    
    func modeStar() {
        rateButton.isHidden = true
        star01.isHidden = false
        star02.isHidden = false
        star03.isHidden = false
        star04.isHidden = false
        star05.isHidden = false
    }
    
    // MARK: Rating
    func setRating(_ rating: Double) {
        
        self.modeStar()
        
        self.setStartImage(star01, rating: rating, minValue: 0)
        self.setStartImage(star02, rating: rating, minValue: 2)
        self.setStartImage(star03, rating: rating, minValue: 4)
        self.setStartImage(star04, rating: rating, minValue: 6)
        self.setStartImage(star05, rating: rating, minValue: 8)
        
    }
    
    func setStartImage(_ imageView: UIImageView, rating: Double, minValue: Int) {
        
        if Int(rating) >= (minValue + 1) && Int(rating) < (minValue + 2) {
            imageView.image = UIImage.init(systemName: "star.lefthalf.fill")
        } else if Int(rating) >= (minValue + 2) {
            imageView.image = UIImage.init(systemName: "star.fill")
        } else {
            imageView.image = UIImage.init(systemName: "star")
        }
    }
}
