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
    
    override func awakeFromNib() {
        //se ejecuta cuando se ha cogido la celda se instancia
        
        thumb.layer.cornerRadius = 2.0
        thumb.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        thumb.layer.borderWidth = 1.0
        rateButton.layer.cornerRadius = 4
        
    }
    
}
