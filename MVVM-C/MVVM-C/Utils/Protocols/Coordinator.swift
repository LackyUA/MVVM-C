//
//  Coordinator.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 09.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    
    // MARK: - Properties
    
    /// A dictionary that lists all the coordinators under a key that is equal to their ID.
    var childCoordinators: [UUID: Coordinator] { get set }
    
    /// Coordinator unique identifier.
    var identifier: UUID { get }
    
    /// User session.
    var session: Session { get }
    
    // MARK: - Methods
    
    /// Method for initialize coordinator`s view.
    func start()
    
}
