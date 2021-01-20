//
//  AppCoordinator.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 16/12/2020.
//

import UIKit

protocol CoordinatorProtocol: class {
    func start()
}

protocol ApplicationCoordinatorProtocol: CoordinatorProtocol {
    init(window: UIWindow?)
}

protocol ApplicationParentCoordinatorProtocol {
    func showRootViewController(rootViewController: UIViewController)
    func presentLoginViewController()
    func presentMainViewController()
}

final class ApplicationCoordinator: ApplicationCoordinatorProtocol {
    private weak var window: UIWindow?
    
    private var loginCoordinator: LoginCoordinator?
    private var mainCoordinator: MainCoordinator?
    
    required init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        presentLoginViewController()
        //presentMainViewController()
    }
}

extension ApplicationCoordinator: ApplicationParentCoordinatorProtocol {
    func showRootViewController(rootViewController: UIViewController) {
        window?.rootViewController = rootViewController
    }
    
    func presentLoginViewController() {
        loginCoordinator = LoginCoordinator(parentCoordinator: self)
        loginCoordinator?.start()
    }
    
    func presentMainViewController() {
        mainCoordinator = MainCoordinator(parentCoordinator: self)
        mainCoordinator?.start()
    }
}
