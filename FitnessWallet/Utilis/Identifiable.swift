//
//  Identifiable.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import UIKit

protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIView: Identifiable {}
