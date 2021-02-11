//
//  ProfileViewController.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import UIKit

#warning("CREATE LATER !! ")

final class ProfileViewController: UIViewController {
    private let addNewPackage = UIButton(type: .custom)
    private let addNewClient = UIButton(type: .custom)
    private let stackView = UIStackView()
    
    var viewModel: ProfileViewModelProtocol
    
    init(with viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController(true)
    }
    
    private func setupLayout() {
        [addNewPackage, addNewClient].forEach { view.addSubview($0)
            $0.setDimensions(height: 30, width: 200)
        }
        addNewPackage.anchor(top: view.topAnchor,
                             left: view.leftAnchor,
                             paddingTop: 200,
                             paddingLeft: 80)
        addNewClient.anchor(top: addNewPackage.bottomAnchor,
                            left: view.leftAnchor,
                            paddingTop: 20,
                            paddingLeft: 80)
        addNewClient.setTitle("add a new customer", for: .normal)
        addNewClient.setTitleColor(.black, for: .normal)
        addNewPackage.setTitle("add a new package", for: .normal)
        addNewPackage.setTitleColor(.black, for: .normal)
        addNewClient.addTarget(self, action: #selector(didTapAddNewCustomer), for: .touchUpInside)
        addNewPackage.addTarget(self, action: #selector(didTapAddNewPackage), for: .touchUpInside)
    }
    
    @objc
    private func didTapAddNewPackage() {
        viewModel.showAddNewCard()
    }
    
    @objc
    private func didTapAddNewCustomer() {
        viewModel.showAddNewCustomer()
    }
}

extension ProfileViewController: ProfileViewModelDelegate {
}
