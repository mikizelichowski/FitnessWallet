//
//  AuthenticationViewModel.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 07/01/2021.
//

import UIKit

protocol AuthenticationViewModelProtocol {
    var formIsValid: Bool { get }
    //var buttonBackgroundColor: UIColor { get }
    var buttonTitleColor: UIColor { get }
    var buttonBorderColor: UIColor { get }
}

struct LoginAuthenticationViewModel: AuthenticationViewModelProtocol {
    
    var email: String?
    var password: String?
    var changeButtonClosure: ((Bool) -> ())?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
            && password?.isEmpty == false
    }
    #warning("check -  delete ")
    //    var buttonBorderColor: UIColor {
    //        let loginButton = formIsValid ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    //        borderColorHasChangeClosure?(loginButton)
    //        return loginButton
    //    }
    var buttonBorderColor: UIColor { return formIsValid ?  #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) }
    var buttonTitleColor: UIColor { return formIsValid ? .black : .lightGray }
}

struct RegisterAuthenticationViewModel: AuthenticationViewModelProtocol {
    var buttonBorderColor: UIColor
    var email: String?
    var password: String?
    var username: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
            && password?.isEmpty == false
            && username?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor { return formIsValid ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.5) }
    var buttonTitleColor: UIColor { return formIsValid ? .black : .lightGray }
}

struct ResetPasswordAuthenticationViewModel: AuthenticationViewModelProtocol {
    var buttonBorderColor: UIColor
    var email: String?
    var formIsValid: Bool { return email?.isEmpty == false }
    var buttonBackgroundColor: UIColor { return formIsValid ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.5) }
    var buttonTitleColor: UIColor { return formIsValid ? .black : .lightGray }
}
