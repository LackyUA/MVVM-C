//
//  LocationsListViewModel.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 16.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import Foundation

final class LocationsListViewModel {
    
    // MARK: - Weak properties
    
    weak var viewDelegate: ListViewModelDelegate?
    weak var coordinatorDelegate: ListCoordinatorDelegate?
    
    // MARK: - Properties
    
    var isLoadingMore = false
    var service: LocationServiceProtocol
    var info: PaginationInfo = PaginationInfo()
    
    var locations: [LocationResponse] = [] {
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
            fetchLocations(from: page)
        }
    }
    
    // MARK: - Inits
    
    init(service: LocationService) {
        self.service = service
    }
    
    // MARK: - Networking
    
    private func fetchLocations(from page: Int) {
        service.getLocations(from: page) { [weak self] response in
            self?.isLoading = false
            self?.isLoadingMore = false
            
            if let response = response {
                self?.locations += response.locations
                self?.info = response.info
            }
        }
    }
    
}

extension LocationsListViewModel: ListViewModelType {
    
    // MARK: - Data source
    
    var numberOfCells: Int {
        return locations.count
    }
    
    var shouldLoadMore: Bool {
        return page != info.pages
    }
    
    func viewModelFor(row: Int) -> LocationsListViewModel.CellViewModel {
        return LocationCellViewModel(location: locations[row])
    }
    
    // MARK: - Events
    
    func start() {
        page = 1
    }
    
    func didSelect(row: Int) {
        coordinatorDelegate?.didSelect(data: locations[row])
    }
    
    func reloadData() {
        isLoading = true
        locations.removeAll()
        start()
    }
    
    func loadMore() {
        if !isLoadingMore, page < info.pages {
            isLoadingMore = true
            page += 1
        }
    }
    
}
