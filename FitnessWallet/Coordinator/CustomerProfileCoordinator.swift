//
//  CustomerProfileCoordinator.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 28/01/2021.
//

import UIKit

protocol CustomerProfileListDelegate: class {
    func customerDidSelect(_ model: Customers)
    
}

protocol CustomerProfileCoordinatorProtocol: CoordinatorProtocol {
    func start(_ customer: Customers)
    func popViewController()
    func dismissViewController()
    func logoutWhenError()
    func showCustomerProfileViewController()
    func showCustomerPackageViewController()
    func showTrainigListViewController()
    func selectedItem(_ closure: @escaping(DataItem)-> ())
    func selectedCustomer(_ dataItem: DataItem)
    func selectedCustomerItemClosure(_ customer: Customers)
}

final class CustomerProfileCoordinator {
    private var modalNavigationController: ModalNavigationController?
    private weak var navigationController: UINavigationController?
    
    var selectedCustomerItemClosure: ((Customers) -> ())?
    private var selectedDataItemClosure: ((DataItem) -> ())?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension CustomerProfileCoordinator: CustomerProfileCoordinatorProtocol {
    func logoutWhenError() {
    }
    
    func selectedCustomerItemClosure(_ customer: Customers) {
        selectedCustomerItemClosure?(customer)
    }
    
    func selectedItem(_ closure: @escaping(DataItem)-> ()) {
        selectedDataItemClosure = closure
    }
    
    func selectedCustomer(_ dataItem: DataItem) {
        selectedDataItemClosure?(dataItem)
    }
    
    func start(_ customer: Customers) {
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func dismissViewController() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func showCustomerProfileViewController() {
        
    }
    
    func showCustomerPackageViewController() {
    }
    
    func showTrainigListViewController() {
    }
    
    func start() {
        
    }
}
