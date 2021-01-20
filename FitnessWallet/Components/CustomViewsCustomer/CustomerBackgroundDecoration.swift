//
//  CustomerBackgroundDecoration.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 05/01/2021.
//

import UIKit

final class CustomerBackgroundDecoration: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.clear(rect)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: colorSpace, colors: [
            UIColor.black.cgColor,
            UIColor.greyBlueLight.cgColor
        ] as CFArray, locations: nil)!
        context.drawLinearGradient(gradient, start: CGPoint(x: 0, y: bounds.minY), end: CGPoint(x: 0, y: bounds.maxY), options: [])
    }
}

//secondarySystemGroupedBackground
