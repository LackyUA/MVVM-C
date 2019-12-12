//
//  RequestError.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 09.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import Foundation

/// API request error type.
class RequestError: Error {
    
    var code: Int
    
    init(code: Int = 0) {
        self.code = code
    }
    
    func description() -> String {
        return "Network request error."
    }
    
}

/// API request error type which notifies about internet connection error.
final class NoInternetError: RequestError {}
