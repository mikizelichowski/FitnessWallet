//
//  Customer.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 10/01/2021.
//

import Foundation

struct Customer: Equatable, Hashable {
    let username: String
    let imageUrl: String
    let trainingPackage: Int
}

////////////////////////////////
enum SectionCollect: CaseIterable {
    case config, networks
}

enum ItemType {
    case wifiEnabled, currentNetwork, availableNetwork
}

struct Item: Hashable {
    let title: String
    let type: ItemType
//    let network: Wif
    
    init(title: String, type: ItemType) {
        self.title = title
        self.type = type
//        self.network = nil
        self.identifier = UUID()
    }
//    init(network: WIFIController.Network) {
//        self.title = network.name
//        self.type = .availableNetwork
//        self.identifier = newtork.identifier
//    }
    
    var isConfig: Bool {
        let configItems: [ItemType] = [.currentNetwork, .wifiEnabled]
        return configItems.contains(type)
    }
    
    var isNetwork: Bool {
        return type == .availableNetwork
    }
    
    private let identifier: UUID
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.identifier)
    }
}
