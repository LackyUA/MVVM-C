//
//  LocationResponse.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 16.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import Foundation

struct LocationsResponse: Codable {
    
    let info: PaginationInfo
    let locations: [LocationResponse]
    
    enum CodingKeys: String, CodingKey {
        case info
        case locations = "results"
    }
    
}

struct LocationResponse: Codable, ListedModel {
    
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
    
}
