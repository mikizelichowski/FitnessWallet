//
//  TrainingListCell.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 28/01/2021.
//

import UIKit

final class TrainingListCell: UITableViewCell {
    private enum Constants {
        static let paddingLeft: CGFloat = 32.0
    }
    
    private let content = UIView()
    private let packageTitleLabel = CustomLabel(style: .title)
    private let numberTraining = CustomLabel(style: .subtitle)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(content)
        backgroundColor = .white
        [packageTitleLabel, numberTraining].forEach { content.addSubview($0)}
        content.fillSuperView()
        content.layer.addShadow(type: .iconButton)
        packageTitleLabel.anchor(top: content.topAnchor,
                                 left: content.leftAnchor,
                                 paddingTop: CGFloat(StringRepresentationOfDigit.twelve),
                                 paddingLeft: CGFloat(StringRepresentationOfDigit.twelve))
        numberTraining.centerX(inView: content)
        numberTraining.centerY(inView: content, leftAnchor: packageTitleLabel.rightAnchor, paddingLeft: Constants.paddingLeft)
    }
    
    func update(with model: PackageModel) {
        packageTitleLabel.text = model.titlePackage
        numberTraining.text =  "32" //model.selectedPackageId -> numberOfTraining
    }
}
