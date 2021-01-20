//
//  CollectionCellDataSource.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import Foundation
import UIKit.UICollectionViewCell

class CollectionCellDataSource<T: DataSourceIdentifiable & Equatable & Hashable>: UICollectionViewCell {
    var model: T! {
        didSet {
            update()
        }
    }
    
    func update() {
        
    }
}
