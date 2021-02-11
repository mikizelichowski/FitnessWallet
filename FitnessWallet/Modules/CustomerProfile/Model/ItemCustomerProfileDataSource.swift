//
//  ItemCustomerProfileDataSource.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 22/01/2021.
//

import Firebase

struct ItemCustomerProfileDataSource: Hashable {
    let id = UUID()
    let dataCustomerProfile: DataCustomerProfile
    
    init(dataItem: DataCustomerProfile) {
        self.dataCustomerProfile = dataItem
    }
    
    static func == (lhs: ItemCustomerProfileDataSource, rhs: ItemCustomerProfileDataSource) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum DataCustomerProfile: Hashable {
    case package(PackageModel)
    case trainingList(TrainingList)
    case exercises(Exercises)
}

struct TrainingList: Hashable, Equatable {
    let name: String
    let subtitle: String
    let imageProfile: String
    let dateSell: Timestamp
}

struct Exercises: Hashable, Equatable {
    let kindOfTraining: String
}
