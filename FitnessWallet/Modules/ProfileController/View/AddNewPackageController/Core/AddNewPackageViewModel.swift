//
//  AddNewPackageViewModel.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 26/01/2021.
//

import Firebase

enum ActionAddPackage {
    case showLoading(state: Bool)
    case alertMessage(title: String, message: String)
    case updateView(state: Bool)
}

protocol AddNewPackageViewModelProtocol: class {
    var delegate: AddNewPackageViewModelDelegate! { get set }
    
    var buttonTitle: String { get }
    var titlePackageRenderable: InputView.Renderable { get }
    var numberOfTrainingsRenderable: InputView.Renderable { get }
    
    func isInputEmpty(type: InputView.InputType, isEmpty: Bool)
    func didTapConfirm(title: String?, numberOfTrainings: Double?)
}

protocol AddNewPackageViewModelDelegate: class {
    func action(action: ActionAddPackage)
}

final class AddNewPackageViewModel {
    weak var delegate: AddNewPackageViewModelDelegate!
    
    private let coordinator: ProfileCoordinatorProtocol
    
    init(with coordinator: ProfileCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    var titlePackageRenderable = InputView.Renderable(type: .fullname, title: "Package name", placeholder: "Package name", isSecure: false, hint: nil)
    var numberOfTrainingsRenderable = InputView.Renderable(type: .package, title: "Number of trainings", placeholder: "number of trainings", isSecure: false, hint: nil)
    
    private let inputRequired: Set<InputView.InputType> = [.fullname, .package]
    private var inputs: Set<InputView.InputType> = []
}

extension AddNewPackageViewModel: AddNewPackageViewModelProtocol {
    var buttonTitle: String { return "Add a new package"}
    
    func isInputEmpty(type: InputView.InputType, isEmpty: Bool) {
        if isEmpty {
            inputs.remove(type)
        } else {
            inputs.insert(type)
        }
        if inputs == inputRequired {
            // delegate.updateForm
        }
    }
    
    func didTapConfirm(title: String?, numberOfTrainings: Double?) {
        guard let title = title,
              let numberOfTrainings = numberOfTrainings else { return }
        delegate.action(action: .showLoading(state: true))
        PackageService.createPackage(titlePackage: title, numberOfPackage: numberOfTrainings) { result in
            self.delegate.action(action: .showLoading(state: false))
            switch result {
            case .success(_):
                self.delegate.action(action: .alertMessage(title: "Success",
                                                           message: "You have created a new training package"))
                self.delegate.action(action: .updateView(state: true))
            case .failure(let error):
                print("DEBUG: \(ErrorAPI.uploadData)\(error.localizedDescription)")
            }
        }
    }
}
