//
//  Rating.swift
//  AppOfThrones
//
//  Created by Ivan Llopis Guardado on 18/02/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import Foundation


enum Rate {
    case unrated
    case rated(value: Double)
}

struct Rating:  CustomStringConvertible, Equatable {
    
    // MARK: - Equatable
    static func == (lhs: Rating, rhs: Rating) -> Bool {
        lhs.id == rhs.id
    }
    
    // MARK: CustomStringConvertible
    var description: String {
        return """
        id: \(id)
        rate: \(rate)
        """
    }
    
    var id: Int
    var rate: Rate
}
