//
//  LoginViewModel.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 16/12/2020.
//

import UIKit

enum AccountState {
    case existingUser
    case newUser
}

protocol LoginViewModelProtocol: class {
    var delegate: LoginViewModelDelegate! { get set }
    
    var loginButtonTitle: String { get }
    var loginRenderable: InputView.Renderable { get }
    var passwordRenderable: InputView.Renderable { get }
    
    func isInputEmpty(type: InputView.InputType, isEmpty: Bool)
    func login(email: String?, password: String?)
    func showRegisterView()
    func showResetPasswordView()
}

protocol LoginViewModelDelegate: class {
    func updateForm()
    func showLoading(_ state: Bool)
}

final class LoginViewModel {
    weak var delegate: LoginViewModelDelegate!
    
    private var coordinator: LoginCoordinatorProtocol
    private var accountState: AccountState = .existingUser
    
    let loginRenderable = InputView.Renderable(type: .email,
                                               title: Localized.LoginView.TextTitle.emailTitle,
                                               placeholder: Localized.LoginView.Placeholder.emailPlaceholder,
                                               isSecure: false,
                                               hint: nil)
    let passwordRenderable = InputView.Renderable(type: .password,
                                                  title: Localized.LoginView.TextTitle.passwordTitle,
                                                  placeholder: Localized.LoginView.Placeholder.passwordPlaceholder,
                                                  isSecure: true,
                                                  hint: Localized.LoginView.TextTitle.hintPasswordTitle)
    
    private let inputsRequired: Set<InputView.InputType> = [.email, .password]
    private var inputs: Set<InputView.InputType> = []
    
    init(coordinator: LoginCoordinator) {
        self.coordinator = coordinator
    }
}

extension LoginViewModel: LoginViewModelProtocol {
    var loginButtonTitle: String { return Localized.LoginView.Button.loginButtonTitle }
    
    func isInputEmpty(type: InputView.InputType, isEmpty: Bool) {
        if isEmpty {
            inputs.remove(type)
        } else {
            inputs.insert(type)
        }
        if inputs == inputsRequired {
            delegate.updateForm()
        }
    }
    
    func login(email: String?, password: String?) {
        if accountState == .existingUser {
            delegate.updateForm()
            guard let email = email,
                  let password = password else { return }
            delegate.showLoading(true)
            AuthService.loginUser(withEmail: email, password: password) { result, error in
                self.delegate.showLoading(false)
                if let error = error {
                    print("\(ErrorAPI.logIn) \(error.localizedDescription)")
                    
                    return
                }
                // self.authentication.authenticationDidComplete()
                DispatchQueue.main.async {
                    self.coordinator.showMainController()
                }
            }
        }
    }
    
    func showRegisterView() {
        coordinator.showRegisterController()
    }
    
    func showResetPasswordView() {
        coordinator.showResetPasswordController()
    }
}
