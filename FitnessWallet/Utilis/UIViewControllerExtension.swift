//
//  UIViewControllerExtension.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 14/01/2021.
//

import UIKit
import JGProgressHUD

extension UIViewController {
    private enum Constants {
        static let okTilte = "Ok"
    }
    
    static let hud = JGProgressHUD(style: .dark)
    
    func showLoader(_ show: Bool) {
        view.endEditing(true)
        if show {
            UIViewController.hud.show(in: view)
        } else {
            UIViewController.hud.dismiss()
        }
    }
    
    func showMessage(withTitle title: String, message: String, completion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.okTilte, style: .default, handler: nil))
        present(alert, animated: true, completion: completion)
    }
    
    func setupNavigationController(_ isHidden: Bool? = false, backgroundColor: UIColor? = nil) {
        navigationController?.navigationBar.isHidden = isHidden!
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor = backgroundColor
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.tintColor = .black
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont(name: "Georgia-Bold", size: 20)!
        ]
        navigationController?.navigationBar.titleTextAttributes = attrs
        
    }
}
