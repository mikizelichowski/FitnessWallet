//
//  ItemTrainingListDataSource.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 28/01/2021.
//

import Foundation

struct ItemTrainingListDataSource: Hashable {
    var id = UUID()
    let dataItem: [PackageModel]
    
    init(dataItem: [PackageModel]) {
        self.dataItem = dataItem
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ItemTrainingListDataSource, rhs: ItemTrainingListDataSource) -> Bool {
        lhs.id == rhs.id
    }
}

