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
    
    static var instance: AppCoordinator!
    
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
        
        AppCoordinator.instance = self
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
        initEpisodesCoordinator()
        initCharacterCoordinator()
        initLocationsCoordinator()
        
        rootViewController.selectedIndex = 1
    }
    
    func childDidDisappeared(_ child: Coordinator?) {}
    
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

// MARK: - Error handling

extension AppCoordinator {
    
    func showInternetConnectionAlert() {
        if !window.subviews.filter({ $0.accessibilityIdentifier == "no_internet" }).isEmpty {
            return
        }
        
        let view = NoInternetConnectionView(
            frame: CGRect(
                x: 0,
                y: window.safeAreaInsets.top,
                width: window.bounds.width,
                height: 44
            )
        )
        
        window.addSubview(view)

        view.transform = CGAffineTransform(translationX: 0, y: -(window.safeAreaInsets.top + view.frame.height))
        
        UIView.animate(withDuration: 0.4, animations: {
            view.transform = .identity
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                UIView.animate(withDuration: 0.4, animations: {
                    view.transform = .identity
                }) { _ in
                    UIView.animate(withDuration: 0.4, animations: {
                        view.alpha = 0
                    }) { _ in
                        view.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    func showErroAlert(with description: String) {
        AlertService.showAlert(vc: rootViewController, title: "Server request error.", message: description)
    }
    
}
