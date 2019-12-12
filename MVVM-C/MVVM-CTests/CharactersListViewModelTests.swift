//
//  CharactersListViewModelTests.swift
//  MVVM-CTests
//
//  Created by Dmytro Dobrovolskyy on 12.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import XCTest
@testable import MVVM_C

class CharactersListViewModelTests: XCTestCase {
    
    var mockCharacterService: MockCharacterService!
    var charactersViewModel: CharactersListViewModel!

    override func setUp() {
        super.setUp()
        
        mockCharacterService = MockCharacterService()
        charactersViewModel = CharactersListViewModel(service: mockCharacterService)
    }

    override func tearDown() {
        mockCharacterService = nil
        charactersViewModel = nil
        super.tearDown()
    }
    
    func testCharactersFetch() {
        charactersViewModel.page = 1
        XCTAssertTrue(mockCharacterService.isGetCharactersCalled)
    }
    
    func testCharactersFetchSuccess() {
        charactersViewModel.page = 1
        mockCharacterService.getCharactersFetchSuccess()
        
        XCTAssertTrue(charactersViewModel.numberOfCells == charactersViewModel.characters.count, "Fetch failed.")
    }
    
    func testCharacterCellViewModelInitialize() {
        charactersViewModel.page = 1
        mockCharacterService.getCharactersFetchSuccess()
        
        let characterCellViewModel = charactersViewModel.viewModelFor(row: 0)
        
        XCTAssertEqual(characterCellViewModel.name, "Rick Sanchez", "Wrong character view model initializing.")
        XCTAssertEqual(characterCellViewModel.characterStatus, .alive, "Wrong character view model initializing.")
    }
    
    func testLoadingState() {
        charactersViewModel.reloadData()
        XCTAssertTrue(charactersViewModel.isLoading, "Wrong character view model initializing.")
        
        mockCharacterService.getCharactersFetchSuccess()
        XCTAssertEqual(charactersViewModel.page, 1, "Wrong character view model initializing.")
        XCTAssertFalse(charactersViewModel.isLoading, "Wrong character view model initializing.")
    }
    
    func testLoadMore() {
        charactersViewModel.page = 0
        mockCharacterService.getCharactersFetchSuccess()
        
        XCTAssertTrue(charactersViewModel.shouldLoadMore, "Wrong loading more logic.")
        
        charactersViewModel.loadMore()
        XCTAssertEqual(charactersViewModel.page, 1, "Wrong loading more logic.")
        
        charactersViewModel.loadMore()
        XCTAssertEqual(charactersViewModel.page, 1, "Wrong loading more logic.")
    }

}
