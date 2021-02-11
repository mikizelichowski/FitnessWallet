//
//  LoginViewController.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 16/12/2020.
//

import UIKit

final class LoginViewController: UIViewController {
    private enum Constants {
        static let marginLeftRight: CGFloat = 32.0
        static let marginTop: CGFloat = 50.0
        static let heigthInput: CGFloat = 50.0
        static let widthInput: CGFloat = 300.0
    }
    
    private let loginInput = InputView()
    private let passwordInput = InputView()
    private let containerStackView = UIStackView()
    private let resetPasswordButton = UIButton()
    private let dontHaveAccountButton = UIButton()
    private var loginButton: RoundedButton = {
        let button = RoundedButton()
        button.addTarget(self, action: #selector(handleLoginDidTap), for: .touchUpInside)
        return button
    }()
    
    private var viewModelAuthentication = LoginAuthenticationViewModel()
    var viewModel: LoginViewModelProtocol
    
    init(with viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        configureUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .default }
    
    private func configureUI() {
        
        setupLabels()
        setupButtons()
        [loginInput, passwordInput].forEach { containerStackView.addArrangedSubview($0)
            $0.setDimensions(height: Constants.heigthInput, width: Constants.widthInput)
        }
        containerStackView.axis = .vertical
        containerStackView.spacing = CGFloat(StringRepresentationOfDigit.thirty)
        containerStackView.distribution = .fillEqually
        view.addSubview(containerStackView)
        containerStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                  left: view.safeAreaLayoutGuide.leftAnchor,
                                  right: view.safeAreaLayoutGuide.rightAnchor,
                                  paddingTop: Constants.marginTop,
                                  paddingLeft: Constants.marginLeftRight,
                                  paddingRight: Constants.marginLeftRight)
        let stack = UIStackView(arrangedSubviews: [loginButton, resetPasswordButton])
        stack.axis = .vertical
        stack.spacing = CGFloat(StringRepresentationOfDigit.five)
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.setHeight(CGFloat(StringRepresentationOfDigit.hundred))
        stack.anchor(top: containerStackView.bottomAnchor,
                     left: view.safeAreaLayoutGuide.leftAnchor,
                     right: view.safeAreaLayoutGuide.rightAnchor,
                     paddingTop: Constants.marginTop,
                     paddingLeft: Constants.marginLeftRight,
                     paddingRight: Constants.marginLeftRight)
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    private func setupLabels() {
        
        loginInput.update(renderable: viewModel.loginRenderable)
        loginInput.isEmptyClosure = viewModel.isInputEmpty
        loginInput.setupKeyboard(.emailAddress)
        passwordInput.update(renderable: viewModel.passwordRenderable)
        passwordInput.isEmptyClosure = viewModel.isInputEmpty
    }
    
    private func setupButtons() {
        
        loginButton.setup(title: viewModel.loginButtonTitle, style: .login)
        resetPasswordButton.attributedTitle(firstTitle: Localized.LoginView.TextTitle.forgotPassword,
                                            secondTitle: Localized.LoginView.Button.getPassword)
        resetPasswordButton.addTarget(self, action: #selector(handleTappedPasswordButton), for: .touchUpInside)
        dontHaveAccountButton.attributedTitle(firstTitle: Localized.LoginView.TextTitle.dontHaveAccount,
                                              secondTitle: Localized.LoginView.Button.signIn)
        dontHaveAccountButton.addTarget(self, action: #selector(handleShowRegisterView), for: .touchUpInside)
    }
    
    @objc
    private func textDidChange(sender: UITextField) {
        if sender == loginInput {
            viewModelAuthentication.email = sender.text
        } else if sender == passwordInput {
            viewModelAuthentication.password = sender.text
        }
        updateForm()
    }
    
    @objc
    private func handleLoginDidTap() {
        print("DEBUG: login button")
        viewModel.login(email: loginInput.text, password: passwordInput.text)
    }
    
    @objc
    private func handleTappedPasswordButton() {
        viewModel.showResetPasswordView()
    }
    
    @objc
    private func handleShowRegisterView() {
        viewModel.showRegisterView()
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func showLoading(_ state: Bool) {
        showLoader(state)
    }
    #warning("// fix bug later.. and add Error alert")
    func updateForm() {
        if loginInput.text!.isEmpty && passwordInput.text?.isEmpty == false {
            loginButton.isEnabled = viewModelAuthentication.formIsValid == true
        } else {
            loginButton.isEnabled = viewModelAuthentication.formIsValid == false
        }
    }
}
