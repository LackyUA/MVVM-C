//
//  EpisodesListViewModel.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 12.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import Foundation

final class EpisodesListViewModel {
    
    // MARK: - Weak properties
    
    weak var viewDelegate: ListViewModelDelegate?
    weak var coordinatorDelegate: ListCoordinatorDelegate?
    
    // MARK: - Properties
    
    var isLoadingMore = false
    var service: EpisodeServiceProtocol
    var info: PaginationInfo = PaginationInfo()
    
    var episodes: [EpisodeResponse] = [] {
        didSet {
            viewDelegate?.reloadTableView()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            viewDelegate?.updateLoadingStatus(isLoading)
        }
    }
    
    var page: Int = 0 {
        didSet {
            fetchCharacters(from: page)
        }
    }
    
    // MARK: - Init
    
    init(service: EpisodeServiceProtocol) {
        self.service = service
    }
    
    // MARK: - Network
    
    private func fetchCharacters(from page: Int) {
        service.getEpisodes(from: page) { [weak self] response in
            self?.isLoading = false
            self?.isLoadingMore = false
            
            if let response = response {
                self?.episodes += response.episodes
                self?.info = response.info
            }
        }
    }
    
}

extension EpisodesListViewModel: ListViewModelType {
    
    // MARK: - Data Source
    
    var numberOfCells: Int {
        return episodes.count
    }
    
    var shouldLoadMore: Bool {
        return page != info.pages
    }
    
    func viewModelFor(row: Int) -> EpisodesListViewModel.CellViewModel {
        return EpisodeCellViewModel(episode: episodes[row])
    }
    
    // MARK: - Events
    
    func start() {
        page = 1
    }
    
    func didSelect(row: Int) {
        coordinatorDelegate?.didSelect(data: episodes[row])
    }
    
    func reloadData() {
        isLoading = true
        episodes.removeAll()
        start()
    }
    
    func loadMore() {
        if !isLoadingMore {
            isLoadingMore = true
            
            if page < info.pages {
                page += 1
            }
        }
    }
    
}

