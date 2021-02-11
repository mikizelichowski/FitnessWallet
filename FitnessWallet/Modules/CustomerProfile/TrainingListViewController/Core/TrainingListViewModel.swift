//
//  TrainingListViewModel.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 28/01/2021.
//

import UIKit

protocol TrainingListViewModelProtocol: class {
    var delegate: TrainingListViewModelDelegate! { get set }
    
    var sectionDataSource: [SectionTrainingListDataSource] { get }
    func onViewDidLoad()
    func send(action: Action)
}

protocol TrainingListViewModelDelegate: class {
    func updateSnapshotPackage(with model: [PackageModel])
}

final class TrainingListViewModel {
    weak var delegate: TrainingListViewModelDelegate!
    
    var packageModel = [PackageModel]()
    var customerModel: Customers?
    private var itemDataSource: [ItemTrainingListDataSource] = []
    var sectionDataSource: [SectionTrainingListDataSource] = []
    
    func prepareCell() {
        sectionDataSource.append(SectionTrainingListDataSource(items: itemDataSource, packedModel: packageModel))
    }
}

extension TrainingListViewModel: TrainingListViewModelProtocol {
    
    func onViewDidLoad() {
        prepareCell()
        send(action: .fetchCustomersList)
    }
    
    func send(action: Action) {
        switch action {
        case .fetchCustomersList: ()
        case .refreshView(_): ()
        }
    }
}
