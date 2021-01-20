//
//  User.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import Foundation
import Firebase

struct User: Hashable {
    private enum Constants {
        static let email = "email"
        static let username = "username"
        static let uid = "uid"
        static let profileImageUrl = "profileImageUrl"
    }
    
    let email: String
    let username: String
    let uid: String
    let profileImageUrl: String
    
    var stats: UserStats!
    
    var isCurrentUser: Bool {
        return Auth.auth().currentUser?.uid == uid
    }
    
    init(dictionary: [String: Any]) {
        self.email = dictionary[Constants.email] as? String ?? .empty
        self.username = dictionary[Constants.username] as? String ?? .empty
        self.profileImageUrl = dictionary[Constants.profileImageUrl] as? String ?? .empty
        self.uid = dictionary[Constants.uid] as? String ?? .empty
    }
}

struct UserStats: Hashable {
    let buy: Bool
    let trainingCount: Int
    let signing: String
}
