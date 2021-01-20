//
//  RoundedButton.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 06/01/2021.
//

import UIKit

final class RoundedButton: UIButton {
    enum Style {
        case light
        case login
        case register
        case acceptBottom
        case cancelBottom
    }
    
    private enum Constants {
        enum Margin {
            static let normal: CGFloat = 12.0
            static let small: CGFloat = 6.0
        }
        static let alphaBackgroundColor: CGFloat = 0.2
        static let highLighted: CGFloat = 0.7
        static let cancelButtonAlpha: CGFloat = 0.7
        static let setHeight: CGFloat = 50.0
        static let borderWidth: CGFloat = 0.5
    }
    
    private var appearanceStyle: Style = .light
    
    override var isEnabled: Bool {
        set {
            super.isEnabled = newValue
            alpha = newValue ? 1.0 : 0.5
        } get {
            return super.isEnabled
        }
    }
    
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
    
    func setup(title: String, style: Style = .light, image: UIImage? = nil) {
        setTitle(title, for: .normal)
        setImage(image, for: .normal)
        appearanceStyle = style
        setupInsets()
        setupAppearance()
    }
    
    func setupInsets() {
        titleEdgeInsets = .zero
        imageEdgeInsets = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: Constants.Margin.small)
    }
    
    func setupAppearance() {
        clipsToBounds =  true
        layer.cornerRadius = CGFloat(StringRepresentationOfDigit.five)
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        titleLabel?.font = .font(with: .bold, size: .smallMedium)
        tintColor = .white
    }
    
    private func switchStyle() {
        switch appearanceStyle {
        case .light:
            setTitleColor(UIColor.systemBlue.withAlphaComponent(Constants.highLighted), for: .highlighted)
            backgroundColor = .white
            layer.borderWidth = Constants.borderWidth
            imageView?.tintColor = .blue
        case .login:
            setTitleColor(.black, for: .normal)
            layer.cornerRadius = CGFloat(StringRepresentationOfDigit.eight)
            setHeight(Constants.setHeight)
            titleLabel?.font = .font(with: .bold, size: .big)
            layer.addShadow(type: .loginRegButton)
        case .register:
            setTitleColor(.black, for: .normal)
            layer.cornerRadius = CGFloat(StringRepresentationOfDigit.eight)
            setHeight(Constants.setHeight)
            titleLabel?.font = .font(with: .bold, size: .big)
            layer.addShadow(type: .loginRegButton)
        case .acceptBottom:
            setTitleColor(.blueDark, for: .normal)
            setTitleShadowColor(.blueDark, for: .highlighted)
            backgroundColor = .whiteAlphaTf
            layer.borderColor = UIColor.blueDark.cgColor
            layer.borderWidth = Constants.borderWidth
            layer.cornerRadius = CGFloat(StringRepresentationOfDigit.eight)
            setHeight(Constants.setHeight)
            layer.addShadow(type: .acceptButton)
            titleLabel?.font = .font(with: .semibold, size: .smallMedium)
        case .cancelBottom:
            setTitleColor(.white, for: .normal)
            backgroundColor = .lightGray
            layer.borderWidth = Constants.borderWidth
            layer.borderColor = UIColor.white.cgColor
            setHeight(Constants.setHeight)
            titleLabel?.font = .font(with: .regular, size: .smallMedium)
        }
    }
}
