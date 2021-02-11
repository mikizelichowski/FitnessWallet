//
//  InputTextView.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 11/01/2021.
//

import UIKit

enum PlaceholderStyle {
    case createUser
}

class InputTextView: UITextView {
    let placeholderLabel = UILabel()
    
    var placeholderText: String? {
        didSet { placeholderLabel.text = placeholderText }
    }
    
    var placeholderShoulderCenter: Bool = true {
        didSet {
            if placeholderShoulderCenter {
                placeholderLabel.anchor(left: leftAnchor,
                                        right: rightAnchor,
                                        paddingLeft: CGFloat(StringRepresentationOfDigit.eight))
                placeholderLabel.centerY(inView: self)
            } else {
                placeholderLabel.anchor(top: topAnchor,
                                        left: leftAnchor,
                                        paddingTop: CGFloat(StringRepresentationOfDigit.six),
                                        paddingLeft: CGFloat(StringRepresentationOfDigit.eight))
            }
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        keyboardHide()
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 8
        placeholderLabel.textColor = .lightGray
        backgroundColor = .white
        addSubview(placeholderLabel)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidEnd), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    @objc
    func textFieldDidEnd() {
        //        endEditing(true)
        //        resignFirstResponder()
    }
    
    @objc
    func handleTextDidChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
    
    func setupText(_ style: PlaceholderStyle) {
        switch style {
        case .createUser:
            font = .font(with: .regular, size: .small)
            isScrollEnabled = false
            textColor = .black
        }
    }
    
    func keyboardHide() {
        alwaysBounceVertical = true
        keyboardDismissMode = .interactive
    }
    
    func update(renderable: Renderable) {
        placeholderLabel.text = renderable.placeholder
        placeholderText = renderable.placeholder
    }
}

extension InputTextView {
    enum InputType {
        case username
        case surname
        case package
    }
    
    struct Renderable {
        let type: InputType
        let placeholder: String
        let package: Int?
    }
}
