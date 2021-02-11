//
//  CardView.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 11/02/2021.
//

import UIKit

enum CardModelReusable {
    case active
    case delete
}

struct CardModel {
    let title: String
    let numberOfTraining: Int
    let cardModel: CardModelReusable
}

final class CardView: UIView {
    private enum Constants {
        static let marginTwelve: CGFloat = 12.0
        static let heightStackView: CGFloat = 50.0
    }
    
    private let cardView = UIView()
    private let stackView = UIStackView()
    private let titleLabel = CustomLabel(style: .largeTitle)
    private let numberOfTraining = CustomLabel(style: .subtitle)
    private let numberCard = CustomLabel(style: .largeTitle)
    private let packageName = UILabel()
    private let trainingNumber = UILabel()
    private let expireStackView = UIStackView()
    private let expireDateText = UILabel()
    private let expireDateMonth = UILabel()
    private let cardStackView = UIStackView()
    private let cardHolderTitle = UILabel()
    private let cardHolderName = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(cardView)
        cardView.anchor(top: topAnchor,
                        left: leftAnchor,
                        bottom: bottomAnchor,
                        right: rightAnchor,
                        paddingTop: CGFloat(StringRepresentationOfDigit.eight),
                        paddingLeft: CGFloat(StringRepresentationOfDigit.sixteen),
                        paddingBottom: CGFloat(StringRepresentationOfDigit.eight),
                        paddingRight: CGFloat(StringRepresentationOfDigit.sixteen))
        cardView.layer.addShadow(type: .iconButton)
        cardView.backgroundColor = .whiteAlphaTf
        [titleLabel, numberOfTraining, expireStackView, cardStackView].forEach { cardView.addSubview($0)}
        titleLabel.anchor(top: cardView.topAnchor,
                          left: cardView.leftAnchor,
                          paddingTop: Constants.marginTwelve,
                          paddingLeft: Constants.marginTwelve)
        numberOfTraining.anchor(top: cardView.topAnchor,
                                right: cardView.rightAnchor,
                                paddingTop: Constants.marginTwelve,
                                paddingRight: Constants.marginTwelve)
        [expireDateText, expireDateMonth].forEach { expireStackView.addArrangedSubview($0)}
        [cardHolderTitle, cardHolderName].forEach { cardStackView.addArrangedSubview($0)}
        [expireStackView, cardStackView].forEach {
            $0.axis = .vertical
            $0.alignment = .leading
            $0.setHeight(Constants.heightStackView)
        }
        expireStackView.anchor(left: cardView.leftAnchor,
                               bottom: cardView.bottomAnchor,
                               paddingLeft: Constants.marginTwelve,
                               paddingBottom: Constants.marginTwelve)
        cardStackView.anchor(bottom: cardView.bottomAnchor,
                             right: cardView.rightAnchor,
                             paddingBottom: Constants.marginTwelve,
                             paddingRight: Constants.marginTwelve)
        addSubview(numberCard)
        numberCard.centerX(inView: cardView)
        numberCard.centerY(inView: cardView, leftAnchor: cardView.leftAnchor, paddingLeft: Constants.marginTwelve)
        setupLabel()
    }
    
    private func setupLabel() {
        numberOfTraining.numberOfLines = .zero
        expireDateText.text = "Expires"
        expireDateMonth.text = "12/23"
        cardHolderTitle.text = "Card Holder"
        cardHolderName.text = "Mike Sullivan"
        [expireDateText, cardHolderTitle].forEach {
            $0.font = .font(with: .medium, size: .normal)
            $0.textColor = .lightGray
        }
        [expireDateMonth, cardHolderName].forEach{
            $0.font = .font(with: .light, size: .medium)
            $0.textColor = .black
        }
        #warning("delete later!")
        numberOfTraining.text = "12"
        titleLabel.text = "Card Package"
        numberCard.text = "XXXX  XXXX  XXXX  XXXX"
    }
    
    func update(with cardModel: CardModel) {
        numberOfTraining.text = String(cardModel.numberOfTraining)
        titleLabel.text = cardModel.title
        numberCard.text = "XXXX  XXXX  XXXX  XX \(cardModel.numberOfTraining)"
    }
}
