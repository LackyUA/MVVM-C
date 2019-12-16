//
//  LocationService.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 16.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import Foundation
import RxSwift

protocol LocationServiceProtocol {
    
    func getLocations(from page: Int, completionHandler: ((RequestResult<LocationsResponse>) -> Void)?)
    
}

final class LocationService: LocationServiceProtocol {
    
    // MARK: - Properties
    
    private let apiClient = APIClient()
    private let disposeBag = DisposeBag()
    
    // MARK: - Requests
    
    func getLocations(from page: Int, completionHandler: ((RequestResult<LocationsResponse>) -> Void)?) {
        return apiClient.request(API.Location.getLocations(from: page))
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
