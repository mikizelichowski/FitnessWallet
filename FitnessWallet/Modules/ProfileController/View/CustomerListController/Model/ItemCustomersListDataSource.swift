//
//  ItemCustomersListDataSource.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 21/01/2021.
//

import Foundation

struct ItemCustomersListDataSource: Hashable {
    var id = UUID()
    let dataItem: [Customers]
    
    init(dataItem: [Customers]) {
        self.dataItem = dataItem
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ItemCustomersListDataSource, rhs: ItemCustomersListDataSource) -> Bool {
        lhs.id == rhs.id
    }
}
