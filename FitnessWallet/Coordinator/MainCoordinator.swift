//
//  MainCoordinator.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 16/12/2020.
//

import Foundation

protocol TabItemCoordinatorProtocol: CoordinatorProtocol {
    init(coordinator: MainCoordinatorProtocol, navigationController: TabBarNavigationController)
}

protocol MainCoordinatorProtocol: CoordinatorProtocol {
    func logOut()
}

final class MainCoordinator: MainCoordinatorProtocol {
    private let parentCoordinator: ApplicationParentCoordinatorProtocol
    private var tabBarController: TabBarController!
    
    private var coordinators: [CoordinatorProtocol] = []
    
    init(parentCoordinator: ApplicationParentCoordinatorProtocol) {
        self.parentCoordinator = parentCoordinator
    }
    
    func logOut() {
        parentCoordinator.presentLoginViewController()
    }
    
    func start() {
        let viewModel = TabBarViewModel(coordinator: self)
        tabBarController = TabBarController(with: viewModel)
        
        tabBarController.viewControllers = TabBarItem.allCases.map {
            let navigationController = TabBarNavigationController(item: $0)
            let coordinator = createTabBarController($0, navigationController: navigationController)
            coordinators.append(coordinator)
            coordinator.start()
            return navigationController
        }
        parentCoordinator.showRootViewController(rootViewController: tabBarController)
    }
    
    private func createTabBarController(_ item: TabBarItem, navigationController: TabBarNavigationController) -> TabItemCoordinatorProtocol {
        switch item {
        case .main:
            return FeedCoordinator(coordinator: self, navigationController: navigationController)
        case .training:
            return TrainingCoordinator(coordinator: self, navigationController: navigationController)
        case .notification:
            return NotificationCoordinator(coordinator: self, navigationController: navigationController)
        case .profile:
            return ProfileCoordinator(coordinator: self, navigationController: navigationController)
        }
    }
    
}
