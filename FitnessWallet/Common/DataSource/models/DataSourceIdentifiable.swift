//
//  DataSourceIdentifiable.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import Foundation

protocol DataSourceIdentifiable: Equatable {
    associatedtype Identiy: Hashable
    
    var identity: Identiy { get }
    var viewIdentifier: String? { get }
}
