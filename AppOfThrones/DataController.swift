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
    private var houses: [House] = []
    private var casts: [Cast] = []
    private var episodes: [Episode] = []
    
    var castsFavorite: [Cast]? {
        get {
            return self.setupDataCastFavorites()
        }
    }
    var episodeFavorite: [Episode]? {
        get {
            return self.setupDataEpisodeFavorites()
        }
    }
    
    private enum Kind: String {
        case cast = "C"
        case episode = "E"
        case other = "O"
    }
    
    private func getKindFavorite<T: Identifiable>(_ value: T) -> Kind {
        if let _ = value as? Cast {
            return Kind.cast
        }
        else if let _ = value as? Episode {
            return Kind.episode
        } else {
            return Kind.other
        }
    }
    
    func getImageHeart<T: Identifiable>(_ value: T) -> String {
        return self.isFavorite(value) ? "heart.fill" : "heart"
    }
    
    func getArrayFavorite<T: Identifiable>(_ value: T) -> [Int] {
        
        switch getKindFavorite(value) {
        case .cast:
            return favoriteC
        case .episode:
            return favorite
        default:
            return favorite
        }
    }
    
    func isFavorite<T: Identifiable>(_ value: T) -> Bool {
        return getArrayFavorite(value).contains(value.id)
    }
    
    func addFavorite<T: Identifiable>(_ value: T) {
        if self.isFavorite(value) == false {
            switch getKindFavorite(value) {
            case .cast:
                favoriteC.append(value.id)
            case .episode:
                favorite.append(value.id)
            default:
                favorite.append(value.id)
            }
        }
    }
    
    func removeFavorite<T: Identifiable>(_ value: T){
        if let index = getArrayFavorite(value).firstIndex(of: value.id) {
            if self.isFavorite(value) == true {
                switch getKindFavorite(value) {
                case .cast:
                    favoriteC.remove(at: index)
                case .episode:
                    favorite.remove(at: index)
                default:
                    favorite.remove(at: index)
                }
            }
        }
    }
    
    
    // MARK: - Favorite
    
    func cleanFavorite() {
        favorite = []
        favoriteC = []
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
    
    // MARK: - SetupData
    
    func setupDataEpisode(_ seasonNumber: Int) -> [Episode]?{
        if let pathURL = Bundle.main.url(forResource: "season_\(seasonNumber)", withExtension: "json"){
            do {
                let data = try Data.init(contentsOf: pathURL)
                let decoder = JSONDecoder()
                episodes = try decoder.decode([Episode].self, from: data)
                
                return episodes

            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("Could not build the path url for Episode")
        }
        
    }
    
    func setupDataCast() -> [Cast]?{
        if let pathURL = Bundle.main.url(forResource: "cast", withExtension: "json")
        {
            do {
                
                let data = try Data.init(contentsOf: pathURL)
                let decoder = JSONDecoder()
                casts = try decoder.decode([Cast].self, from: data)
                
                return casts
                
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("Could not build the path url for Cast")
        }
        
    }
    
    func setupDataHouse() -> [House]?
    {
        if let pathURL = Bundle.main.url(forResource: "houses", withExtension: "json")
        {
            do {
                
                let data = try Data.init(contentsOf: pathURL)
                let decoder = JSONDecoder()
                houses = try decoder.decode([House].self, from: data)
                
                return houses
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("Could not build the path url for Cast")
        }
    }
    
    func setupDataCastFavorites() -> [Cast]? {
        return casts.filter({favoriteC.contains($0.id)})
    }
    
    func setupDataEpisodeFavorites() -> [Episode]? {
        return episodes.filter ({favorite.contains($0.id)})
    }
}
