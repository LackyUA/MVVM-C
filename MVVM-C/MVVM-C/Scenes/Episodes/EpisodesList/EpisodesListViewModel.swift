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
            fetchEpisodes(from: page)
        }
    }
    
    // MARK: - Init
    
    init(service: EpisodeServiceProtocol) {
        self.service = service
    }
    
    // MARK: - Network
    
    private func fetchEpisodes(from page: Int) {
        service.getEpisodes(from: page) { [weak self] result in
            self?.isLoading = false
            self?.isLoadingMore = false
            
            switch result {
            case .success(let response):
                if let response = response {
                    self?.episodes += response.episodes
                    self?.info = response.info
                }
                
            case .noInternet:
                break
                
            case .error:
                AppCoordinator.instance.showErroAlert(with: "Please try again later.")
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
        if !isLoadingMore, page < info.pages {
            isLoadingMore = true
            page += 1
        }
    }
    
}
