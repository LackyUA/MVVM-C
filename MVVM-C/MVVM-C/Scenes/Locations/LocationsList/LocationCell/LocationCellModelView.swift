//
//  LocationCellModelView.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 16.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import Foundation

protocol LocationCellViewModelType: CellViewModelProtocol {
    
    // MARK: - Data source
    
    /// Location's name.
    var name: String { get }
    
    /// Location's type.
    var type: String { get }
    
    /// Location's dimension.
    var dimension: String { get }

}

final class LocationCellViewModel {
    
    // MARK: - Properties
    
    private var location: LocationResponse
    
    // MARK: - Inits
    
    init(location: LocationResponse) {
        self.location = location
    }
    
}

extension LocationCellViewModel: LocationCellViewModelType {
    
    var name: String {
        let nameArray = location.name.split(separator: "(")
        
        if !nameArray.isEmpty, nameArray.count > 1 {
            return nameArray[0].trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        return location.name.trimmingCharacters(in: .whitespacesAndNewlines)
        
    }
    
    var type: String {
        return location.type.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var dimension: String {
        if location.dimension == "unknown" {
            return "Dimension unknown"
        }
        
        return location.dimension.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}
