//
//  CollectionHeaderDataSource.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import Foundation
import UIKit.UICollectionViewCell


class CollectionHeaderDataSource<T: DataSourceSection>: UICollectionReusableView {
    var model: T! {
        didSet {
            update()
        }
    }
    
    func update() {
        
    }
}
