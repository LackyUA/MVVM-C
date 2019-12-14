//
//  EpisodesCoordinator.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 12.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import UIKit

final class EpisodesCoordinator: NSObject, Coordinator {
    
    // MARK: - Properties
    
    var childCoordinators: [UUID : Coordinator] = [:]
    var rootViewController: UITabBarController
    var identifier: UUID
    var session: Session
    
    let rootNavigationController: UINavigationController = {
        let navigationController = UINavigationController()
        
        navigationController.tabBarItem = .init(title: "Episodes", image: UIImage(named: "episodes"), tag: 0)
        
        return navigationController
    }()
    
    // MARK: - View models
    
    lazy var episodesListViewModel: EpisodesListViewModel = {
        let viewModel = EpisodesListViewModel(service: session.episodeService)
        
        viewModel.coordinatorDelegate = self
        
        return viewModel
    }()
    
    // MARK: - Initializers
    
    init(rootViewController: UITabBarController, session: Session) {
        self.session = session
        self.identifier = UUID()
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewController = EpisodesList()
        
        viewController.viewModel = episodesListViewModel
        
        rootNavigationController.setViewControllers([viewController], animated: false)
        rootViewController.addChild(rootNavigationController)
    }
    
    private func childDidDisappeared(_ child: Coordinator?) {
        childCoordinators.removeValue(forKey: (child?.identifier)!)
    }
    
}

// MARK: - Episode list coordinato delegate

extension EpisodesCoordinator: ListCoordinatorDelegate {
    
    func didSelect<Model: ListedModel>(data: Model) {
        if let episode = data as? EpisodeResponse {
            print(episode.name)
        }
    }
    
}

