//
//  ProfileCoordinator.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

protocol ProfileCoordinatorProtocol: TabItemCoordinatorProtocol {
    func showAddNewCustomer()
    func showProfileController()
}

final class ProfileCoordinator: ProfileCoordinatorProtocol {
    private let parentCoordinator: MainCoordinatorProtocol
    private let navigationController: TabBarNavigationController
    
    init(coordinator: MainCoordinatorProtocol, navigationController: TabBarNavigationController) {
        self.parentCoordinator = coordinator
        self.navigationController = navigationController
    }
    
    func start(){
        showAddNewCustomer()
    }
}

extension ProfileCoordinator {
    func showAddNewCustomer() {
        let viewModel = AddClientViewModel()
        let controller = AddClientController(with: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func showProfileController() {
        let viewModel = ProfileViewModel(coordinate: self)
        let controller = ProfileViewController(with: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
}
