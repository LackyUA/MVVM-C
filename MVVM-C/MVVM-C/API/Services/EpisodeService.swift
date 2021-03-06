//
//  EpisodeService.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 12.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import Foundation
import RxSwift

protocol EpisodeServiceProtocol {
    
    func getEpisodes(from page: Int, completionHandler: ((RequestResult<EpisodesResponse>) -> Void)?)
    
}

final class EpisodeService: EpisodeServiceProtocol {
    
    // MARK: - Properties
    
    private let apiClient = APIClient()
    private let disposeBag = DisposeBag()
    
    // MARK: - Requests
    
    func getEpisodes(from page: Int, completionHandler: ((RequestResult<EpisodesResponse>) -> Void)?) {
        return apiClient.request(API.Episode.getEpisodes(from: page))
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
