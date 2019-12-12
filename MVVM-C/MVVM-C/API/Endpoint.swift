//
//  Endpoint.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 09.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import Foundation
import Alamofire

typealias Parameters = [String: Any]
typealias Path = String

public enum Method {
    case get, post, put, patch, delete
}

final class Endpoint<Response> {
    
    let path: Path
    let method: Method
    let parameters: Parameters?
    let queryItems: [String:Any]?
    let paramsEncoding: ParameterEncoding
    let decode: (Data) throws -> Response

    init(
        method: Method = .get,
        path: Path,
        queryItems: [String:Any]? = nil,
        parameters: Parameters? = nil,
        paramsEncoding: ParameterEncoding = JSONEncoding.default,
        decode: @escaping (Data) throws -> Response
    ) {
        self.path = path
        self.decode = decode
        self.method = method
        self.parameters = parameters
        self.queryItems = queryItems
        self.paramsEncoding = paramsEncoding
    }
    
}

extension Endpoint where Response: Swift.Decodable {
    
    convenience init(
        method: Method = .get,
        path: Path,
        queryItems: [String:Any]? = nil,
        parameters: Parameters? = nil
    ) {
        self.init(method: method, path: path, queryItems: queryItems, parameters: parameters) {
            try JSONDecoder().decode(Response.self, from: $0)
        }
    }
    
}

extension Endpoint where Response == Void {
    
    convenience init(
        method: Method = .get,
        path: Path,
        queryItems: [String:Any]? = nil,
        parameters: Parameters? = nil,
        paramsEncoding: ParameterEncoding = JSONEncoding.default
    ) {
        self.init(
            method: method,
            path: path,
            queryItems:queryItems,
            parameters: parameters,
            paramsEncoding: paramsEncoding,
            decode: { _ in () }
        )
    }
    
}

struct JSONArrayEncoding: ParameterEncoding {
    
    private let array: [Parameters]
    
    init(array: [Parameters]) {
        self.array = array
    }
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        let data = try JSONSerialization.data(withJSONObject: array, options: [])
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        urlRequest.httpBody = data

        return urlRequest
    }
    
}

