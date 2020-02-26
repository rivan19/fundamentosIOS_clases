//
//  House.swift
//  AppOfThrones
//
//  Created by Ivan Llopis Guardado on 18/02/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import Foundation

struct House: CustomStringConvertible, Equatable, Decodable {
    
    // MARK: - Equatable
    static func == (lhs: House, rhs: House) -> Bool {
        lhs.name == rhs.name
    }
    
    // MARK: CustomStringConvertible
    var description: String {
        return """
        imageName: \(imageName ?? "")
        name: \(name ?? "")
        words: \(words ?? "")
        seat: \(seat)
        """
    }
    
    var imageName: String?
    var name: String?
    var words: String?
    var seat: String
}
