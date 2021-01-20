//
//  DataSourceSection.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import Foundation

protocol DataSourceSection: DataSourceIdentifiable {
    associatedtype Item: DataSourceIdentifiable & Equatable & Hashable
    
    var items: [Item] { get }
    var title: String? { get }
}
