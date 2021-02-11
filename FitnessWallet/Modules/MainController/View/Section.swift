//
//  Section.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 10/01/2021.
//

import UIKit

struct SectionModel: Hashable {
    let identifier: UUID = UUID()
    var items: [Model]?
    var sectionStyle: Section
    
    init(style: Section) {
        self.sectionStyle = style
    }
    
    static func == (lhs: SectionModel, rhs: SectionModel) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

enum Section: Int, CaseIterable, Hashable {
    case training
    case customerList
    case remaining
    
    var sectionHeader: String {
        switch self {
        case .training: return "Last exercises"
        case .customerList: return "Customers"
        case .remaining: return "Categories"
        }
    }
}
