//
//  MainDataSourceItem.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 18/01/2021.
//

import UIKit

struct MainDataSourceItem: DataSourceIdentifiable & Equatable & Hashable {
    let identity: String
    let viewIdentifier: String?
    let title: String
    let subtitle: String
    let imageUrl: String?
    let dataItem: DataItem
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(viewIdentifier)
    }
    
    static func == (lhs: MainDataSourceItem, rhs: MainDataSourceItem) -> Bool {
        return lhs.identity == rhs.identity
    }
}
