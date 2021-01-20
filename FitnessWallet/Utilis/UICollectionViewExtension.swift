//
//  UICollectionViewExtension.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.identifier)
    }
        
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}

