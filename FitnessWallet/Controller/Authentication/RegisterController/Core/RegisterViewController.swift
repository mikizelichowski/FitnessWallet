//
//  RegisterViewController.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 07/01/2021.
//

import UIKit

final class RegisterViewController: UIViewController {
    private enum Constants {
        static let setHeight: CGFloat = 250.0
        static let topMargin: CGFloat = 50.0
        static let leftRightMargin: CGFloat = 32.0
    }
    
    private let emailInput = InputView()
    private let usernameInput = InputView()
    private let passwordInput = InputView()
    private let registerButton = RoundedButton()
    private let containerStackView = UIStackView()
    private let alreadyHaveAccountButton = UIButton(type: .system)
    
    var viewModel: RegisterViewModelProtocol
    
    init(with viewModel: RegisterViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        configureLayout()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .default }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        view.backgroundColor = .white
        setupLabels()
        setupButtons()
        [usernameInput, emailInput, passwordInput].forEach {containerStackView.addArrangedSubview($0)}
        containerStackView.axis = .vertical
        containerStackView.spacing = CGFloat(StringRepresentationOfDigit.ten)
        containerStackView.distribution = .fillEqually
        view.addSubview(containerStackView)
        containerStackView.setHeight(Constants.setHeight)
        containerStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                  left: view.safeAreaLayoutGuide.leftAnchor,
                                  right: view.safeAreaLayoutGuide.rightAnchor,
                                  paddingTop: Constants.topMargin,
                                  paddingLeft: Constants.leftRightMargin,
                                  paddingRight: Constants.leftRightMargin)
        view.addSubview(registerButton)
        registerButton.anchor(top: containerStackView.bottomAnchor,
                              left: view.safeAreaLayoutGuide.leftAnchor,
                              right: view.safeAreaLayoutGuide.rightAnchor,
                              paddingTop: Constants.topMargin,
                              paddingLeft: Constants.leftRightMargin,
                              paddingRight: Constants.leftRightMargin)
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        alreadyHaveAccountButton.centerX(inView: view)
        
    }
    
    private func setupLabels() {
        usernameInput.update(renderable: viewModel.usernameRenderable)
        usernameInput.isEmptyClosure = viewModel.isInputEmpty
        emailInput.update(renderable: viewModel.emailRenderable)
        emailInput.isEmptyClosure = viewModel.isInputEmpty
        emailInput.setupKeyboard(.emailAddress)
        passwordInput.update(renderable: viewModel.passwordRenderable)
        passwordInput.isEmptyClosure = viewModel.isInputEmpty
    }
    
    private func setupButtons() {
        
        registerButton.setup(title: viewModel.registerButtonTitle, style: .register)
        registerButton.addTarget(self, action: #selector(handleTappedRegisterButton), for: .touchUpInside)
        alreadyHaveAccountButton.attributedTitle(firstTitle: Localized.RegisterView.TextTitle.alreadyHaveAnAccount, secondTitle: Localized.RegisterView.Button.registerButton)
        alreadyHaveAccountButton.addTarget(self, action: #selector(handleShowLoginView), for: .touchUpInside)
    }
    
    @objc
    func handleTappedRegisterButton() {
        print("DEBUG: Register button..")
        viewModel.register(email: emailInput.text, username: usernameInput.text, password: passwordInput.text)
    }
    
    @objc
    func handleShowLoginView() {
        viewModel.showLoginView()
    }
}

extension RegisterViewController: RegisterViewModelDelegate {
    func updateForm() {
    }
    
    func showLoading(_ state: Bool) {
        showLoader(state)
    }
    
    func showAlertMessage(_ title: String, message: String) {
        showMessage(withTitle: title, message: message, completion: nil)
    }
}
