//
//  LoginNavigationController.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 16/12/2020.
//

import UIKit

final class LoginNavigationController: UINavigationController {
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.backgroundColor = .black
        navigationBar.barTintColor = .white
        navigationBar.isTranslucent = true
        
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white.cgColor]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}
