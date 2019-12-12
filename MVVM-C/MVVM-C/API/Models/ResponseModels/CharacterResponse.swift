//
//  CharacterResponse.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 09.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import Foundation

struct CharactersResponse: Codable {
    
    var info: CharacterInfo
    var characters: [CharacterResponse]
    
    enum CodingKeys: String, CodingKey {
        
        case info
        case characters = "results"
        
    }
    
}

struct CharacterInfo: Codable {
    
    var count: Int = 0
    var pages: Int = 0
    var next: String = ""
    var prev: String = ""
    
}

struct CharacterResponse: Codable {
    
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: CharacterLocation
    var location: CharacterLocation
    var image: String
    var episode: [String]
    var url: String
    var created: String
    
}

struct CharacterLocation: Codable {
    
    var name: String
    var url: String
    
}

enum CharacterStatus: String {
    
    case alive = "Alive"
    case dead = "Dead"
    case unknown
    
}
