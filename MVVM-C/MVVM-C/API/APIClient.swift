//
//  APIClient.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 09.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import Network

final class APIClient {
    
    // MARK: - Properties
    
    /// Base API url.
    static let baseUrl = URL(string: Config.apiUrl)!
    
    /// Alamofire session manager
    private let manager: SessionManager
    
    /// Networking monitor for handling internet connection availability.
    private let monitor = NWPathMonitor()
    
    /// Networking queue.
    private let queue = DispatchQueue(label: "AppNetwork")
    
    /// Internet connection availability.
    var isInternetAvailable = true
    
    // MARK: - Initializer
    
    init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        manager = Alamofire.SessionManager(configuration: configuration)
        setupNetworkMonitor()
    }
    
    // MARK: - Network monitor configuration
    
    /// Method for configure networking monitor and change `isInternetAvailable` property.
    private func setupNetworkMonitor() {
        let queue = DispatchQueue(label: "NetworkMonitor")
        
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isInternetAvailable = (path.status == .satisfied)
        }

        monitor.start(queue: queue)
    }
    
    // MARK: - HTTP request
    
    /// Method for handling errors during networking requests and decode response.
    func request<Response>(_ endpoint: Endpoint<Response>) -> Single<Response> {
        return Single<Response>.create { [unowned self] observer in
            var url = self.url(path: endpoint.path)
            
            if let queryParams = endpoint.queryItems {
                url = URL(string: url.appendingQueryItems(queryParams))!
                print(url.absoluteString)
            }
            
            let request = self.manager.request(
                url,
                method: httpMethod(from: endpoint.method),
                parameters: endpoint.parameters,
                encoding: endpoint.paramsEncoding
            )

            print("API request url: \(url.absoluteString)")

            request.validate().responseData(queue: self.queue) { response in
                let result = response.result.flatMap(endpoint.decode)

                switch result {
                case let .success(value):
                    observer(.success(value))
                    
                case let .failure(error):
                    let requestError = ErrorHandler().wrap(error, response: response)

                    ErrorHandler().handle(requestError, description: nil)
                    requestError.code = response.response?.statusCode ?? 0
                    
                    observer(.error(requestError))
                }
            }

            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    /// Method for create base url with path components.
    ///
    /// - Parameter path: Path components.
    private func url(path: Path) -> URL {
        return APIClient.baseUrl.appendingPathComponent(path)
    }

    
}

// MARK: - HTTP method converter

/// Method for convert Endpoint `Method` type to Alamofire `HTTPMethod` type.
public func httpMethod(from method: Method) -> HTTPMethod {
    switch method {
        
    case .get: return .get
    case .put: return .put
    case .post: return .post
    case .patch: return .patch
    case .delete: return .delete
        
    }
}
