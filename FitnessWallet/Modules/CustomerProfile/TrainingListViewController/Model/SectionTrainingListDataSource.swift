//
//  SectionTrainingListDataSource.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 28/01/2021.
//

import Foundation

struct SectionTrainingListDataSource: Hashable {
    var id = UUID()
    var items: [ItemTrainingListDataSource]
    var model: [PackageModel]
    
    init(items: [ItemTrainingListDataSource], packedModel: [PackageModel]) {
        self.items = items
        self.model = packedModel
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: SectionTrainingListDataSource, rhs: SectionTrainingListDataSource) -> Bool {
        return lhs.id == rhs.id
    }
}
