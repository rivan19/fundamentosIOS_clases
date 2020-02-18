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
    
    
    override func awakeFromNib() {
        imageName.layer.cornerRadius = 8
        imageName.layer.borderWidth = 1.0
        imageName.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
    }
    
    func setHouse(_ house: House) {
        self.imageName.image = UIImage.init(named: house.imageName ?? "")
        self.nameHouse.text = house.name
        self.words.text = house.words
        self.seat.text = house.seat
    }
}
