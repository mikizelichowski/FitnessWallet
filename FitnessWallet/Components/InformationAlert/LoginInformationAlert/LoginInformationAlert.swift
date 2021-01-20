//
//  LoginInformationAlert.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 10/01/2021.
//

import UIKit

final class LoginInformationAlert: UIView {
    private enum Constants {
        static let buttonLineWidth: CGFloat = 1.0
    }
    
    private let button = UIButton()
    private let imageView = UIImageView()
    private let stackView = UIStackView()
    private let activityIndicator = UIActivityIndicatorView()
    
    private var buttonTapClosure: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        imageView.setDimensions(height: 66, width: 146)
        imageView.anchor(top: safeAreaLayoutGuide.topAnchor)
        imageView.centerX(inView: self)
        stackView.anchor(top: imageView.bottomAnchor,
                         left: safeAreaLayoutGuide.leftAnchor,
                         right: safeAreaLayoutGuide.rightAnchor,
                         paddingTop: 24,
                         paddingLeft: 16,
                         paddingRight: 16)
        activityIndicator.centerX(inView: self)
        activityIndicator.anchor(top: stackView.bottomAnchor,
                                 paddingTop: 24)
        button.centerX(inView: self)
        button.setHeight(40)
        button.anchor(top: activityIndicator.bottomAnchor,
                      left:safeAreaLayoutGuide.leftAnchor,
                      bottom: safeAreaLayoutGuide.bottomAnchor,
                      right: safeAreaLayoutGuide.rightAnchor,
                      paddingTop: 24)
    }
    
    private func setupView() {
        setupLayout()
        activityIndicator.style = .medium
        button.titleLabel?.font = .font(with: .bold, size: .smallerMedium)
        button.setTitleColor(.black, for: .normal)
        BorderLayer.instantiate(view: button, lineWidth: Constants.buttonLineWidth, strokeColor: .lineConnecting, borders: .top)
    }
    
    func updateView(buttonTitle: String, imageView: ImageAsset, buttonTapClosure: (() -> ())? = nil) {
        button.setTitle(buttonTitle, for: .normal)
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        self.imageView.image = imageView.image
        self.buttonTapClosure = buttonTapClosure
//        stackViewItems.forEach {
//            stackView.addArrangedSubview($0)
//        }
        activityIndicator.startAnimating()
    }
    
    @objc func buttonTap() {
        buttonTapClosure?()
    }
}
