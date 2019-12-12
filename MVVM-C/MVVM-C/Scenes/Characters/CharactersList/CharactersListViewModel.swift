//
//  CharactersListViewModel.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 10.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import Foundation

// MARK: - Coordinator delegate protocol

protocol CharactersListCoordinatorDelegate: class {
    
    /// Method for show selected character details.
    ///
    /// - Parameter character: Character information.
    func didSelect(character: CharacterResponse)
    
}

// MARK: - View model delegate protocol

protocol CharactersListViewModelDelegate: class {
    
    /// method for reload table view.
    func reloadTableView()
    
    /// Method for show/hide update status.
    func updateLoadingStatus(_ isLoading: Bool)
    
}

// MARK: - View model type protocol

protocol CharactersListViewModelType {
    
    var viewDelegate: CharactersListViewModelDelegate? { get set }
    
    // MARK: - Data source
    
    /// Property which return number of characters.
    var numberOfItems: Int { get }
    
    /// Property which show posibility to load new characters.
    var shouldLoadMore: Bool { get }
    
    /// Method which return character at index.
    ///
    /// - Parameter row: Charactee`s index.
    func viewModelFor(row: Int) -> CharacterCellViewModel
    
    // MARK: - Events
    
    /// Initial method which load characters first page.
    func start()
    
    /// Method which perform after user tap on cell.
    ///
    /// - Parameter row: Selected row index.
    func didSelect(row: Int)
    
    /// Method which remove all characters and returns first page characters.
    func reloadData()
    
    /// Method which load characters from next page. One page contains 20 characters.
    func loadMore()
    
}

final class CharactersListViewModel {
    
    // MARK: - Weak properties
    
    weak var viewDelegate: CharactersListViewModelDelegate?
    weak var coordinatorDelegate: CharactersListCoordinatorDelegate?
    
    // MARK: - Properties
    
    private var isLoadingMore = false
    private var service: CharacterServiceProtocol
    private var info: CharacterInfo = CharacterInfo()
    private var characters: [CharacterResponse] = [] {
        didSet {
            viewDelegate?.reloadTableView()
        }
    }
    
    private var page: Int = 0 {
        didSet {
            fetchCharacters(from: page)
        }
    }
    
    private var isLoading: Bool = false {
        didSet {
            viewDelegate?.updateLoadingStatus(isLoading)
        }
    }
    
    // MARK: - Init
    
    init(service: CharacterServiceProtocol) {
        self.service = service
    }
    
    // MARK: - Network
    
    private func fetchCharacters(from page: Int) {
        service.getCharacters(from: page) { [weak self] response in
            self?.isLoading = false
            self?.isLoadingMore = false
            
            if let response = response {
                self?.characters += response.characters
                self?.info = response.info
            }
        }
    }
    
}

extension CharactersListViewModel: CharactersListViewModelType {
    
    // MARK: - Data Source
    
    var numberOfItems: Int {
        return characters.count
    }
    
    var shouldLoadMore: Bool {
        return page != info.pages
    }
    
    func viewModelFor(row: Int) -> CharacterCellViewModel {
        return CharacterCellViewModel(character: characters[row])
    }
    
    // MARK: - Events
    
    func start() {
        page = 1
    }
    
    func didSelect(row: Int) {
        coordinatorDelegate?.didSelect(character: characters[row])
    }
    
    func reloadData() {
        isLoading = true
        characters.removeAll()
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
