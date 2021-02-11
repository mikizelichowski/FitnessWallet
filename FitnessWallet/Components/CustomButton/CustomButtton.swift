//
//  CustomButtton.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 24/01/2021.
//

import UIKit

enum StyleCustomButton {
    case packageTraining
    case trainingList
    case exercises
    case statistic
}

final class CustomButtton: UIButton {
    private enum Constants {
        static let imageEdgeInsets =  UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        static let setDimensions: CGFloat = 60.0
    }
    
    private var appearanceStyle: StyleCustomButton = .packageTraining
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switchStyle()
    }
    
    func setup(title: String? = nil, style: StyleCustomButton = .packageTraining, image: UIImage? = nil) {
        setTitle(title, for: .normal)
        setImage(image, for: .normal)
        appearanceStyle = style
        setupInsets()
        setupAppearance()
    }
    
    func setupInsets() {
        titleEdgeInsets = .zero
        imageEdgeInsets = Constants.imageEdgeInsets
    }
    
    func setupAppearance() {
        clipsToBounds = true
        layer.cornerRadius = CGFloat(StringRepresentationOfDigit.five)
        tintColor = .lightGray
        backgroundColor = .white
    }
    
    private func switchStyle() {
        switch appearanceStyle {
        case .packageTraining:
            setImage(UIImage(systemName: Asset.dollarsign_circle.name), for: .normal)
            layer.addShadow(type: .iconButton)
            setDimensions(height: Constants.setDimensions, width: Constants.setDimensions)
        case .trainingList:
            setImage(UIImage(systemName: Asset.pencil_and_ellipsis.name), for: .normal)
            layer.addShadow(type: .iconButton)
            setDimensions(height: Constants.setDimensions, width: Constants.setDimensions)
        case .exercises:
            setImage(UIImage(systemName: Asset.flame.name), for: .normal)
            layer.addShadow(type: .iconButton)
            setDimensions(height: Constants.setDimensions, width: Constants.setDimensions)
        case .statistic:
            setImage(UIImage(systemName: Asset.chart_pie.name), for: .normal)
            layer.addShadow(type: .iconButton)
            setDimensions(height: Constants.setDimensions, width: Constants.setDimensions)
        }
    }
}
