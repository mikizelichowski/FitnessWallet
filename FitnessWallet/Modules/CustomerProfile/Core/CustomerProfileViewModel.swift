//
//  CustomerProfileViewModel.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 21/01/2021.
//

import UIKit

protocol CustomerProfileViewModelProtocol: class {
    var delegate: CustomerProfileViewModelDelegate! { get set }
    
    var fetchDataClosure: ((Customers) -> ())? { get set }
    var showPackageViewControllerClosure: ((UIView) -> ())? { get set }
    var showTrainingViewControllerClosure: ((UIView) -> ())? { get set }
    
    func showDataItem()
    func showPackageView(customers: Customers)
    func showTrainingListView(customers: Customers)
}

protocol CustomerProfileViewModelDelegate: class {
}

final class CustomerProfileViewModel {
    weak var delegate: CustomerProfileViewModelDelegate!
    
    private let dataItem: DataItem
    var fetchDataClosure: ((Customers) -> ())?
    var showPackageViewControllerClosure: ((UIView) -> ())?
    var showTrainingViewControllerClosure: ((UIView) -> ())?
    
    init(with availableDataItem: DataItem) {
        self.dataItem = availableDataItem
    }
}

extension CustomerProfileViewModel: CustomerProfileViewModelProtocol {
    func showDataItem() {
        switch dataItem {
        case .exercises(let customer):
            self.fetchDataClosure?(customer)
            self.showPackageView(customers: customer)
            self.showTrainingListView(customers: customer)
        case .customers(let customer):
            self.fetchDataClosure?(customer)
            self.showPackageView(customers: customer)
            self.showTrainingListView(customers: customer)
        case .remaining(let customer):
            self.fetchDataClosure?(customer)
            self.showPackageView(customers: customer)
            self.showTrainingListView(customers: customer)
        }
    }
    
    #warning("move to coordinator")
    func showPackageView(customers: Customers) {
        let viewModel = PackageViewModel()
        viewModel.customers = customers
        let controller = PackageViewController(with: viewModel)
        showPackageViewControllerClosure?(controller)
    }
    
    #warning("move to coordinator")
    #warning("add later")
    func showTrainingListView(customers: Customers) {
        let viewModel = TrainingListViewModel()
        viewModel.customerModel = customers
        let controller = TrainingListViewController(with: viewModel)
        showTrainingViewControllerClosure?(controller)
        print("DEBUG: works good!! \(customers.customerId)")
    }
}


