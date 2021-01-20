//
//  NumberLabelDescriptionView.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 10/01/2021.
//

import UIKit

struct NumberLabelDescriptionViewModel {
    let number: Int
    let title: String
    let description: String
}

final class NumberLabelDescriptionView: UIView {
    private enum Constants {
        static let numberLabelAlpha: CGFloat = 0.5
        static let cornerRadius: CGFloat = 4.0
    }
    
    private let contantStackView = UIStackView()
    private let numberLabel = UILabel()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        [numberLabel, contantStackView].forEach{ addSubview($0)}
        [titleLabel, descriptionLabel].forEach{ contantStackView.addArrangedSubview($0)}
        numberLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        contantStackView.anchor(top: topAnchor,
                                left: leftAnchor,
                                bottom: bottomAnchor,
                                right: rightAnchor,
                                paddingTop: 12,
                                paddingLeft: 12,
                                paddingBottom: 12,
                                paddingRight: 12)
    }
    
    private func setupView() {
        setupLayout()
        numberLabel.textColor = UIColor.blueDark.withAlphaComponent(Constants.numberLabelAlpha)
        numberLabel.backgroundColor = .lightGray
        numberLabel.textAlignment = .center
        numberLabel.layer.masksToBounds = true
        numberLabel.layer.cornerRadius = Constants.cornerRadius
        titleLabel.textColor = .blueDark
        titleLabel.font = .font(with: .bold, size: .bigMedium)
        descriptionLabel.textColor = .blueDark
        descriptionLabel.font = .font(with: .regular, size: .small)
        descriptionLabel.numberOfLines = .zero
    }
    
    func update(model: NumberLabelDescriptionViewModel) {
        numberLabel.text = "\(model.number)"
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
}
