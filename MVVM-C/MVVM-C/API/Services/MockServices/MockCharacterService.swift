//
//  MockCharacterService.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 12.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import Foundation

final class MockCharacterService: CharacterServiceProtocol {
    
    private let mockCharactersResponse: CharactersResponse = CharactersResponse(
        info: PaginationInfo(count: 1, pages: 1, next: "", prev: ""),
        characters: [
            CharacterResponse(
                id: 1,
                name: "Rick Sanchez",
                status: "Alive",
                species: "Human",
                type: "",
                gender: "Male",
                origin: CharacterLocation(name: "Earth", url: ""),
                location: CharacterLocation(name: "Earth", url: ""),
                image: "",
                episode: [],
                url: "",
                created: ""
            )
        ]
    )
    
    var isGetCharactersCalled = false
    var completionHandler: ((CharactersResponse?) -> Void)?
    
    func getCharacters(from page: Int, completionHandler: ((CharactersResponse?) -> Void)?) {
        isGetCharactersCalled = true
        self.completionHandler = completionHandler
    }
    
    func getCharactersFetchSuccess() {
        completionHandler?(mockCharactersResponse)
    }
    
}
