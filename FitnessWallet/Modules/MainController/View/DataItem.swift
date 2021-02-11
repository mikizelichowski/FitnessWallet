//
//  DataItem.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 10/01/2021.
//

import Foundation

struct Model: Hashable {
    let identifier = UUID()
    let dataItem: DataItem
    
    init(dataItem: DataItem) {
        self.dataItem = dataItem
    }
    
    static func == (lhs: Model, rhs: Model) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

enum DataItem: Hashable {
    case exercises(Customers)
    case customers(Customers)
    case remaining(Customers)
}
