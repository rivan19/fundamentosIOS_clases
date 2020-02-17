//
//  RateViewController.swift
//  AppOfThrones
//
//  Created by Ivan Llopis Guardado on 11/02/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class RateViewController: UIViewController {
    
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var confirmButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.confirmButton.layer.cornerRadius = 4.0
        self.title = "Rate"
        
    }
    
    @IBAction func accept() {
        // code
        print("Aceptando!!")
        
        
    }
    
    @IBAction func fire(_ sender: Any) {
        print("Fire!! \(sender)")
        let valueInt = Int(slider.value)
        self.rateLabel.text = "\(valueInt)"
    }
    
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
    }
    
}


