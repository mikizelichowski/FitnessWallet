//
//  UIViewControllerExtension.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 14/01/2021.
//

import UIKit
import JGProgressHUD

extension UIViewController {
    static let hud = JGProgressHUD(style: .dark)
    
    func showLoader(_ show: Bool) {
        view.endEditing(true)
        if show {
            UIViewController.hud.show(in: view)
        } else {
            UIViewController.hud.dismiss()
        }
    }
    
    func showMessage(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
