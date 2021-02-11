//
//  SectionCustomersList.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 21/01/2021.
//

import UIKit

struct SectionCustomerListDataSource: Hashable {
    var id = UUID()
    var items: [ItemCustomersListDataSource]
    
    init(items: [ItemCustomersListDataSource]) {
        self.items = items
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: SectionCustomerListDataSource, rhs: SectionCustomerListDataSource) -> Bool {
        return lhs.id == rhs.id
    }
}
