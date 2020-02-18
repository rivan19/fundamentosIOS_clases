//
//  RateViewController.swift
//  AppOfThrones
//
//  Created by Ivan Llopis Guardado on 11/02/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

protocol RateViewCellDelegate {
    func didRateChanged()
}

class RateViewController: UIViewController {
    
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var star01: UIImageView!
    @IBOutlet weak var star02: UIImageView!
    @IBOutlet weak var star03: UIImageView!
    @IBOutlet weak var star04: UIImageView!
    @IBOutlet weak var star05: UIImageView!
    @IBOutlet weak var rateSlider: UISlider!
    
    private var episode: Episode?
    var delegate: RateViewCellDelegate?
    
    convenience init(withEpisode episode: Episode) {
        self.init()
        
        self.episode = episode
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.confirmButton.layer.cornerRadius = 4.0
        self.title = "Rate"
        
    }
    
    @IBAction func accept() {
        // code
        print("Aceptando!!")
        let rate = Double(Int(rateSlider.value * 5)/10)
        
        if let episode = self.episode {
            DataController.shared.rateEpisode(episode, value: rate)
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        
        self.delegate?.didRateChanged()
    }
    
    // MARK: -IBActions
    
    @IBAction func sliderFire(_ sender: Any) {
        let valueDouble = Double(rateSlider.value)
        self.setRating(valueDouble)
    }
    
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Rating
    func setRating(_ rating: Double) {
        
        rateLabel.text = String(Int(rating/2))
        self.setStartImage(star01, rating: rating/2, minValue: 0)
        self.setStartImage(star02, rating: rating/2, minValue: 2)
        self.setStartImage(star03, rating: rating/2, minValue: 4)
        self.setStartImage(star04, rating: rating/2, minValue: 6)
        self.setStartImage(star05, rating: rating/2, minValue: 8)
        
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


