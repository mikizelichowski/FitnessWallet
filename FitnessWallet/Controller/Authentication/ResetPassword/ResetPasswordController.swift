//
//  ResetPasswordController.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 08/01/2021.
//

import UIKit

final class ResetPasswordView: UIViewController {
    private enum Constants {
        static let magicNumber32: CGFloat = 32.0
        static let magicNumber120: CGFloat = 120.0
    }
    
    private let backgroundView = UIView()
    private let contentView = UIView()
    private var emailTextField = InputView()
    private let resetButton = RoundedButton()
    private let backButton = UIButton(type: .system)
    private let contentStackView = UIStackView()
    
    private var viewModel: ResetPasswordViewModelProtocol
    
    init(with viewModel: ResetPasswordViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createLayout()
        setupButton()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .default }
    
    private func createLayout() {
        [backgroundView, contentView].forEach { view.addSubview($0)}
        view.backgroundColor = .clear
        backgroundView.backgroundColor = .alertBackground
        backgroundView.fillSuperView()
        contentView.anchor(top: backgroundView.topAnchor,
                           left: backgroundView.leftAnchor,
                           bottom: backgroundView.bottomAnchor,
                           right: backgroundView.rightAnchor,
                           paddingTop: 100,
                           paddingLeft: 32,
                           paddingBottom: 100,
                           paddingRight: 32)
        contentView.backgroundColor = .white
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = CGFloat(StringRepresentationOfDigit.twelve)
        contentView.layer.addShadow(type: .loginRegButton)
        
        [backButton, contentStackView].forEach { contentView.addSubview($0)}
        backButton.anchor(top: contentView.topAnchor,
                          left: contentView.leftAnchor,
                          paddingTop: 16,
                          paddingLeft: 16)
        contentStackView.addArrangedSubview(emailTextField)
        contentStackView.addArrangedSubview(resetButton)
        contentStackView.axis = .vertical
        contentStackView.spacing = 5
        contentStackView.anchor(top: contentView.topAnchor,
                                left: contentView.leftAnchor,
                                bottom: contentView.bottomAnchor,
                                right: contentView.rightAnchor,
                                paddingTop: 50,
                                paddingLeft: 5,
                                paddingRight: 5)
        contentStackView.setHeight(250)
    }
    
    private func setupLabels() {
        emailTextField.update(renderable: viewModel.emailRenderable)
        emailTextField.isEmptyClosure = viewModel.isInputEmpty
    }
    
    private func setupButton() {
        backButton.tintColor = .black
        backButton.setTitle("X", for: .normal)
        backButton.titleLabel?.font = .font(with: .heavy, size: .giant)
        backButton.addTarget(self, action: #selector(dismissBackButton), for: .touchUpInside)
        
        resetButton.setup(title: viewModel.resetButtonTitle, style: .acceptBottom)
    }
    
    @objc
    func handleTappedBack() {
        viewModel.emailAddress(email: emailTextField.text)
    }
    
    @objc func dismissBackButton() {
        self.dismiss(animated: true, completion: { return
            self.viewModel.showLoginView()
        })
    }
}

extension ResetPasswordView: ResetPasswordViewModelDelegate {
    func updateForm() {
        
    }
    
}
