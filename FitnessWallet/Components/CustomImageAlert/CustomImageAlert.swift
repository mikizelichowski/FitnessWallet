////
////  CustomImageAlert.swift
////  FitnessWallet
////
////  Created by Mikolaj Zelichowski on 10/01/2021.
////
//
//import UIKit
//
//enum StylesAlertImage {
//    case alert
//}
//
//struct StyleAlertModel {
//    let styleAlert: StylesAlertImage
//}
//
//protocol ImageStyleAlertProtocol: class {
//    var imageStyleAlert: StylesAlertImage { get }
//}
//
//class CustomImageAlert: UIImageView {
//    private let style: StyleAlertModel
//    
//    init(style: StyleAlertModel) {
//        self.style = style
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}
//
//extension CustomImageAlert: ImageStyleAlertProtocol {
//    var imageStyleAlert: StylesAlertImage { style.styleAlert }
//}
