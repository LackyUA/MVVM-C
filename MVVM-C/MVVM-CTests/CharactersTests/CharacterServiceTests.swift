//
//  CharacterServiceTests.swift
//  MVVM-CTests
//
//  Created by Dmytro Dobrovolskyy on 12.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import XCTest
@testable import MVVM_C

class CharacterServiceTests: XCTestCase {
    
    var characterService: CharacterService!

    override func setUp() {
        super.setUp()
        
        characterService = CharacterService()
    }

    override func tearDown() {
        characterService = nil
        
        super.tearDown()
    }

    func testFetchCharacters() {
        let expect = XCTestExpectation(description: "callback")
        
        characterService.getCharacters(from: 1) { response in
            expect.fulfill()
            
            XCTAssertTrue(response != nil)
            XCTAssertEqual(response?.characters.count, 20)
        }
        
        wait(for: [expect], timeout: 3.1)
    }

}
