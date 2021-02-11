//
//  ResetPasswordViewModel.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 08/01/2021.
//

import Foundation

protocol ResetPasswordViewModelProtocol: class {
    var delegate: ResetPasswordViewModelDelegate! { get set }
    
    var emailRenderable: InputView.Renderable { get }
    var resetButtonTitle: String { get }
    
    func onViewDidLoad()
    func emailAddress(email: String?)
    func isInputEmpty(type: InputView.InputType, isEmpty: Bool)
    func showLoginView()
}

protocol ResetPasswordViewModelDelegate: class {
    func updateForm()
}

final class ResetPasswordViewModel {
    weak var delegate: ResetPasswordViewModelDelegate!
    weak var delegateProtocol: ResetPasswordViewModelProtocol!
    
    private var coordinator: LoginCoordinatorProtocol
    
    init(with coordinator: LoginCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    let emailRenderable = InputView.Renderable(type: .email, title: "Email", placeholder: "Email", isSecure: false, hint: nil)
    private let inputsRequired: Set<InputView.InputType> = [.email]
    private var inputs: Set<InputView.InputType> = []
}

extension ResetPasswordViewModel: ResetPasswordViewModelProtocol {
    var resetButtonTitle: String { return Localized.ResetView.Button.title }
    
    func onViewDidLoad() {
        
    }
    
    func emailAddress(email: String?) {
        delegate.updateForm()
        guard let email = email else { return }
        AuthService.resetPassword(withEmail: email) { error in
            if let error = error {
                print("DEBUG: Failed to reset password \(error.localizedDescription)")
                // showLoader
                // show message error
                return
            }
            print("DBEUG: check your email address")
            self.showLoginView()
//             alert : check your email
        }
    }
    
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
    
    func showLoginView() {
        coordinator.popToLoginViewController()
    }
}
