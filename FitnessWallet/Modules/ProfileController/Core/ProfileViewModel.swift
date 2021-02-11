//
//  File.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import Foundation

protocol ProfileViewModelProtocol: class {
    var delegate: ProfileViewModelDelegate! { get set }
    
    func showAddNewCustomer()
    func showAddNewCard()
}

protocol ProfileViewModelDelegate: class {
}

final class ProfileViewModel {
    weak var delegate: ProfileViewModelDelegate!
    
    var customers: Customers?
    private let coordinate: ProfileCoordinatorProtocol
    
    init(coordinate: ProfileCoordinatorProtocol) {
        self.coordinate = coordinate
    }
}

extension ProfileViewModel: ProfileViewModelProtocol {
    func showAddNewCustomer() {
        coordinate.showCustomersList()
    }
    
    func showAddNewCard() {
        coordinate.showAddNewPackage()
    }
}
