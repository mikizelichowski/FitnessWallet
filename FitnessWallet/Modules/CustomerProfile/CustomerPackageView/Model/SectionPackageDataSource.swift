//
//  SectionPackageDataSource.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 26/01/2021.
//

import Foundation

struct SectionPackageDataSource: Hashable {
    let id = UUID().uuidString
    var items: [ItemPackageDataSource]
    var model: [PackageModel]
    var sectionStyle: SectionPackageStyle
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: SectionPackageDataSource, rhs: SectionPackageDataSource) -> Bool {
        return lhs.id == rhs.id
    }
}

enum SectionPackageStyle: Int, CaseIterable, Hashable {
    case package
    
    var title: String {
        switch self {
        case .package: return "Select your package:"
        }
    }
}
