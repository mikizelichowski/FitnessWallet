//
//  FeedCoordinator.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import UIKit

protocol FeedCoordinatorProtocol: TabItemCoordinatorProtocol {
    func logout()
    func showCustomerProfileView(with model: DataItem)
}

final class FeedCoordinator: FeedCoordinatorProtocol {
    private let parentCoordinator: MainCoordinatorProtocol
    private let navigationController: TabBarNavigationController
    
    init(coordinator: MainCoordinatorProtocol, navigationController: TabBarNavigationController) {
        self.parentCoordinator = coordinator
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = MainViewModel(coordinator: self)
        let controller = MainViewController(with: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func logout() {
        parentCoordinator.logOut()
    }
}

extension FeedCoordinator {
    
    func showCustomerProfileView(with model: DataItem) {
        let viewModel = CustomerProfileViewModel(with: model)
        switch model {
        case .exercises(let customer):
            viewModel.fetchDataClosure?(customer)
        case .customers(let customer):
            viewModel.fetchDataClosure?(customer)
        case .remaining(let customer):
            viewModel.fetchDataClosure?(customer)
        }
        let controller = CustomerProfileViewController(with: viewModel)
        controller.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(controller, animated: true)
    }
}
