//
//  ErrorAPI.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 21/01/2021.
//

import Foundation

enum ErrorAPI: String, CaseIterable {
    case fetchData = "Failed fetch data from firestore"
    case logIn = "Failed to log user in"
    case register = "Failed to register user"
    case uploadData = "Failed to create a new customer"
    case uploadImage = "Failed to upload image"
}
