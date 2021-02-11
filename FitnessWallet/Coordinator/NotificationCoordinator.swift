//
//  NotificationCoordinator.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

protocol NotificationCoordinatorProtocol: TabItemCoordinatorProtocol {
    func presentNotificationViewController()
}

final class NotificationCoordinator: NotificationCoordinatorProtocol {
    private let parentCoordinator: MainCoordinatorProtocol
    private let navigationController: TabBarNavigationController
    
    init(coordinator: MainCoordinatorProtocol, navigationController: TabBarNavigationController) {
        self.parentCoordinator = coordinator
        self.navigationController = navigationController
    }
    
    func start() {
        test()
    }
    
    func presentNotificationViewController() {
        let viewModel = NotificationViewModel(coordinate: self)
        let controller = NotificationViewController(with: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func test() {
        let controller = ViewBaseController()
        navigationController.pushViewController(controller, animated: true)
    }
}
