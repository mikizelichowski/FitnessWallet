//
//  BaseNavigationController.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 16/12/2020.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        topViewController?.navigationItem.backBarButtonItem = backButton
        navigationBar.tintColor = .black
        navigationBar.backgroundColor = .white
    }
}
