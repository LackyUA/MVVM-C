//
//  CharactersListViewModel.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 10.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import Foundation

final class CharactersListViewModel {
    
    // MARK: - Weak properties
    
    weak var viewDelegate: ListViewModelDelegate?
    weak var coordinatorDelegate: ListCoordinatorDelegate?
    
    // MARK: - Properties
    
    var isLoadingMore = false
    var service: CharacterServiceProtocol
    var info: PaginationInfo = PaginationInfo()
    
    var characters: [CharacterResponse] = [] {
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
    
    init(service: CharacterServiceProtocol) {
        self.service = service
    }
    
    // MARK: - Network
    
    private func fetchCharacters(from page: Int) {
        service.getCharacters(from: page) { [weak self] result in
            self?.isLoading = false
            self?.isLoadingMore = false
            
            switch result {
            case .success(let response):
                if let response = response {
                    self?.characters += response.characters
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

extension CharactersListViewModel: ListViewModelType {
    
    // MARK: - Data Source
    
    var numberOfCells: Int {
        return characters.count
    }
    
    var shouldLoadMore: Bool {
        return page != info.pages
    }
    
    func viewModelFor(row: Int) -> CharactersListViewModel.CellViewModel {
        return CharacterCellViewModel(character: characters[row])
    }
    
    // MARK: - Events
    
    func start() {
        page = 1
    }
    
    func didSelect(row: Int) {
        coordinatorDelegate?.didSelect(data: characters[row])
    }
    
    func reloadData() {
        isLoading = true
        characters.removeAll()
        start()
    }
    
    func loadMore() {
        if !isLoadingMore, page < info.pages {
            isLoadingMore = true
            page += 1
        }
    }
    
}
