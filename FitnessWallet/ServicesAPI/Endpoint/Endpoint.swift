//
//  Endpoint.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/01/2021.
//

import Firebase

typealias FirestoreCompletion = (Error?) -> Void

enum Endpoint {
    enum Collection {
        static let user = "user"
        static let customersList = "customers-list"
    }
    
    enum User {
        static let email = "email"
        static let username = "username"
        static let uid = "uid"
    }
    
    enum Customer {
        static let username = "username"
        static let surname = "surname"
        static let weight = "weight"
        static let height = "height"
        static let profileImage = "profileImage"
        static let ownerTrainerUid = "ownerTrainerUid"
        static let timestamp = "timestamp"
    }
}

let COLLECTION_CUSTOMERS = Firestore.firestore().collection("customers")
let COLLECTION_USER = Firestore.firestore().collection(Endpoint.Collection.user)
