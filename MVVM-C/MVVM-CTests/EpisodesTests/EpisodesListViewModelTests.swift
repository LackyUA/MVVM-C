//
//  EpisodesListViewModelTests.swift
//  MVVM-CTests
//
//  Created by Dmytro Dobrovolskyy on 14.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import XCTest
@testable import MVVM_C

class EpisodesListViewModelTests: XCTestCase {

    var mockEpisodeService: MockEpisodeService!
    var episodesViewModel: EpisodesListViewModel!

    override func setUp() {
        super.setUp()
        
        mockEpisodeService = MockEpisodeService()
        episodesViewModel = EpisodesListViewModel(service: mockEpisodeService)
    }

    override func tearDown() {
        mockEpisodeService = nil
        episodesViewModel = nil
        super.tearDown()
    }
    
    func testCharactersFetch() {
        episodesViewModel.page = 1
        XCTAssertTrue(mockEpisodeService.isGetEpisodesCalled)
    }
    
    func testCharactersFetchSuccess() {
        episodesViewModel.page = 1
        mockEpisodeService.getEpisodesFetchSuccess()
        
        XCTAssertTrue(episodesViewModel.numberOfCells == episodesViewModel.episodes.count, "Fetch failed.")
    }
    
    func testCharacterCellViewModelInitialize() {
        episodesViewModel.page = 1
        mockEpisodeService.getEpisodesFetchSuccess()
        
        let episodeCellViewModel = episodesViewModel.viewModelFor(row: 0) as! EpisodeCellViewModel
        
        XCTAssertEqual(episodeCellViewModel.name, "Pilot", "Wrong character view model initializing.")
        XCTAssertEqual(episodeCellViewModel.releaseDate, "December 2, 2013", "Wrong character view model initializing.")
    }
    
    func testLoadingState() {
        episodesViewModel.reloadData()
        XCTAssertTrue(episodesViewModel.isLoading, "Wrong character view model initializing.")
        
        mockEpisodeService.getEpisodesFetchSuccess()
        XCTAssertEqual(episodesViewModel.page, 1, "Wrong character view model initializing.")
        XCTAssertFalse(episodesViewModel.isLoading, "Wrong character view model initializing.")
    }
    
    func testLoadMore() {
        episodesViewModel.page = 0
        mockEpisodeService.getEpisodesFetchSuccess()
        
        XCTAssertTrue(episodesViewModel.shouldLoadMore, "Wrong loading more logic.")
        
        episodesViewModel.loadMore()
        XCTAssertEqual(episodesViewModel.page, 1, "Wrong loading more logic.")
        
        episodesViewModel.loadMore()
        XCTAssertEqual(episodesViewModel.page, 1, "Wrong loading more logic.")
    }


}
