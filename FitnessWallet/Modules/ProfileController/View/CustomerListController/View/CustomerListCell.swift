//
//  CustomerListCell.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 20/01/2021.
//

import UIKit

final class CustomerListCell: UITableViewCell {
    private let titleLabel = CustomLabel(style: .title)
    private let numbersTraining = CustomLabel(style: .subtitle)
    private let profileImageView = CustomImage(style: .profile)
    private let textStackView = UIStackView()
    private let horizontalStack = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .white
        profileImageView.layer.cornerRadius = CGFloat(StringRepresentationOfDigit.ten)
        [titleLabel, numbersTraining].forEach { textStackView.addArrangedSubview($0)}
        textStackView.axis = .vertical
        [profileImageView, textStackView].forEach { horizontalStack.addArrangedSubview($0)}
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        horizontalStack.spacing = CGFloat(StringRepresentationOfDigit.ten)
        addSubview(horizontalStack)
        
        let imageWidthConstraint = profileImageView.widthAnchor.constraint(equalToConstant: CGFloat(StringRepresentationOfDigit.hundred))
        imageWidthConstraint.priority = .defaultHigh + Float(StringRepresentationOfDigit.one)
        NSLayoutConstraint.activate(
            [
                imageWidthConstraint, profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor, multiplier: 0.6)
            ])
        horizontalStack.anchor(top: topAnchor,
                               left: leftAnchor,
                               bottom: bottomAnchor,
                               right: rightAnchor,
                               paddingTop: CGFloat(StringRepresentationOfDigit.eight),
                               paddingLeft: CGFloat(StringRepresentationOfDigit.eight),
                               paddingBottom: CGFloat(StringRepresentationOfDigit.eight),
                               paddingRight: CGFloat(StringRepresentationOfDigit.eight))
    }
    
    func update(with model: Customers) {
        guard let imageURL = URL(string:model.imageUrl) else { return }
        titleLabel.text = model.username
        profileImageView.sd_setImage(with: imageURL)
        numbersTraining.text = model.surname
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
    }
}
