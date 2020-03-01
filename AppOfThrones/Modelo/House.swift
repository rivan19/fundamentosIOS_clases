//
//  House.swift
//  AppOfThrones
//
//  Created by Ivan Llopis Guardado on 18/02/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import Foundation

struct House: CustomStringConvertible, Equatable, Decodable, Identifiable {
    
    // MARK: - Equatable
    static func == (lhs: House, rhs: House) -> Bool {
        lhs.id == rhs.id
    }
    
    // MARK: CustomStringConvertible
    var description: String {
        return """
        id: \(id)
        imageName: \(imageName ?? "")
        name: \(name ?? "")
        words: \(words ?? "")
        seat: \(seat)
        """
    }
    
    var id: Int
    var imageName: String?
    var name: String?
    var words: String?
    var seat: String
}
