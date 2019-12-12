//
//  ErrorHandler.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 09.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import Foundation
import Alamofire

/// Class for handle API request errors.
final class ErrorHandler {
    
    /// Method for wrap error to `RequestError` type.
    ///
    /// - Parameter error: Request error.
    /// - Parameter response: Request response.
    func wrap(_ error: Error, response: DataResponse<Data>) -> RequestError {
        print("Error in: \(response.request as Any)")
        
        var requestError = RequestError()
        
        // Handling networking error sent by back-end.
        if let alamofireError = (error as? AFError) {
            switch alamofireError.responseCode {
                // Add error handling based on beck-end.
            default:
                print("Unhandled AFError: \(alamofireError.responseCode ?? 0)")
            }
        }
        
        // Handling internet connection error.
        if (error as NSError).code == -1009 || (error as NSError).code == -1001 {
            requestError = NoInternetError()
        }
        
        // Handling errors with response sent by back-end.
        if let data = response.data {
            do {
                let encodedRepsponse = String(data: data, encoding: .utf8)
                
                print(encodedRepsponse as Any)
                
                if let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    guard let code = (dict["Code"] as? Int) == nil
                        ? dict["Code"] as? Int
                        : dict["code"] as? Int else { return requestError }
                    
                    switch code {
                        // Add error handling based on beck-end.
                    default:
                        requestError = RequestError(code: code)
                    }
                }
            } catch {
                print("Request response serialization error: \(error).")
            }
        }
        
        return requestError
    }
    
    /// Method for handle `RequestError` and display it for user.
    /// This method should be called only in main thread!
    ///
    /// - Parameter error: Request error.
    /// - Parameter description: Request error description.
    func handle(_ error: Error, description: String? = nil) {
        if error is NoInternetError {
            // Show internet connection problem alert.
        } else if let description = description {
            print(description)
            // Show description alert.
        }
        
        if let requestError = error as? RequestError {
            print("API Error code: \(requestError.code)")
        }
    }
    
}
