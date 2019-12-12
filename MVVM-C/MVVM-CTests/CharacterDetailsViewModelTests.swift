//
//  CharacterDetailsViewModelTests.swift
//  MVVM-CTests
//
//  Created by Dmytro Dobrovolskyy on 12.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import XCTest
@testable import MVVM_C

class CharacterDetailsViewModelTests: XCTestCase {
    
    var character: CharacterResponse!
    var viewModel: CharacterDetailsViewModel!

    override func setUp() {
        super.setUp()
        
        character = CharacterResponse(
            id: 1,
            name: "Rick Sanchez",
            status: "alive                       ",
            species: "   Human",
            type: "",
            gender: "Male",
            origin: CharacterLocation(name: "Earth", url: ""),
            location: CharacterLocation(name: "Earth", url: ""),
            image: "",
            episode: [],
            url: "",
            created: ""
        )
        viewModel = CharacterDetailsViewModel(character: character)
    }

    override func tearDown() {
        character = nil
        viewModel = nil
        super.tearDown()
    }

    func testViewModelInit() {
        XCTAssertEqual(viewModel.name, "Rick Sanchez")
        XCTAssertEqual(viewModel.status, "Alive")
        XCTAssertEqual(viewModel.species, "Human")
        XCTAssertEqual(viewModel.gender, "Male")
        XCTAssertEqual(viewModel.currentLocation, "Earth")
    }

}
