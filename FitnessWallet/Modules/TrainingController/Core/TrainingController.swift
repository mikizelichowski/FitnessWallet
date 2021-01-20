//
//  TrainingController.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import UIKit

final class TrainingViewController: UIViewController {
    
    var viewModel: TrainingViewModelProtocol
    
    init(with viewModel: TrainingViewModelProtocol) {
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
        
        CustomerService.getUser()
    }
}

extension TrainingViewController: TrainingViewModelDelegate {
    
}
