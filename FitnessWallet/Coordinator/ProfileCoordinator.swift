//
//  ProfileCoordinator.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import UIKit

protocol ProfileCoordinatorProtocol: TabItemCoordinatorProtocol {
    func showAddNewCustomer()
    func showCustomersList()
    func showProfileController()
    func showAddNewPackage()
}

final class ProfileCoordinator: ProfileCoordinatorProtocol {
    private let parentCoordinator: MainCoordinatorProtocol
    private let navigationController: TabBarNavigationController
    
    init(coordinator: MainCoordinatorProtocol, navigationController: TabBarNavigationController) {
        self.parentCoordinator = coordinator
        self.navigationController = navigationController
    }
    
    func start(){
        showProfileController()
    }
}

extension ProfileCoordinator {
    func showProfileController() {
        let viewModel = ProfileViewModel(coordinate: self)
        let controller = ProfileViewController(with: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func showCustomersList() {
        let viewModel = CustomerListViewModel(with: self)
        let controller = CustomerListViewController(with: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func showAddNewCustomer() {
        let viewModel = AddClientViewModel(with: self)
        let controller = AddClientController(with: viewModel)
        navigationController.present(controller, animated: true)
    }
    
    func showAddNewPackage() {
        let viewModel = AddNewPackageViewModel(with: self)
        let controller = AddNewPackageController(with: viewModel)
        navigationController.present(controller, animated: true)
    }
}
