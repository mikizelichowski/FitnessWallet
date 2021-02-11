//
//  CustomImage.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import UIKit

enum StyleImage {
    case custom
    case categories
    case profile
    case profileCustomer
}

class CustomImage: UIImageView {
    private enum Constants {
        static let cornerRadius: CGFloat = 40.0
        static let width: CGFloat = 80.0
        static let height: CGFloat = 80.0
    }
    
    init(style: StyleImage, image: UIImage? = nil) {
        super.init(frame: .zero)
        styles(style, image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func styles(_ style: StyleImage, image: UIImage? = nil) {
        switch style {
        case .custom:
            clipsToBounds = true
            contentMode = .scaleAspectFill
            backgroundColor = .lightGray
            self.image = image
        case .categories:
            tintColor = .lightGray
            self.image = image
            backgroundColor = .lightGray
            clipsToBounds = true
            contentMode = .scaleAspectFill
            setDimensions(height: CGFloat(StringRepresentationOfDigit.fourty),
                          width: CGFloat(StringRepresentationOfDigit.fourty))
            layer.cornerRadius = CGFloat(StringRepresentationOfDigit.four) / CGFloat(StringRepresentationOfDigit.two)
        case .profile:
            clipsToBounds =  true
            contentMode = .scaleAspectFill
            backgroundColor = .lightGray
            layer.cornerRadius = Constants.cornerRadius
            setDimensions(height: Constants.height, width: Constants.width)
        //            layer.addShadow(type: .iconButton)
        case .profileCustomer:
            clipsToBounds = true
            contentMode = .scaleAspectFill
            layer.addShadow(type: .iconButton)
            layer.cornerRadius = Constants.cornerRadius
            setDimensions(height: Constants.height, width: Constants.width)
            backgroundColor = .whiteAlphaTf
        }
    }
    
    func update(_ style: StyleImage) {
        switch style {
        case .custom:
            clipsToBounds = true
            contentMode = .scaleAspectFill
            backgroundColor = .lightGray
            self.image = image
        case .categories:
            tintColor = .lightGray
            self.image = image
            backgroundColor = .lightGray
            clipsToBounds = true
            contentMode = .scaleAspectFill
            setDimensions(height: CGFloat(StringRepresentationOfDigit.fourty),
                          width: CGFloat(StringRepresentationOfDigit.fourty))
            layer.cornerRadius = CGFloat(StringRepresentationOfDigit.four) / CGFloat(StringRepresentationOfDigit.two)
        case .profile:
            clipsToBounds =  true
            contentMode = .scaleAspectFill
            backgroundColor = .lightGray
            layer.cornerRadius = Constants.cornerRadius
            setDimensions(height: Constants.height, width: Constants.width)
        //            layer.addShadow(type: .iconButton)
        case .profileCustomer:
            clipsToBounds = true
            contentMode = .scaleAspectFill
            layer.addShadow(type: .iconButton)
            layer.cornerRadius = Constants.cornerRadius
            setDimensions(height: Constants.height, width: Constants.width)
            backgroundColor = .whiteAlphaTf
        }
        
    }
}
