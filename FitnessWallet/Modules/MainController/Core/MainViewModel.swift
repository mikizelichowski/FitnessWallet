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
}

protocol MainViewModelDelegate: class {
    func refreshController()
    func showLoading(_ state: Bool)
    func updateSnapshot(clients: [Customers])
    func udpateDataSource(_ dataSource: [SectionModel])
}

final class MainViewModel {
    weak var delegate: MainViewModelDelegate!
    
    private let coordinator: FeedCoordinatorProtocol
    var customers : [Customers] = []
    var client: Customers?
    
    init(coordinator: FeedCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    private var sections: [[SectionModel]] = [[]]
    var dataSection: [SectionModel] = [SectionModel(style: .training),
                                       SectionModel(style: .customerList),
                                       SectionModel(style: .remaining)]
    private var itemData: [Model] = []

    // new !!
    func setupCell(_ data: [Customers]) {
        itemData.removeAll()
        data.forEach {
            itemData.append(Model(dataItem: .exercises($0)))
            itemData.append(Model(dataItem: .customers($0)))
            itemData.append(Model(dataItem: .remaining($0)))
        }
        prepareTableView()
    }
    
    func prepareTableView() {
        delegate.udpateDataSource(dataSection)
    }
    
    // koniec new
    
    func prepareCell(_ data: [Customers]) {
        guard let client = client else { return }
        sections.enumerated().forEach { index, item in
            for element in item {
                itemData.append(Model(dataItem: .exercises(client)))
                itemData.append(Model(dataItem: .customers(client)))
                itemData.append(Model(dataItem: .remaining(client)))
                sections.append(dataSection)
            }
            delegate.updateSnapshot(clients: data)
        }
    }
    
//    func prepareCell() {
//        guard let client = client else { return }
//        sections.enumerated().forEach { index, item in
//            var items: [MainDataSourceItem] = []
//            for element in item {
//                items.append(MainDataSourceItem(identity:"\(element.index)", viewIdentifier: ExercisesCell.identifier, title: client.username, subtitle: client.surname, imageUrl: client.imageUrl, dataItem: .exercises(client)))
//                items.append(MainDataSourceItem(identity: "\(element.index)", viewIdentifier: CustomersCell.identifier, title: client.username, subtitle: client.surname, imageUrl: client.imageUrl, dataItem: .customers(client)))
//                items.append(MainDataSourceItem(identity: "\(element.index)", viewIdentifier: RemainingCell.identifier, title: client.username, subtitle: client.surname, imageUrl: client.imageUrl, dataItem: .remaining(client)))
//                dataSourceSection.append(MainDataSourceSection(identity: "\(element.index)", viewIdentifier: SectionHeaderView.identifier, title: .empty, items: items, style: Section.allCases[index]))
//
//                delegate.updateCollectionViewDataSource(dataSourceSection)
//            }
//        }
//    }
    
//    func prepareCollectionView() {
//        dataSourceSection.append(MainDataSourceSection(identity: 1, viewIdentifier: SectionHeaderView.identifier, items: collectionViewDataSource, style: Section(rawValue: 3)))
//        delegate.updateCollectionViewDataSource(dataSourceSection)
//    }
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
                        self.customers = client
                        self.delegate.showLoading(false)
                        self.delegate.updateSnapshot(clients: client)
                        self.delegate.refreshController()
                    }
                case .failure(let err):
                    print("DEBUG: Failed fetch data from firestore\(err.localizedDescription)")
                }
            }
        case .refreshView(_):
//            self.customers.removeAll()
            send(action: .fetchCustomersList)
        }
    }
}

public extension CaseIterable where Self: Equatable {
    var index: Self.AllCases.Index {
        return Self.allCases.firstIndex(of: self)!
    }
}
