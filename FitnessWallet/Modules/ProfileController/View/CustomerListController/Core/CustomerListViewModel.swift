//
//  CustomerListViewModel.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 20/01/2021.
//

import Foundation

enum ActionDelegate {
    case refreshController
    case showLoading(_ state: Bool)
}

protocol CustomerListViewModelProtocol: class {
    var delegate: CustomerListViewModelDelegate! { get set }
    
    var title: String { get }
    var sectionDataSource: [SectionCustomerListDataSource] { get }
    
    func send(action: Action)
    func onViewDidLoad()
    func showAddCustomerView()
}

protocol CustomerListViewModelDelegate: class {
    func updateSnapshot(with model: [Customers])
    func showAction(action: ActionDelegate)
}

final class CustomerListViewModel {
    weak var delegate: CustomerListViewModelDelegate!
    
    private let coordinator: ProfileCoordinatorProtocol
    var itemDataSource: [ItemCustomersListDataSource] = []
    var sectionDataSource: [SectionCustomerListDataSource] = []
    
    init(with coordinator: ProfileCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func prepareCell() {
        sectionDataSource.append(SectionCustomerListDataSource(items: itemDataSource))
    }
}

extension CustomerListViewModel: CustomerListViewModelProtocol {
    var title: String { return "Customer List"}
    
    func onViewDidLoad() {
        prepareCell()
        send(action: .fetchCustomersList)
    }
    
    func showAddCustomerView() {
        coordinator.showAddNewCustomer()
    }
    
    func send(action: Action) {
        switch action {
        case .fetchCustomersList:
            CustomerService.fetchCustomers { result in
                self.delegate.showAction(action: .showLoading(true))
                switch result {
                case .success(let customers):
                    DispatchQueue.main.async {
                        self.delegate.showAction(action: .showLoading(false))
                        self.delegate.updateSnapshot(with: customers)
                        self.delegate.showAction(action: .refreshController)
                    }
                case .failure(let error):
                    print("\(ErrorAPI.fetchData) \(error.localizedDescription)")
                }
            }
        case .refreshView(_):
            send(action: .fetchCustomersList)
        }
    }
}
