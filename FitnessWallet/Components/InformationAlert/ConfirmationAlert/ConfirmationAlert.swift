//
//  ConfirmationAlert.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 10/01/2021.
//

import UIKit

final class ConfirmationAlert: UIView {
    private enum Constants {
        static let buttonLineWidth: CGFloat = 1.0
        static let imageAlpha: CGFloat = 0.3
    }
    
    private let stackView = UIStackView()
    private let button = UIButton()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    private var buttonTapClosure: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setupLayout()
        setupViewLabels()
        setupViewImages()
        setupViewButtons()
        BorderLayer.instantiate(view: button, lineWidth: Constants.buttonLineWidth, strokeColor: .lineConnecting, borders: .top)
    }
    
    private func setupLayout() {
        [imageView, stackView, button].forEach{ addSubview($0)}
        imageView.anchor(top: topAnchor,
                         left: leftAnchor,
                         paddingTop: 12,
                         paddingLeft: 12)
        imageView.setDimensions(height: 24, width: 24)
        [titleLabel, descriptionLabel].forEach { stackView.addArrangedSubview($0)}
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.anchor(top: safeAreaLayoutGuide.topAnchor,
                         left: safeAreaLayoutGuide.leftAnchor,
                         right: safeAreaLayoutGuide.rightAnchor,
                         paddingTop: 24,
                         paddingLeft: 12,
                         paddingRight: 12)
        button.setHeight(40)
        button.anchor(top: stackView.bottomAnchor,
                      left: safeAreaLayoutGuide.leftAnchor,
                      bottom: safeAreaLayoutGuide.bottomAnchor,
                      right: safeAreaLayoutGuide.rightAnchor,
                      paddingTop: 20,
                      paddingLeft: 12,
                      paddingRight: 12)
    }
    
    private func setupViewLabels() {
        titleLabel.textColor = .blueDark
        titleLabel.font = .font(with: .bold, size: .bigMedium)
        titleLabel.numberOfLines = .zero
        descriptionLabel.textColor = .blueDark
        descriptionLabel.numberOfLines = .zero
        descriptionLabel.font = .font(with: .regular, size: .smallerMedium)
    }
    
    private func setupViewImages() {
        imageView.tintColor = UIColor.blueDark.withAlphaComponent(Constants.imageAlpha)
    }
    
    private func setupViewButtons() {
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .font(with: .bold, size: .smallerMedium)
    }
    
    func updateView(buttonTitle: String, imageView: ImageAsset, titleText: String, descriptionText: String, buttonTapClosure: (() -> ())? = nil) {
        button.setTitle(buttonTitle, for: .normal)
        self.imageView.image = imageView.image
        self.titleLabel.text = titleText
        self.descriptionLabel.text = descriptionText
        self.buttonTapClosure = buttonTapClosure
    }
    
    @objc
    func buttonTap() {
        buttonTapClosure?()
    }
}
