//
//  UIFontExtension.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import UIKit

extension UIFont {
    enum Size: CGFloat {
        case superSmall = 10.0
         case smaller = 12.0
         case smallerMedium = 13.0
         case small = 14.0
         case smallMedium = 15.0
         case medium = 16.0
         case bigMedium = 17.0
         case normal = 18.0
         case big = 20.0
         case large = 22.0
         case huge = 24.0
         case extraHuge = 28.0
         case giant = 32.0
        
        var size: CGFloat {
            return self.rawValue
        }
    }
    
    static func font(with type: Weight = .regular, size: Size = .medium) -> UIFont {
        return .systemFont(ofSize: size.size, weight: type)
    }
}
