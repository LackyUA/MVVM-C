//
//  LocationsCoordinator.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 16.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import UIKit

final class LocationsCoordinator: NSObject, Coordinator {
    
    // MARK: - Properties
    
    var childCoordinators: [UUID : Coordinator] = [:]
    var rootViewController: UITabBarController
    var identifier: UUID
    var session: Session
    
    let rootNavigationController: UINavigationController = {
        let navigationController = UINavigationController()
        
        navigationController.tabBarItem = .init(title: "Locations", image: #imageLiteral(resourceName: "locations"), tag: 2)
        
        return navigationController
    }()
    
    // MARK: - View models
    
    // MARK: - Inits
    
    init(rootViewController: UITabBarController, session: Session) {
        self.session = session
        self.identifier = UUID()
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewController = UIViewController()
        
        rootNavigationController.setViewControllers([viewController], animated: false)
        rootViewController.addChild(rootNavigationController)
    }
    
    private func childDidDisappeared(_ child: Coordinator?) {
        childCoordinators.removeValue(forKey: (child?.identifier)!)
    }
    
}
