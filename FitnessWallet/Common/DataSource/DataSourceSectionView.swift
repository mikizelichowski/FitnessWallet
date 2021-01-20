//
//  DataSourceSectionView.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import Foundation
import UIKit

class DataSourceSectionView<T: DataSourceSection>: UITableViewHeaderFooterView {
    
    var model: T! {
        didSet {
            update()
        }
    }
    
    func update() {
        
    }
}
