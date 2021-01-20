//
//  UITableViewExtension.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.identifier)
    }
    
    func dequeueReusableTableViewCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}
