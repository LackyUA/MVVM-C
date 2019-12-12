//
//  CharacterDetailsViewModel.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 11.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import Foundation

protocol CharacterDetailsViewModelType {
    
    // MARK: - Data source
    
    /// Character's name.
    var name: String { get }
    
    /// Character's photo url.
    var photoPath: String { get }
    
    /// Character's status.
    var status: String { get }
    
    /// Character's species.
    var species: String { get }
    
    /// Character's gender.
    var gender: String { get }
    
    /// Character's current location name.
    var currentLocation: String { get }
    
}

final class CharacterDetailsViewModel {
    
    // MARK: - Properties
    
    private let character: CharacterResponse
    
    // MARK: - Inits
    
    init(character: CharacterResponse) {
        self.character = character
    }
    
}

extension CharacterDetailsViewModel: CharacterDetailsViewModelType {
    
    var name: String {
        character.name
    }
    
    var photoPath: String {
        return character.image
    }
    
    var status: String {
        return character.status.trimmingCharacters(in: .whitespacesAndNewlines).capitalized
    }
    
    var species: String {
        return character.species.trimmingCharacters(in: .whitespacesAndNewlines).capitalized
    }
    
    var gender: String {
        return character.gender.trimmingCharacters(in: .whitespacesAndNewlines).capitalized
    }
    
    var currentLocation: String {
        return character.origin.name.trimmingCharacters(in: .whitespacesAndNewlines).capitalized
    }
    
}
