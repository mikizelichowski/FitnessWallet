//
//  FeedCell.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import UIKit

enum Categories: Int, CaseIterable {
    case customerList
    case exercises
    
    var title: String {
        switch self {
        case .customerList: return "Customer List"
        case .exercises: return "Exercises"
        }
    }
}

final class ExercisesCell: UICollectionViewCell {
    private let titleLabel = CustomLabel(style: .title)
    private let subtitleLabel = CustomLabel(style: .subtitle)
    private let iconImage = CustomImage(style: .custom)
    private let separator = UIView()
    private let spacer = UIView()
    private let stack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImage.image = nil
    }
    
    private func setupLayout() {
        setupCell()
        separator.backgroundColor = .white
        separator.setHeight(CGFloat(StringRepresentationOfDigit.two))
        spacer.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        spacer.setContentHuggingPriority(.defaultLow, for: .vertical)
        [ separator, titleLabel, subtitleLabel, spacer, iconImage ].forEach { stack.addArrangedSubview($0)}
        stack.axis = .vertical
        contentView.addSubview(stack)
        stack.anchor(top: contentView.topAnchor,
                     left: contentView.leftAnchor,
                     bottom: contentView.bottomAnchor,
                     right: contentView.rightAnchor,
                     paddingTop: CGFloat(StringRepresentationOfDigit.eight),
                     paddingLeft: CGFloat(StringRepresentationOfDigit.eight),
                     paddingBottom: CGFloat(StringRepresentationOfDigit.eight),
                     paddingRight: CGFloat(StringRepresentationOfDigit.eight))
        
        stack.setCustomSpacing(10, after: separator)
        stack.setCustomSpacing(10, after: subtitleLabel)
    }
    
    private func setupCell() {
        iconImage.layer.cornerRadius = CGFloat(StringRepresentationOfDigit.eight)
        titleLabel.updateStyle(.title)
    }
    
    func populate(with exercise: Customers) {
        guard let imageUrl = URL(string: exercise.imageUrl) else { return }
        iconImage.sd_setImage(with: imageUrl)
        titleLabel.text = exercise.username
        subtitleLabel.text = exercise.surname
    }
}
