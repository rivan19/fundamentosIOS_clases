//
//  Cast.swift
//  AppOfThrones
//
//  Created by Ivan Llopis Guardado on 17/02/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import Foundation

struct Cast: Identifiable, Codable, CustomStringConvertible, Equatable {
    
    // MARK: - Equatable
    static func == (lhs: Cast, rhs: Cast) -> Bool {
        lhs.id == rhs.id
    }
    
    // MARK: CustomStringConvertible
    var description: String {
        return """
        id: \(id)
        avatar: \(avatar ?? "")
        fullname: \(fullname ?? "")
        role: \(role ?? "")
        episode: \(String(describing: episode))
        birth: \(birth ?? "")
        placeBirth: \(placeBirth ?? "")
        """
    }
    
    var id: Int
    var avatar: String?
    var fullname: String?
    var role: String?
    var episode: Int?
    var birth: String?
    var placeBirth: String?
    
}
