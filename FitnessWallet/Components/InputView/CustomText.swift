//
//  CustomText.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 06/01/2021.
//

import UIKit

final class CustomText: UITextField {
    private enum Constants {
        static let cornerRadius: CGFloat = 4.0
        static let borderWidth: CGFloat = 1.0
        static let margin: CGFloat = 12.0
        static let marginWithPassword: CGFloat = 30.0
    }
    
    var textDidChangeClosure: ((String) -> ())?
    var borderColorHasChangeClosure: ((UIColor) -> ())?
    
    private var showPasswordButton = UIButton(type: .custom)
    
    var isError: Bool = false {
        didSet {
            layer.borderColor = isError ? UIColor.redColor.cgColor :  UIColor.ablueColor.cgColor
            backgroundColor = isError ? .redExtra : .white
        }
    }
    
    var placeholderText: String = .empty {
        didSet {
            attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [.foregroundColor: UIColor.greyBlueLight, .font: UIFont.font(with: .regular, size: .normal)])
        }
    }
    
    var isSecureMode: Bool = false {
        didSet {
            isSecureTextEntry = isSecureMode
            rightViewMode = isSecureMode ? .always : .never
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let right = isSecureMode ? Constants.marginWithPassword : Constants.margin
        return bounds.inset(by: UIEdgeInsets(top: .zero, left: Constants.margin, bottom: .zero, right: right))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let right = isSecureMode ?  Constants.marginWithPassword : Constants.margin
        return bounds.inset(by: UIEdgeInsets(top: .zero, left: Constants.margin, bottom: .zero, right: right))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let right = isSecureMode ? Constants.marginWithPassword : Constants.margin
        return bounds.inset(by: UIEdgeInsets(top: .zero, left: Constants.margin, bottom: .zero, right: right))
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.rightViewRect(forBounds: bounds).offsetBy(dx: -Constants.margin, dy: .zero)
        return isSecureMode ? rect: super.rightViewRect(forBounds: bounds)
    }
    
    func setup() {
        returnKeyType = .done
        layer.borderWidth = Constants.borderWidth
        layer.cornerRadius = Constants.cornerRadius
        font = UIFont.font(with: .regular, size: .normal)
        textColor = .blueDark
        
        
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        addTarget(self, action: #selector(textFieldDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(textFieldDidEnd), for: .editingDidEnd)
        addTarget(self, action: #selector(textFieldReturnDidTap), for: .editingDidEndOnExit)
        
        setupShowPasswordButton()
        updateColorsIfNeeded()
    }
    
    func setupShowPasswordButton() {
        showPasswordButton.setTitleColor(.black, for: .normal)
        showPasswordButton.setImage(UIImage(systemName: Asset.eye_slash_fill.name), for: .normal)
        showPasswordButton.setImage(UIImage(systemName: Asset.eye_fill.name), for: .selected)
        showPasswordButton.tintColor = .lightGray
        showPasswordButton.addTarget(self, action: #selector(showPasswordButtonDidTap), for: .touchUpInside)
        showPasswordButton.sizeToFit()
        rightView = showPasswordButton
    }
    
    func updateColorsIfNeeded() {
        let color = text?.isEmpty == true ? UIColor.lightGray : .ablueColor
        changeColors(color)
    }
    
    private func updateInfoLabelColorIfNeeded() {
        let infoLabelColor = text?.isEmpty == true ? UIColor.lightGray : .activeInputLabelColor
        borderColorHasChangeClosure?(infoLabelColor)
    }
    
    private func changeColors(_ color: UIColor, background: UIColor = .white) {
        layer.borderColor = color.cgColor
        backgroundColor = background
        updateInfoLabelColorIfNeeded()
    }
    
    func update(text: String?) {
        self.text = text
        updateColorsIfNeeded()
    }
}

extension CustomText {
    @objc
    private func showPasswordButtonDidTap() {
        showPasswordButton.isSelected.toggle()
        isSecureTextEntry = !showPasswordButton.isSelected
    }
    
    @objc
    private func textFieldDidChange() {
        changeColors(.black)
        borderColorHasChangeClosure?(.activeInputLabelColor)
    }
    
    @objc
    private func textFieldDidBegin() {
        updateColorsIfNeeded()
    }
    
    @objc
    private func textFieldDidEnd() {
        resignFirstResponder()
    }
    
    @objc
    private func textFieldReturnDidTap(_ textField: UITextField) {
        textDidChangeClosure?(textField.text ?? .empty)
    }
}
