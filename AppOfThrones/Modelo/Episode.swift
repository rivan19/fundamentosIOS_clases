//
//  Episode.swift
//  AppOfThrones
//
//  Created by Ivan Llopis Guardado on 13/02/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import Foundation

class Episode: Identifiable, Codable, CustomStringConvertible, Equatable {
    
    // MARK: - Equatable
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        lhs.id == rhs.id
    }
    
    // MARK: CustomStringConvertible
    var description: String {
        return """
        id: \(id)
        Name: \(name ?? "")
        date: \(date ?? "")
        image: \(image ?? "")
        episode: \(episode)
        season: \(season)
        overview: \(overview)
        """
    }
    
    
    var id: Int
    var name: String?
    var date: String?
    var image: String?
    var episode: Int
    var season: Int
    var overview: String
    
    init(id: Int, name: String?, date: String?, image: String?, episode: Int, season: Int, overview: String) {
        self.id = id
        self.name = name
        self.date = date
        self.image = image
        self.episode = episode
        self.season = season
        self.overview = overview
    }
    
    
    
}
