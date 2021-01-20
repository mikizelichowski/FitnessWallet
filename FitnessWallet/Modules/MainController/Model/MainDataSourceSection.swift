//
//  MainDataSourceSection.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 18/01/2021.
//

import Foundation

struct MainDataSourceSection: DataSourceSection, Hashable {
    let identity: String
    let viewIdentifier: String?
    var title: String?
    var items: [MainDataSourceItem]
    var style: Section?
}
