//
//  AppCoordinator.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 09.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: - Constants
    
    private let window: UIWindow
    
    // MARK: - Properties
    
    var session: Session
    var identifier: UUID
    var childCoordinators: [UUID : Coordinator]
    
    lazy var rootViewController: UITabBarController = {
        let tabBarController = UITabBarController()
        
        tabBarController.tabBar.tintColor = #colorLiteral(red: 0.5176470588, green: 0.7647058824, blue: 0.09411764706, alpha: 1)
        
        return tabBarController
    }()
    
    // MARK: - Inits
    
    init(_ sceneWindow: UIWindow) {
        session = Session()
        identifier = UUID()
        window = sceneWindow
        childCoordinators = [:]
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
        initEpisodesCoordinator()
        initCharacterCoordinator()
        initLocationsCoordinator()
        
        rootViewController.selectedIndex = 1
    }
    
    private func initEpisodesCoordinator() {
        let childCoordinator = EpisodesCoordinator(rootViewController: rootViewController, session: session)
        
        childCoordinator.start()
        childCoordinators[childCoordinator.identifier] = childCoordinator
    }
    
    private func initCharacterCoordinator() {
        let childCoordinator = CharactersCoordinator(rootViewController: rootViewController, session: session)
        
        childCoordinator.start()
        childCoordinators[childCoordinator.identifier] = childCoordinator
    }
    
    private func initLocationsCoordinator() {
        let childCoordinator = LocationsCoordinator(rootViewController: rootViewController, session: session)
        
        childCoordinator.start()
        childCoordinators[childCoordinator.identifier] = childCoordinator
    }
    
}
