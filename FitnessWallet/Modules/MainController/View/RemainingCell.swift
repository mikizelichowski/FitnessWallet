//
//  RemainingCell.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 11/01/2021.
//

import UIKit
import SDWebImage

final class RemainingCell: UICollectionViewCell {
    private let titleLabel = CustomLabel(style: .title)
    private let subtitleLabel = CustomLabel(style: .subtitle)
    private let imageView = CustomImage(style: .custom)
    private let textStack = UIStackView()
    private let horizontalStack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    private func setupLayout() {
        backgroundColor = .white
        imageView.layer.cornerRadius = CGFloat(StringRepresentationOfDigit.ten)
        [titleLabel, subtitleLabel].forEach { textStack.addArrangedSubview($0)}
        textStack.axis = .vertical
        [imageView, textStack].forEach { horizontalStack.addArrangedSubview($0)}
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        horizontalStack.spacing = CGFloat(StringRepresentationOfDigit.ten)
        contentView.addSubview(horizontalStack)
        
        let imageWidthConstraint = imageView.widthAnchor.constraint(equalToConstant: CGFloat(StringRepresentationOfDigit.hundred))
        imageWidthConstraint.priority = .defaultHigh + Float(StringRepresentationOfDigit.one)
        NSLayoutConstraint.activate([
            imageWidthConstraint, imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.6)
        ])
        horizontalStack.anchor(top: contentView.topAnchor,
                               left: contentView.leftAnchor,
                               bottom: contentView.bottomAnchor,
                               right: contentView.rightAnchor,
                               paddingTop: CGFloat(StringRepresentationOfDigit.eight),
                               paddingLeft: CGFloat(StringRepresentationOfDigit.eight),
                               paddingBottom: CGFloat(StringRepresentationOfDigit.eight),
                               paddingRight: CGFloat(StringRepresentationOfDigit.eight))
    }
    
    func populate(with remaining: Customers) {
        guard let imageViewURL = URL(string: remaining.imageUrl) else { return }
        imageView.sd_setImage(with: imageViewURL)
        titleLabel.text = remaining.username
        subtitleLabel.text = remaining.surname
    }
}
