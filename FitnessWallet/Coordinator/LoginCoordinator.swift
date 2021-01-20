//
//  LoginCoordinator.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 16/12/2020.
//

import UIKit

protocol LoginCoordinatorProtocol: CoordinatorProtocol {
    func showLoginController()
    func showResetPasswordController()
    func showRegisterController()
    func showMainController()
    func popToLoginViewController()
}

final class LoginCoordinator: LoginCoordinatorProtocol {
    private let parentCoordinator: ApplicationParentCoordinatorProtocol
    private let navigationController = LoginNavigationController()
    
    init(parentCoordinator: ApplicationParentCoordinatorProtocol) {
        self.parentCoordinator = parentCoordinator
    }
    
    func showLoginController() {
        let viewModel = LoginViewModel(coordinator: self)
        let viewController = LoginViewController(with: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showResetPasswordController() {
        let viewModel = ResetPasswordViewModel(with: self)
        let controller = ResetPasswordView(with: viewModel)
        controller.modalPresentationStyle = .fullScreen
        navigationController.present(controller, animated: true, completion: nil)
    }
    
    func showRegisterController() {
        let viewModel = RegisterViewModel(coordinator: self)
        let controller = RegisterViewController(with: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func showMainController() {
        parentCoordinator.presentMainViewController()
    }
    
    func popToLoginViewController() {
        guard let mainViewController = navigationController.viewControllers.first(where: { $0 is MainViewController}) else {
            navigationController.popToRootViewController(animated: true)
            return
        }
        let viewModel = LoginViewModel(coordinator: self)
        let viewController = LoginViewController(with: viewModel)
        navigationController.setViewControllers([mainViewController, viewController], animated: true)
    }
    
    func start() {
        let viewModel = LoginViewModel(coordinator: self)
        let viewController = LoginViewController(with: viewModel)
        navigationController.pushViewController(viewController, animated: true)
        parentCoordinator.showRootViewController(rootViewController: navigationController)
    }
}
