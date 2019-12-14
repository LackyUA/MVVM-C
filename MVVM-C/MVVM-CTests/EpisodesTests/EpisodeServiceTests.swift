//
//  EpisodeServiceTests.swift
//  MVVM-CTests
//
//  Created by Dmytro Dobrovolskyy on 14.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import XCTest
@testable import MVVM_C

class EpisodeServiceTests: XCTestCase {

    var episodeService: EpisodeService!

    override func setUp() {
        super.setUp()
        
        episodeService = EpisodeService()
    }

    override func tearDown() {
        episodeService = nil
        
        super.tearDown()
    }

    func testFetchEpisodes() {
        let expect = XCTestExpectation(description: "callback")
        
        episodeService.getEpisodes(from: 1) { response in
            expect.fulfill()
            
            XCTAssertTrue(response != nil)
            XCTAssertEqual(response?.episodes.count, 20)
        }
        
        wait(for: [expect], timeout: 3.1)
    }

}
