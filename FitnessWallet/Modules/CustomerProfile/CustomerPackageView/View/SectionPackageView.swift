//
//  SectionPackageView.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 26/01/2021.
//

import UIKit

final class SectionPackageView: UICollectionReusableView {
    private enum Constants {
        static let reuseIdentifier = "section-header-reusable"
    }
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(label)
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .greyBlueLight
        label.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
    }
}
