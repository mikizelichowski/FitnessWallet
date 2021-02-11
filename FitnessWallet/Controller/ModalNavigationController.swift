//
//  ModalNavigationController.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 28/01/2021.
//

import UIKit

protocol ModalNavigationControllerObserverProtocol: class {
    func isDismissed(_ status: Bool)
}

final class ModalNavigationController: BaseNavigationController {
    private enum Constants {
        static let oneViewController = 1
    }
    
    weak var statusObserver: ModalNavigationControllerObserverProtocol?
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .default }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    private func setupNavigationBar() {
        statusObserver?.isDismissed(false)
        navigationBar.tintColor = .blueDark
        navigationBar.titleTextAttributes = [.font: UIFont.font(with: .bold, size: .normal), .foregroundColor: UIColor.blueDark]
        navigationBar.barTintColor = .white
    }
    
    private func addCloseButtonIfNeeded() {
        guard viewControllers.count == Constants.oneViewController else { return }
        
        topViewController?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(dismissNavigationController))
    }
    
    @objc private func dismissNavigationController() {
        dismiss(animated: true) { [weak self] in
            self?.statusObserver?.isDismissed(true)
        }
    }
}
