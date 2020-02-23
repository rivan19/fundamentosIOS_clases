//
//  DataController.swift
//  AppOfThrones
//
//  Created by Ivan Llopis Guardado on 17/02/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import Foundation

protocol FavoriteDelegate: class {
    func didFavoriteChanged()
}

protocol Identifiable {
    var id: Int {get}
}

class DataController {
    
    //var rating: [Rating] = []
    
    static var shared = DataController()
    private init() {}
    
    private var rating: [Rating] = []
    private var favorite: [Int] = []
    private var favoriteC: [Int] = []
    
    func getArrayFavorite<T: Identifiable>(_ value: T) -> [Int] {
        if let _ = value as? Cast {
            return favoriteC
        }
        else if let _ = value as? Episode {
            return favorite
        } else {
            return favorite
        }
    }
    
    func isFavorite<T: Identifiable>(_ value: T) -> Bool {
        /*if let _ = value as? Cast {
            return favoriteC.contains(value.id)
        }
        else if let _ = value as? Episode {
            return favorite.contains(value.id)
        }
        else
        {
            return favorite.contains(value.id)
        }*/
        
        return getArrayFavorite(value).contains(value.id)
        
    }
    
    func addFavorite<T: Identifiable>(_ value: T) {
        if self.isFavorite(value) == false {
            favorite.append(value.id)
        }
    }
    
    func removeFavorite<T: Identifiable>(_ value: T){
        if let index = favorite.firstIndex(of: value.id) {
            favorite.remove(at: index)
        }
    }
    
    
    // MARK: - Favorite
    
    func cleanFavorite() {
        favorite = []
    }
    
    // MARK: - Rating
    func rateEpisode(_ episode: Episode, value: Double) {
        if self.ratingForEpisode(episode) == nil {
            let rateValue = Rating.init(id: episode.id, rate: Rate.rated(value: value))
            rating.append(rateValue)
        }
    }
    
    func removeRateEpisode(_ episode: Episode) {
        if let index = self.rating.firstIndex(where: { (rating) -> Bool in
            return episode.id == rating.id
        }) {
            self.rating.remove(at: index)
        }
    }
    
    func ratingForEpisode(_ episode: Episode) -> Rating? {
        let filtered = rating.filter {
            $0.id == episode.id
        }
        
        return filtered.first
    }
    
    
}
