//
//  Cast.swift
//  AppOfThrones
//
//  Created by Ivan Llopis Guardado on 17/02/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import Foundation

struct Cast: Identifiable, Codable {
    var id: Int
    var avatar: String?
    var fullName: String?
    var role: String?
    var episode: Int?
    var birth: String?
    var placeBirth: String?
    
}
