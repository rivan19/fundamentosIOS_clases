//
//  EpisodeDetailViewController.swift
//  AppOfThrones
//
//  Created by Ivan Llopis Guardado on 23/02/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    private var episode: Episode?
    
    convenience init(withEpisode episode: Episode){
        self.init()
        
        self.episode = episode
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    func setupUI() {
        self.title = episode?.name ?? ""
        
    }
}
