//
//  CharacterCellViewModel.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 12.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import Foundation

protocol CharacterCellViewModelType: CellViewModelProtocol {
    
    // MARK: - Data source
    
    /// Character's name.
    var name: String { get }
    
    /// Character's gender.
    var gender: String { get }
    
    /// Character's status. Posible statuses: alive, dead, unknown.
    var characterStatus: CharacterStatus { get }

}

final class CharacterCellViewModel {
    
    // MARK: - Properties
    
    private let character: CharacterResponse
    
    // MARK: - Inits
    
    init(character: CharacterResponse) {
        self.character = character
    }
    
}

extension CharacterCellViewModel: CharacterCellViewModelType {
    
    var name: String {
        return character.name
    }
    
    var gender: String {
        return character.gender.trimmingCharacters(in: .whitespacesAndNewlines).capitalized
    }
    
    var characterStatus: CharacterStatus {
        return CharacterStatus(rawValue: character.status) ?? .unknown
    }
    
}
