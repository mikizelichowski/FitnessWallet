//
//  NotificationViewController.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import UIKit
import Firebase

final class NotificationViewController: UIViewController {
    
    var viewModel: NotificationViewModelProtocol
    
    init(with viewModel: NotificationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

extension NotificationViewController: NotificationViewModelDelegate {
    
}
