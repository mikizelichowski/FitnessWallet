//
//  AddClientViewModel.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 11/01/2021.
//

import UIKit

protocol AddClientViewModelProtocol: class {
    var delegate: AddClientViewModelDelegate! { get set }
    
    var title: String { get }
    var buttonTitle: String { get }
    var usernameRenderable: InputView.Renderable { get }
    var surnameRenderable: InputView.Renderable { get }
    var weightRenderable: InputView.Renderable { get }
    var heightRenderable: InputView.Renderable { get }
    
    func isInputEmpty(type: InputView.InputType, isEmpty: Bool)
    func didTapDone(selectedImage: UIImage?, username: String?, surname: String?, weight: Double?, height: Double?)
    func checkMaxLegnth(_ textView: UITextView)
}

protocol AddClientViewModelDelegate: class {
    func showLoading(_ state: Bool)
    func alertMessage(title: String, message: String)
}

final class AddClientViewModel {
    weak var delegate: AddClientViewModelDelegate!
    
    var usernameRenderable = InputView.Renderable(type: .username, title: Localized.AddClientView.Title.username, placeholder: Localized.AddClientView.Placeholder.username, isSecure: false, hint: nil)
    var surnameRenderable = InputView.Renderable(type: .surname, title: Localized.AddClientView.Title.surname, placeholder: Localized.AddClientView.Placeholder.surname, isSecure: false, hint: nil)
    var weightRenderable = InputView.Renderable(type: .weight, title: Localized.AddClientView.Title.weight, placeholder: Localized.AddClientView.Placeholder.weight, isSecure: false, hint: nil)
    var heightRenderable = InputView.Renderable(type: .height, title: Localized.AddClientView.Title.height, placeholder: Localized.AddClientView.Placeholder.height, isSecure: false, hint: nil)
    
    private let inputsRequired: Set<InputView.InputType> = [.username, .surname, .weight, .height]
    private var inputs: Set<InputView.InputType> = []
    
    //    private let coordinator: ProfileCoordinatorProtocol
    //
    //    init(with coordinator: ProfileCoordinatorProtocol) {
    //    self.coordinator = coordinator
    //    }
}

extension AddClientViewModel: AddClientViewModelProtocol {
    var title: String { return "Add new customer" }
    var buttonTitle: String { return Localized.AddClientView.Button.titleNewCustomer}
    
    func isInputEmpty(type: InputView.InputType, isEmpty: Bool) {
        if isEmpty {
            inputs.remove(type)
        } else {
            inputs.insert(type)
        }
        if inputs == inputsRequired {
            // delegate.updateForm()
        }
    }
    
    func didTapDone(selectedImage: UIImage?, username: String?, surname: String?, weight: Double?, height: Double?) {
        guard let selectedImage = selectedImage,
              let username = username,
              let surname = surname,
              let weight = weight,
              let height = height else { return }
        delegate.showLoading(true)
        CustomerService.createNewCustomer(profileImage: selectedImage,
                                          username: username,
                                          surname: surname,
                                          weight: weight,
                                          height: height) { error in
            self.delegate.showLoading(false)
            if let err = error {
                print("DEBUG: Failed to create a new Customer with error \(err.localizedDescription)")
                return
            }
            self.delegate.alertMessage(title: Localized.Alert.AlertMessage.title,
                                       message: Localized.Alert.AlertMessage.addNewCustomer)
            // usuwnie z textFieldow oraz zdjecie lub przechodzenie do kolejnego widoku
        }
        
    }
    // String(height)
    func checkMaxLegnth(_ textView: UITextView) {
        if (textView.text.count) > StringRepresentationOfDigit.twenty {
            textView.deleteBackward()
        }
    }
}
