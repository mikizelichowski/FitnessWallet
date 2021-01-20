//
//  FeedCoordinator.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import UIKit

protocol FeedCoordinatorProtocol: TabItemCoordinatorProtocol {
    func logout()
}

final class FeedCoordinator: FeedCoordinatorProtocol {
    private let parentCoordinator: MainCoordinatorProtocol
    private let navigationController: TabBarNavigationController
    
    init(coordinator: MainCoordinatorProtocol, navigationController: TabBarNavigationController) {
        self.parentCoordinator = coordinator
        self.navigationController = navigationController
    }
    
    func start(){
        let viewModel = MainViewModel(coordinator: self)
        let controller = MainViewController(with: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func logout() {
        parentCoordinator.logOut()
    }
}

