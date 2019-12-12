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
        
    }
    
}

// MARK: - Episode

extension API {
    
    enum Episode {
        
    }
    
}
