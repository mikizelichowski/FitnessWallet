//
//  DataSourceCell.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import Foundation
import UIKit.UITableViewCell

class DataSourceCell<T: DataSourceIdentifiable & Equatable & Hashable>: UITableViewCell {
    
    var model: T! {
        didSet {
            update()
        }
    }
    
    func update() { }
}
