//
//  UIButtonExtension.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 06/01/2021.
//

import UIKit

extension UIButton {
    func attributedTitle(firstTitle: String, secondTitle: String) {
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 0, alpha: 1), .font: UIFont.systemFont(ofSize: 12)]
        let attributedTitle = NSMutableAttributedString(string: "\(firstTitle) ", attributes: atts)
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 0, alpha: 0.87), .font: UIFont.boldSystemFont(ofSize: 14)]
        attributedTitle.append(NSAttributedString(string: secondTitle, attributes: boldAtts))
        setAttributedTitle(attributedTitle, for: .normal)
    }
}
