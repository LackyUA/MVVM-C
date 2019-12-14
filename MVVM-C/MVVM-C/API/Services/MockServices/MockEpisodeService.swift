//
//  MockEpisodeService.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 14.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import Foundation

final class MockEpisodeService: EpisodeServiceProtocol {
    
    private let mockEpisodeResponse: EpisodesResponse = EpisodesResponse(
        info: PaginationInfo(count: 1, pages: 1, next: "", prev: ""),
        episodes: [
            EpisodeResponse(
                id: 1,
                name: "Pilot",
                releaseDate: "December 2, 2013",
                abbreviation: "S01E01",
                characters: [],
                url: "",
                created: ""
            )
        ]
    )
    
    var isGetEpisodesCalled = false
    var completionHandler: ((EpisodesResponse?) -> Void)?
    
    func getEpisodes(from page: Int, completionHandler: ((EpisodesResponse?) -> Void)?) {
        isGetEpisodesCalled = true
        self.completionHandler = completionHandler
    }
    
    func getEpisodesFetchSuccess() {
        completionHandler?(mockEpisodeResponse)
    }
    
}
