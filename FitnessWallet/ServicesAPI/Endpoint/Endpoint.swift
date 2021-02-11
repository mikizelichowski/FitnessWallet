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
        enum PackageCollection {
            static let package = "package"
            static let newPackage = "new-package"
            static let customerPackage = "customer-package"
            static let selectedPackage = "selected-package"
        }
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
        static let customerId = "customerId"
    }
    
    enum Package {
        static let titlePackage = "titlePackage"
        static let trainerName = "trainerName"
        static let numberOfPackage = "numberOfPackage"
        static let packageId = "packageId"
        static let sellerTrainerId = "sellerTrainerId"
        static let dataSell = "dataSell"
        static let selectedPackageId = "selectedPackageId"
        static let customerId = "customerId"
    }
}

let COLLECTION_CUSTOMERS = Firestore.firestore().collection("customers")
let COLLECTION_USER = Firestore.firestore().collection(Endpoint.Collection.user)
let COLLECTION_PACKAGE = Firestore.firestore().collection(Endpoint.Collection.PackageCollection.package)
