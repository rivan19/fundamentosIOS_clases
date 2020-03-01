//
//  DataController.swift
//  AppOfThrones
//
//  Created by Ivan Llopis Guardado on 17/02/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

protocol FavoriteDelegate: class {
    func didFavoriteChanged()
}

@objc protocol RightButtonItemDelegate {
    func heartButtonAction(_ sender: UIButton) -> Void;
}

@objc protocol LeftButtonItemDelegate {
    func closeViewController(_ sender: Any);
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
    private var favoriteH: [Int] = []
    private var houses: [House] = []
    private var casts: [Cast] = []
    private var episodes: [Episode] = []
    private var episodes_sesion: [Int: [Episode]] = [:]
    
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
    
    var houseFavorite: [House]? {
        get {
            return self.setupDataHouseFavorite()
        }
    }
    
    private enum Kind: String {
        case cast = "C"
        case episode = "E"
        case house = "H"
        case other = "O"
    }
    
    private func getKindFavorite<T: Identifiable>(_ value: T) -> Kind {
        if let _ = value as? Cast {
            return Kind.cast
        }
        else if let _ = value as? Episode {
            return Kind.episode
        }
        else if let _ = value as? House {
            return Kind.house
        }
        else {
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
        case .house:
            return favoriteH
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
            case .house:
                favoriteH.append(value.id)
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
                case .house:
                    favoriteH.remove(at: index)
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
        favoriteH = []
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
    
    func cleanRating() {
        self.rating = []
    }
    
    // MARK: - SetupData
    
    func setupDataEpisode(_ seasonNumber: Int) -> [Episode]?{
        if let pathURL = Bundle.main.url(forResource: "season_\(seasonNumber)", withExtension: "json"){
            do {
                let data = try Data.init(contentsOf: pathURL)
                let decoder = JSONDecoder()
                episodes = try decoder.decode([Episode].self, from: data)
                
                episodes_sesion[seasonNumber] = episodes
                
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
    
    // MARK: - Get Favorite Data
    
    func setupDataCastFavorites() -> [Cast]? {
        return casts.filter({favoriteC.contains($0.id)})
    }
    
    func setupDataHouseFavorite() -> [House]? {
        return houses.filter { (house) -> Bool in
            return favoriteH.contains(house.id)
        }
    }
    
    func setupDataEpisodeFavorites() -> [Episode]? {
        
        var episodes_all: [Episode] = []
        
        for (_, value) in episodes_sesion {
            episodes_all += value
        }
        
        episodes_all.sort { (ep1, ep2) -> Bool in
            return (ep1.season, ep1.episode) < (ep2.season, ep2.episode)
        }
        return episodes_all.filter ({favorite.contains($0.id)})
    }
    
    // MARK: - Refactor code. BarButtonItem
    
    func getRightBarButtonItem<T: Identifiable, S: RightButtonItemDelegate>(_ value: T, view: S) -> UIBarButtonItem{
        let heartImageNamed = DataController.shared.getImageHeart(value)
        
        let rightButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        
        rightButton.setImage(UIImage.init(systemName: heartImageNamed), for: .normal)
        rightButton.tintColor = .red
        
        if view is UIViewController {
            rightButton.addTarget(view.self, action: #selector(view.heartButtonAction), for: .touchUpInside)
        }
        
        let rightButtonBar = UIBarButtonItem.init(customView: rightButton)
        
        return rightButtonBar
        
    }
    
    func getLeftBarButtonItem<T: Identifiable, S: LeftButtonItemDelegate>(_ value: T, view: S, image: String?) -> UIBarButtonItem{
        
        let leftButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        leftButton.setImage(UIImage(systemName: image ?? "xmark.circle.fill"), for: .normal)
        leftButton.tintColor = .orange
        
        if view is UIViewController {
            leftButton.addTarget(view.self, action: #selector(view.closeViewController), for: .touchUpInside)
        }
        
        let leftButtonBar = UIBarButtonItem.init(customView: leftButton)
        
        return leftButtonBar
        
    }
}
