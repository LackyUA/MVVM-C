//
//  EpisodeResponse.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 12.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import Foundation

struct EpisodesResponse: Codable {
    
    let info: PaginationInfo
    let episodes: [EpisodeResponse]
    
    enum CodingKeys: String, CodingKey {
        case info
        case episodes = "results"
    }
    
}

struct EpisodeResponse: Codable, ListedModel {
    
    let id: Int
    let name: String
    let releaseDate: String
    let abbreviation: String
    let characters: [String]
    let url: String
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case releaseDate = "air_date"
        case abbreviation = "episode"
        case characters
        case url
        case created
    }
    
}
