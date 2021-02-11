//
//  CustomersCell.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 11/01/2021.
//

import UIKit
import SDWebImage

final class CustomersCell: UICollectionViewCell {
     let titleLabel = CustomLabel(style: .title)
     let subtitleLabel = CustomLabel(style: .subtitle)
     let profileImageView = CustomImage(style: .profile)
    private let separator = UIView()
    private let spacerView = UIView()
    private let stack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.profileImageView.image = nil
    }
    
    private func configureLayout() {
        backgroundView = UIView()
        backgroundView?.backgroundColor = .white
        backgroundView?.layer.addShadow(type: .iconButton)
        backgroundView?.layer.masksToBounds = true
        
        separator.backgroundColor = .quaternaryLabel
        separator.setHeight(CGFloat(StringRepresentationOfDigit.one))
        [separator, titleLabel, subtitleLabel, spacerView, profileImageView].forEach{ stack.addArrangedSubview($0)}
        contentView.addSubview(stack)
        stack.axis = .vertical
        stack.alignment = .center
        stack.anchor(top: contentView.topAnchor,
                     left: contentView.leftAnchor,
                     bottom: contentView.bottomAnchor,
                     right: contentView.rightAnchor,
                     paddingTop: CGFloat(StringRepresentationOfDigit.four),
                     paddingBottom: CGFloat(StringRepresentationOfDigit.ten))
        stack.setCustomSpacing(10, after: separator)
        stack.setCustomSpacing(10, after: subtitleLabel)
    }
    
    func populate(with customer: Customers) {
        guard let profileImageUrl = URL(string: customer.imageUrl) else { return }
        profileImageView.sd_setImage(with: profileImageUrl)
        titleLabel.text = customer.username
        subtitleLabel.text = String(customer.weight)
    }
}
