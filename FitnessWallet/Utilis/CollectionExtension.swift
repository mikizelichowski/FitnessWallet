//
//  CollectionExtension.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import Foundation

enum CollectionItemsCount: Int {
    case oneElement = 1
    case twoItems, threeItems, fourItems, fiveItems, sixItems, sevenItems, eightItems, nineItems, tenItems
}

extension Collection {
    var isNotEmpty: Bool {
        return !isEmpty
    }
    
    func has(just items: CollectionItemsCount) -> Bool {
        return count == items.rawValue
    }
}
