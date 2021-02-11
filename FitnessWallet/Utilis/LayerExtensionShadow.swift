//
//  LayerExtensionShadow.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 06/01/2021.
//

import UIKit

extension CALayer {
    enum ShadowType {
        case loginRegButton
        case cell
        case alert
        case overlayContainer
        case acceptButton
        case iconButton
    }
    
    func addShadow(type: ShadowType) {
        switch type {
        case .loginRegButton:
            shadowOffset = CGSize(width: 0, height: -8.0)
            shadowOpacity = 2.0
            shadowRadius = 4.0
            shadowColor = UIColor.shadow.cgColor
        case .cell:
            cornerRadius = 4.0
            shadowOffset = CGSize(width: 0.0, height: 4.0)
            shadowColor = UIColor.shadow.cgColor
            shadowOpacity = 1.0
            shadowRadius = 10.0
        case .alert:
            cornerRadius = 4.0
            shadowOffset = CGSize(width: 0.0, height: 4.0)
            shadowColor = UIColor.shadow.cgColor
            shadowOpacity = 1.0
            shadowRadius = 10.0
        case .overlayContainer:
            masksToBounds = false
            cornerRadius = 6.0
            shadowOffset = CGSize(width: 0.0, height: -11.0)
            shadowColor = UIColor.dashboardTicketsViewCellShadow.cgColor
            shadowOpacity = 0.5
            shadowRadius = 8.0
            maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        case .acceptButton:
            masksToBounds = false
            cornerRadius = 6.0
            shadowOffset = CGSize(width: -4.0, height: -11.0)
            shadowColor = UIColor.dashboardTicketsViewCellShadow.cgColor
            shadowOpacity = 0.5
            shadowRadius = 8.0
        case .iconButton:
            masksToBounds = false
            shadowOffset = CGSize(width: 0, height: 0)
            cornerRadius = 12.0
            shadowOpacity = 2.0
            shadowRadius = 4.0
            shadowColor = UIColor.dashboardTicketsViewCellShadow.cgColor
        }
    }
}
