//
//  EpisodeViewController.swift
//  AppOfThrones
//
//  Created by Ivan Llopis Guardado on 13/02/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {
    
    var episodes: [Episode] = [Episode.init(id: 1, name: "Winter Is Comming", date: "April 17, 2011", image: "episodeTest", episode: 1, season: 1, overview: "Jon Arryn, the Hand of the King, is dead. King Robert...")]
    
    
    
    @IBAction func openRate(_ sender: Any) {
        //Codigo para abrir pantalla Rate
    }
    
    
}
