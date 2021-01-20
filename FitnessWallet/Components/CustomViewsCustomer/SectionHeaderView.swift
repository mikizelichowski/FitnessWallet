//
//  SectionHeaderView.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 05/01/2021.
//

import UIKit

enum SectionStyle {
    case mainView
    case trainingView
    case customerView
    case remainingView
}

final class SectionHeaderView: UICollectionReusableView {
    private enum Constants {
        static let reuseIdentifier = "section-header-reusable"
    }
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure(style: .mainView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(style: SectionStyle? = .mainView) {
        switch style {
        case .mainView:
            addSubview(label)
            label.font = UIFont.preferredFont(forTextStyle: .title1)
            label.textColor = .label
            label.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        case .trainingView: ()
        case .customerView: ()
        case .remainingView: ()
        case .none:
            break
        }
    }
}
