//
//  SectionCustomerProfileDataSource.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 22/01/2021.
//

import Foundation

struct SectionCustomerProfileDataSource: Hashable {
    let id = UUID().uuidString
    var items: [ItemCustomerProfileDataSource]
    var sectionStyle: SectionCustomerProfile

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: SectionCustomerProfileDataSource, rhs: SectionCustomerProfileDataSource) -> Bool {
        lhs.id == rhs.id
    }
}

enum SectionCustomerProfile: Int, CaseIterable, Hashable {
    case package
    case trainingList
    case exercises

    var sectionHeader: String {
        switch self {
        case .package: return "Select a package:"
        case .trainingList: return "Numbers of training: "
        case .exercises: return "Exercises: "
        }
    }
}
