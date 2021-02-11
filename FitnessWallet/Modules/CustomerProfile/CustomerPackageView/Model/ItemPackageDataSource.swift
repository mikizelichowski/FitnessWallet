//
//  ItemPackageDataSource.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 26/01/2021.
//

import Foundation

struct ItemPackageDataSource: Hashable {
    let id = UUID().uuidString
    let packageItem: [PackageModel]
    
    init(packageItem: [PackageModel]) {
        self.packageItem = packageItem
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ItemPackageDataSource, rhs: ItemPackageDataSource) -> Bool {
        return lhs.id == rhs.id
    }
}
