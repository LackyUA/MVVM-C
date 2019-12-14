//
//  Session.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 09.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import Foundation

final class Session {
    
    // MARK: - Properties
    
    let apiClient: APIClient
    
    let characterService: CharacterService
    let episodeService: EpisodeService
    
    // MARK: - Initializers
    
    init() {
        apiClient = APIClient()
        
        characterService = CharacterService()
        episodeService = EpisodeService()
    }
    
}
