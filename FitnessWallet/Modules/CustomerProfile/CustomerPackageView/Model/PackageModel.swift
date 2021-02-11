//
//  PackageModel.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 26/01/2021.
//

import Firebase

struct ItemPackageModels: Hashable {
    let id = UUID()
    let dataItem: DataPackage
    
    init(dataItem: DataPackage) {
        self.dataItem = dataItem
    }
    
    static func == (lhs: ItemPackageModels, rhs: ItemPackageModels) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum DataPackage: Hashable {
    case package(PackageModel)
}

struct PackageModel: Hashable, Equatable {
    let titlePackage: String
    var trainerName: String
    let numberOfPackage: Int
    let packageId: String
    let sellerTrainerId: String
    let dateSell: Timestamp
    let selectedPackageId: String
    let customerId: String
    
    init(dictionary: [String: Any]) {
        self.titlePackage = dictionary[Endpoint.Package.titlePackage] as? String ?? .empty
        self.trainerName = dictionary["trainerName"] as? String ?? .empty
        self.numberOfPackage = dictionary[Endpoint.Package.numberOfPackage] as? Int ?? 0
        self.packageId = dictionary[Endpoint.Package.packageId] as? String ?? .empty
        self.sellerTrainerId = dictionary[Endpoint.Package.sellerTrainerId] as? String ?? .empty
        self.dateSell = dictionary[Endpoint.Package.dataSell] as? Timestamp ?? Timestamp(date: Date())
        self.selectedPackageId = dictionary[Endpoint.Package.selectedPackageId] as? String ?? .empty
        self.customerId = dictionary[Endpoint.Package.customerId] as? String ?? .empty
    }
}
