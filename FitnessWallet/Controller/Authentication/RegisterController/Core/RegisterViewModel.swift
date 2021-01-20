//
//  RegisterViewModel.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 07/01/2021.
//

import Foundation

protocol RegisterViewModelProtocol: class {
    var delegate: RegisterViewModelDelegate! { get set }
    
    var registerButtonTitle: String { get }
    var emailRenderable: InputView.Renderable { get }
    var usernameRenderable: InputView.Renderable { get }
    var passwordRenderable: InputView.Renderable { get }
    
    func isInputEmpty(type: InputView.InputType, isEmpty: Bool)
    func register(email: String?, username: String?, password: String?)
    func showMainView()
    func showLoginView()
}

protocol RegisterViewModelDelegate: class {
    func updateForm()
    func showLoading(_ state: Bool)
    func showAlertMessage(_ title: String, message: String)
}

final class RegisterViewModel {
    weak var delegate: RegisterViewModelDelegate!
    
    private var coordinator: LoginCoordinatorProtocol
    
    init(coordinator: LoginCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    let emailRenderable = InputView.Renderable(type: .email, title: Localized.RegisterView.TextTitle.emailTitle, placeholder: Localized.RegisterView.Placeholder.emailPlaceholder, isSecure: false, hint: nil)
    let usernameRenderable = InputView.Renderable(type: .fullname, title: Localized.RegisterView.TextTitle.usernameTitle, placeholder: Localized.RegisterView.TextTitle.usernameTitle, isSecure: false, hint: nil)
    let passwordRenderable = InputView.Renderable(type: .password, title: Localized.RegisterView.TextTitle.passwordTitle, placeholder: Localized.RegisterView.Placeholder.passwordPlaceholder, isSecure: true, hint: Localized.RegisterView.TextTitle.hintPasswordTitle)
    
    private let inputsRequired: Set<InputView.InputType> = [.fullname, .email, .password]
    private var inputs: Set<InputView.InputType> = []
}

extension RegisterViewModel: RegisterViewModelProtocol {
    var registerButtonTitle: String { return Localized.RegisterView.Button.registerButton }
    
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
    
    func register(email: String?, username: String?, password: String?) {
        guard let email = email,
              let username = username?.lowercased(),
              let password = password else { return }
        delegate.showLoading(true)
        let credentials = AuthCredentials(email: email, username: username, password: password)
        AuthService.registerUser(withCredentials: credentials) { error in
            self.delegate.showLoading(false)
            if let error = error {
                print("DEBUG: Failed to register user \(error.localizedDescription)")
                return
            }
            self.delegate.showAlertMessage(Localized.Alert.AlertMessage.title, message: Localized.Alert.AlertMessage.registerAlert)
            self.showMainView()
        }
    }
    
    func showMainView() {
        coordinator.showMainController()
    }
    
    func showLoginView() {
        coordinator.showLoginController()
    }

}
