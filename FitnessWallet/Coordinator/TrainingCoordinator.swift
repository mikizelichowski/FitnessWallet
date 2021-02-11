//
//  TrainingCoordinator.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import UIKit

protocol TrainingCoordinatorProtocol: TabItemCoordinatorProtocol {
    func trainingViewController()
}

final class TrainingCoordinator: TrainingCoordinatorProtocol {
    private let parentCoordinator: MainCoordinatorProtocol
    private let navigationController: TabBarNavigationController
    
    init(coordinator: MainCoordinatorProtocol, navigationController: TabBarNavigationController) {
        self.parentCoordinator = coordinator
        self.navigationController = navigationController
    }
    
    func start(){
        trainingViewController()
    }
    
    func trainingViewController() {
        let viewModel = TrainingViewModel(coordinate: self)
        let controller = TrainingViewController(with: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
}
