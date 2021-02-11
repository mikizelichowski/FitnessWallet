//
//  UserAPI.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 11/02/2021.
//

import Foundation

struct Welcome: Codable {
    let contacts: [Contact]
}

struct Contact: Codable {
    let name: String
    let email: String
    let id: String
}
