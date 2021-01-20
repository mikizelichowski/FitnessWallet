//
//  InputView.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 06/01/2021.
//

import UIKit

final class InputView: UIView {
    private enum Constants {
        static let setHeightTextField: CGFloat = 46.0
    }
    
    private let contentView = UIView()
    private let containerStackView = UIStackView()
    private let infoLabel = UILabel()
    private let errorLabel = UILabel()
    private let hintStackView = UIStackView()
    private let hintIconImageView = UIImageView()
    private let hintLabel = UILabel()
    private let textField: CustomText = {
        let tf = CustomText()
        tf.setHeight(Constants.setHeightTextField)
        return tf
    }()
    
    var isEmptyClosure: ((InputView.InputType, Bool) -> ())?
    
    var text: String? {
        set {
            textField.update(text: newValue)
        }
        get {
            return textField.text
        }
    }
 
    var errorMessage: String? {
        didSet {
            errorLabel.text = errorMessage
            errorLabel.isHidden = errorMessage == nil
            textField.isError = errorMessage != nil
            infoLabel.textColor = errorMessage == nil ? .lightGray : .redColor
            showHintIfIneeded()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.backgroundColor = .clear
        contentView.setWidth(UIScreen.main.bounds.width - CGFloat(StringRepresentationOfDigit.sixty))
        addSubview(contentView)
        contentView.addSubview(containerStackView)
        containerStackView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor)
        
        [infoLabel, textField].forEach { containerStackView.addArrangedSubview($0)}
        containerStackView.axis = .vertical
        containerStackView.spacing = CGFloat(StringRepresentationOfDigit.five)
        
        [hintIconImageView, hintLabel].forEach { hintStackView.addArrangedSubview($0)}
        hintStackView.axis = .horizontal
        hintStackView.spacing = CGFloat(StringRepresentationOfDigit.five)
        hintIconImageView.setDimensions(height: CGFloat(StringRepresentationOfDigit.sixteen),
                                        width: CGFloat(StringRepresentationOfDigit.sixteen))
        setup()
    }
    
    func update(renderable: Renderable) {
        textField.isUserInteractionEnabled = true
        infoLabel.text = renderable.title
        textField.placeholderText = renderable.placeholder
        textField.isSecureMode = renderable.isSecure
        textField.autocapitalizationType = .words
        hintLabel.text = renderable.hint
        showHintIfIneeded()
        textField.textDidChangeClosure = { [weak self] text in
            self?.isEmptyClosure?(renderable.type, text.isEmpty)
        }
    }
    
    func setupKeyboard(_ type: UIKeyboardType? = .default) {
        textField.setup()
        textField.keyboardType = type ?? .default
        textField.returnKeyType = .done
        textField.isHidden = false
    }
    
//    func showTextField(_ type: UIKeyboardType? = .default) {
//        textField.keyboardType = type ?? .default
//        textField.returnKeyType = .default
//        textField.becomeFirstResponder()
//        textField.isHidden = false
//    }
    
    
    private func setup() {
        infoLabel.textColor = .blueDark
        infoLabel.font = .font(with: .bold, size: .smallMedium)
        errorLabel.textColor = .redColor
        errorLabel.font = .font(with: .regular, size: .small)
        errorMessage = nil
        hintLabel.font = .font(with: .regular, size: .small)
       // hintIconImageView.image = Asset.infoImage.image
       // hintIconImageView.tintColor = .greyBlueLight
        textField.borderColorHasChangeClosure = changeInfoLabel
    }
    
    private func showHintIfIneeded() {
        hintStackView.isHidden = errorMessage != nil || hintLabel.text == nil
    }
    
    private func changeInfoLabel(color: UIColor) {
        infoLabel.textColor = color
        errorLabel.text = nil
    }
}

extension InputView {
    enum InputType {
        case fullname
        case email
        case password
        case username
        case surname
        case package
        case weight
        case height
    }
    
    struct Renderable {
        let type: InputType
        let title: String
        let placeholder: String
        let isSecure: Bool
        let hint: String?
    }
}
