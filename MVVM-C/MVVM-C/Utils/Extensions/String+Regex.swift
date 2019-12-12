//
//  String+Regex.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 11.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import Foundation

extension String {
    
    func getNextPage() -> Int {
        let range = NSRange(location: 0, length: self.utf16.count)
        let regex = try! NSRegularExpression(pattern: "\\d+")
        let result = regex.firstMatch(in: self, options: [], range: range)

        if let result = result, let range = Range(result.range, in: self) {
            return Int(String(self[range])) ?? 0
        }
        
        return 0
    }
    
}
