//
//  CharactersCoordinator.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 09.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import UIKit

final class CharactersCoordinator: NSObject, Coordinator {
    
    // MARK: - Properties
    
    var childCoordinators: [UUID : Coordinator] = [:]
    var rootViewController: UITabBarController
    var identifier: UUID
    var session: Session
    
    let rootNavigationController: UINavigationController = {
        let navigationController = UINavigationController()
        
        navigationController.tabBarItem = .init(title: "Characters", image: UIImage(named: "character"), tag: 1)
        
        return navigationController
    }()
    
    // MARK: - View models
    
    lazy var characterListViewModel: CharactersListViewModel = {
        let viewModel = CharactersListViewModel(service: session.characterService)
        
        viewModel.coordinatorDelegate = self
        
        return viewModel
    }()
    
    var characterDetailsViewModel: CharacterDetailsViewModel!
    
    // MARK: - Initializers
    
    init(rootViewController: UITabBarController, session: Session) {
        self.session = session
        self.identifier = UUID()
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewController = CharactersList()
        
        viewController.viewModel = characterListViewModel
        
        rootNavigationController.setViewControllers([viewController], animated: false)
        rootViewController.addChild(rootNavigationController)
    }
    
    private func childDidDisappeared(_ child: Coordinator?) {
        childCoordinators.removeValue(forKey: (child?.identifier)!)
    }
    
}

// MARK: - Navigation

extension CharactersCoordinator {
    
    func showDetails(forCharacter character: CharacterResponse) {
        let viewController = CharacterDetails()
        
        characterDetailsViewModel = CharacterDetailsViewModel(character: character)
        viewController.viewModel = characterDetailsViewModel
        
        rootNavigationController.present(viewController, animated: true, completion: nil)
    }
    
}

// MARK: - Character list coordinator delegate

extension CharactersCoordinator: ListCoordinatorDelegate {
    
    func didSelect<Model: ListedModel>(data: Model) {
        if let character = data as? CharacterResponse {
            showDetails(forCharacter: character)
        }
    }
    
}
