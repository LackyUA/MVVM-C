//
//  API.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 09.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import Foundation
import Alamofire

enum API {}

// MARK: - Character

extension API {
    
    enum Character {
        
        static func getCharacters(from page: Int) -> Endpoint<CharactersResponse> {
            let query: [String: Any] = ["page": page]
            
            return Endpoint(method: .get, path: "/character/", queryItems: query)
        }
        
    }
    
}

// MARK: - Location

extension API {
    
    enum Location {
        
        static func getLocations(from page: Int) -> Endpoint<LocationsResponse> {
            let query: [String: Any] = ["page": page]
            
            return Endpoint(method: .get, path: "/location/", queryItems: query)
        }
        
    }
    
}

// MARK: - Episode

extension API {
    
    enum Episode {
        
        static func getEpisodes(from page: Int) -> Endpoint<EpisodesResponse> {
            let query: [String: Any] = ["page": page]
            
            return Endpoint(method: .get, path: "/episode/", queryItems: query)
        }
        
    }
    
}
