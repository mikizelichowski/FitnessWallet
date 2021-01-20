//
//  InformationAlertControllerViewModel.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 09/01/2021.
//

import Foundation

enum InformationAlertStyle {
    case success
    case failure
    case confirmation
    case Informational
    case simpleText
    case resetPassword
}

struct InformationAlertModel {
    let icon: ImageAsset?
    let title: String
    let description: String
    let confirmButtonTitle: String
    let cancelButtonTitle: String
    let alertStyle: InformationAlertStyle
    var tapGestureRecognizer: Bool? = false
    var replaceImageToIndicator: Bool? = false
    var informationTrainigItems : [NumberLabelDescriptionView]? = []
    var informationLoginAlertItems : [LoginInformationAlert]? = []
}

protocol InformationControllerViewModelProtocol: class {
    var delegate: InformationAlertControllerViewModelDelegate! { get set }
    
    var alertIcon: ImageAsset? { get }
    var alertTitle: String { get }
    var alertDescription: String { get }
    var confirmButtonTitle: String? { get }
    var cancelButtonTitle: String? { get }
    var alertStyle: InformationAlertStyle { get }
    var tapGestureRecognizer: Bool { get }
    var replaceImageToIndicator: Bool { get }
    var informationTrainigItems: [NumberLabelDescriptionView] { get }
    var informationLoginAlertItems : [LoginInformationAlert] { get }
    
    func confirmDidTap()
    func cancelDidTap()
    func touchDidTap()
}

protocol InformationAlertControllerViewModelDelegate: class {
}

final class InformationAlertControllerViewModel {
    weak var delegate: InformationAlertControllerViewModelDelegate!
    
    private let model: InformationAlertModel
    private let confirmHandler: (() -> ())?
    private let cancelHandler: (() -> ())?
    private let touchHandler: (() -> ())?
    
    init(model: InformationAlertModel, confirmHandler: (()->())? = nil, cancelHandler: (() -> ())? = nil,
         touchHandler: (() -> ())? = nil ) {
        self.model = model
        self.confirmHandler = confirmHandler
        self.cancelHandler = cancelHandler
        self.touchHandler = touchHandler
    }
}

extension InformationAlertControllerViewModel: InformationControllerViewModelProtocol {
    var alertIcon: ImageAsset? { model.icon }
    var alertTitle: String { model.title }
    var alertDescription: String { model.description }
    var confirmButtonTitle: String? { model.confirmButtonTitle}
    var cancelButtonTitle: String? { model.cancelButtonTitle}
    var alertStyle: InformationAlertStyle { model.alertStyle }
    var tapGestureRecognizer: Bool { model.tapGestureRecognizer ?? false }
    var replaceImageToIndicator: Bool { model.replaceImageToIndicator ?? false }
    var informationTrainigItems: [NumberLabelDescriptionView] { model.informationTrainigItems ?? [] }
    var informationLoginAlertItems : [LoginInformationAlert] { model.informationLoginAlertItems ?? [] }
    
    func confirmDidTap() {
        confirmHandler?()
    }
    
    func cancelDidTap() {
        cancelHandler?()
    }
    
    func touchDidTap() {
        touchHandler?()
    }
    
    
}
