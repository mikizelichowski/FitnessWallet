//
//  PackageViewModel.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 26/01/2021.
//

import Foundation

enum ActionPackageDelegate {
    case refreshController
    case showLoading(_ state: Bool)
    case alertMessage(title: String, message: String, completion: (() -> Void)?)
}

enum ActionPackage {
    case fetchPackage
    case refreshView(_ state: Bool)
}

protocol PackageViewModelProtocol: class {
    var delegate: PackageViewModelDelegate! { get set }
    
    var sectionDataSource: [SectionPackageDataSource] { get }
    
    func send(action: ActionPackage)
    func onViewDidLoad()
    func updateSelectedData(with index: DataPackage)
}

protocol PackageViewModelDelegate: class {
    func updateSnapshot(with model: [PackageModel])
    func showAction(action: ActionPackageDelegate)
}

final class PackageViewModel {
    weak var delegate: PackageViewModelDelegate!
    
    private let coordinator: CustomerProfileCoordinatorProtocol
    var packageModel = [PackageModel]()
    
    var customers: Customers?
    
    var itemDataSource: [ItemPackageDataSource] = []
    var sectionDataSource: [SectionPackageDataSource] = []
    
    init(with coordinator: CustomerProfileCoordinatorProtocol = CustomerProfileCoordinator(navigationController: ModalNavigationController())) {
        self.coordinator = coordinator
    }
    
    func prepareCell() {
        sectionDataSource.append(SectionPackageDataSource(items: itemDataSource, model: packageModel, sectionStyle: .package))
    }
}

extension PackageViewModel: PackageViewModelProtocol {
    func updateSelectedData(with index: DataPackage) {
        switch index {
        case .package(let package):
            guard let client = customers else { return }
            PackageService.addSelectedPackage(packageId: package.packageId, customerId: client.customerId) { result in
                switch result {
                case .success(_):
                    // create alert later !
                    print("DEBUG: Successfully add package for customer")
                case .failure(let error):
                    print("DEBUG: \(ErrorAPI.uploadData)\(error.localizedDescription)")
                }
            }
        }
    }
    
    func onViewDidLoad() {
        prepareCell()
        send(action: .fetchPackage)
    }
    
    func send(action: ActionPackage) {
        switch action {
        case .fetchPackage:
            PackageService.fetchPackage { result in
                self.delegate.showAction(action: .showLoading(true))
                switch result {
                case .success(let card):
                    DispatchQueue.main.async {
                        self.delegate.showAction(action: .showLoading(false))
                        self.delegate.updateSnapshot(with: card)
                        self.delegate.showAction(action: .refreshController)
                    }
                case .failure(let error):
                    print("\(ErrorAPI.fetchData)\(error.localizedDescription)")
                }
            }
        case .refreshView(_):
            send(action: .fetchPackage)
        }
    }
}
