//
//  EpisodeCellViewModel.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 14.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import Foundation

protocol EpisodeCellViewModelType: CellViewModelProtocol {
    
    // MARK: - Data source
    
    /// Episode's name.
    var name: String { get }
    
    /// Episode's release date.
    var releaseDate: String { get }
    
    /// Episode's abbreviation.
    var abbreviation: String { get }

}

final class EpisodeCellViewModel {
    
    // MARK: - Properties
    
    private let episode: EpisodeResponse
    
    // MARK: - Inits
    
    init(episode: EpisodeResponse) {
        self.episode = episode
    }
    
}

extension EpisodeCellViewModel: EpisodeCellViewModelType {
    
    var name: String {
        return episode.name.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var releaseDate: String {
        return episode.releaseDate.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var abbreviation: String {
        return episode.abbreviation.lowercased()
    }
    
}
