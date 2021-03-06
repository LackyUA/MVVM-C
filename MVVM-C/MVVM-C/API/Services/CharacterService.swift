//
//  CharacterService.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 09.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import Foundation
import RxSwift

protocol CharacterServiceProtocol {
    
    func getCharacters(from page: Int, completionHandler: ((RequestResult<CharactersResponse>) -> Void)?)
    
}

final class CharacterService: CharacterServiceProtocol {
    
    // MARK: - Properties
    
    private let apiClient = APIClient()
    private let disposeBag = DisposeBag()
    
    // MARK: - Requests
    
    func getCharacters(from page: Int, completionHandler: ((RequestResult<CharactersResponse>) -> Void)?) {
        return apiClient.request(API.Character.getCharacters(from: page))
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { response in
                completionHandler?(.success(response))
            }) { error in
                if let _ = error as? NoInternetError {
                    completionHandler?(.noInternet)
                } else {
                    completionHandler?(.error)
                }
            }.disposed(by: disposeBag)
    }
    
}
