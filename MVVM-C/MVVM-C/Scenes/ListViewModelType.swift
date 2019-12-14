//
//  ListViewModelType.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 14.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import Foundation

// MARK: - Type protocols

protocol CellViewModelProtocol {}
protocol ListedModel {}

// MARK: - Coordinator delegate protocol

protocol ListCoordinatorDelegate: class {
    
    /// Method for show selected item details.
    ///
    /// - Parameter data: Item information.
    func didSelect<Model: ListedModel>(data: Model)
    
}

// MARK: - View model delegate protocol

protocol ListViewModelDelegate: class {
    
    /// Method for reload table view.
    func reloadTableView()
    
    /// Method for show/hide update status.
    func updateLoadingStatus(_ isLoading: Bool)
    
}

// MARK: - View model type protocol

protocol ListViewModelType {
    
    typealias CellViewModel = CellViewModelProtocol
    
    var viewDelegate: ListViewModelDelegate? { get set }
    
    // MARK: - Data source
    
    /// Property which return number of cells.
    var numberOfCells: Int { get }
    
    /// Property which show posibility to load more data.
    var shouldLoadMore: Bool { get }
    
    /// Method which return item at index.
    ///
    /// - Parameter row: Item`s index.
    func viewModelFor(row: Int) -> CellViewModel
    
    // MARK: - Events
    
    /// Initial method which load first page of data.
    func start()
    
    /// Method which perform after user tap on cell.
    ///
    /// - Parameter row: Selected row index.
    func didSelect(row: Int)
    
    /// Method which remove all data and Init loading first page of data.
    func reloadData()
    
    /// Method which load data from next page. One page contains 20 items.
    func loadMore()
    
}
