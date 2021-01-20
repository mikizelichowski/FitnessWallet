//
//  CustomLabel.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import UIKit

enum StyleLabel {
    case title
    case subtitle
}

class CustomLabel: UILabel {
    
    init(style: StyleLabel, title: String? = nil) {
        super.init(frame: .zero)
        styles(style, title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateStyle(_ style: StyleLabel, title: String? = nil) {
        switch style {
        case .title:
            text = title
            font = .font(with: .semibold, size: .medium)
            textColor = .white
            textAlignment = .left
            numberOfLines = .zero
        case .subtitle:
            text = title
            textColor = .lightGray
            font = .font(with: .thin, size: .normal)
            textAlignment = .left
            numberOfLines = 0
        }
    }
    
    private func styles(_ style: StyleLabel, title: String? = nil) {
        switch style {
        case .title:
            text = title
            font = .font(with: .semibold, size: .medium)
            textColor = .black
            textAlignment = .left
            numberOfLines = .zero
        case .subtitle:
            text = title
            textColor = .lightGray
            font = .font(with: .thin, size: .normal)
            textAlignment = .left
            numberOfLines = 0
        }
    }
}
