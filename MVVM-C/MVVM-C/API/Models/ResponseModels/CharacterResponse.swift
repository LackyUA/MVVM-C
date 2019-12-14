//
//  CharacterResponse.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 09.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import Foundation

struct CharactersResponse: Codable {
    
    let info: PaginationInfo
    let characters: [CharacterResponse]
    
    enum CodingKeys: String, CodingKey {
        
        case info
        case characters = "results"
        
    }
    
}

struct PaginationInfo: Codable {
    
    var count: Int = 0
    var pages: Int = 0
    var next: String = ""
    var prev: String = ""
    
}

struct CharacterResponse: Codable, ListedModel {
    
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: CharacterLocation
    let location: CharacterLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
}

struct CharacterLocation: Codable {
    
    let name: String
    let url: String
    
}

enum CharacterStatus: String {
    
    case alive = "Alive"
    case dead = "Dead"
    case unknown
    
}
