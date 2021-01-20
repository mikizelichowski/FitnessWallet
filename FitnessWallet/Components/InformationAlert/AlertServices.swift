////
////  AlertServices.swift
////  FitnessWallet
////
////  Created by Mikolaj Zelichowski on 10/01/2021.
////
//
//import UIKit
//
//final class AlertServices {
//
//    @discardableResult
//    func build(_ alertMessage: String, type: Alert.Subtype, handler: (()-> ())?, _ controller: UIViewController) -> UIViewController {
//        switch type {
//        case .common:
//            return
//        case .delayed(delay: let delay):
//            <#code#>
//        case .information(model: let model):
//            <#code#>
//        case .informationDelayed(model: let model, delay: let delay):
//            <#code#>
//        case .datePicker:
//            <#code#>
//        }
//    }
//}
//
//enum Alert {
//    static let services = AlertServices()
//
//    case modal(alertMessage: String, type: Subtype, hanadler: (() -> ())? = nil, controller: UIViewController)
//    case information(type: Subtype, controller: UIViewController, confirmHandler: (()->())? = nil, touchHandler: (() -> ())?)
//
//    func present() {
//        switch self {
//        case let .modal(alertMessage, type, hanadler, controller):
//            Alert.services.build(<#T##alertMessage: String##String#>)
//        case let .information(type, controller, confirmHandler, touchHandler):
//            Alert.services
//        }
//    }
//
//    enum Subtype {
//        case common
//        case delayed(delay: Int)
//        case information(model: InformationAlertModel)
//        case informationDelayed(model: InformationAlertModel, delay: Int)
//        case datePicker
//    }
//}
