//
//  MainViewModel.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 16/12/2020.
//

import Foundation
import Firebase

enum Action {
    case fetchCustomersList
    case refreshView(_ state: Bool)
}

protocol MainViewModelProtocol: class {
    var delegate: MainViewModelDelegate! { get set }
    
    func send(action: Action)
    func onViewDidLoad()
    func didTapCollectionViewCell(_ index: DataItem)
}

protocol MainViewModelDelegate: class {
    func refreshController()
    func showLoading(_ state: Bool)
    func updateSnapshot(clients: [Customers])
}

final class MainViewModel {
    weak var delegate: MainViewModelDelegate!
    
    private let coordinator: FeedCoordinatorProtocol
    var clients = [Customers]()
    
    init(coordinator: FeedCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

extension MainViewModel: MainViewModelProtocol {
    
    func onViewDidLoad() {
        send(action: .fetchCustomersList)
    }
    
    func send(action: Action) {
        switch action {
        case .fetchCustomersList:
            CustomerService.fetchCustomers { result in
                self.delegate.showLoading(true)
                switch result {
                case .success(let client):
                    DispatchQueue.main.async {
                        self.delegate.showLoading(false)
                        self.delegate.updateSnapshot(clients: client)
                        self.delegate.refreshController()
                    }
                case .failure(let error):
                    print("\(ErrorAPI.fetchData) \(error.localizedDescription)")
                }
            }
        case .refreshView(_):
            send(action: .fetchCustomersList)
        }
    }
    
    func didTapCollectionViewCell(_ index: DataItem) {
        coordinator.showCustomerProfileView(with: index)
    }
}

public extension CaseIterable where Self: Equatable {
    var index: Self.AllCases.Index {
        return Self.allCases.firstIndex(of: self)!
    }
}
