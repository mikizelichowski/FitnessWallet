//
//  CustomerService.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 13/01/2021.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

struct CustomerService {
    var curentKey: String?
    
    static func createNewCustomer(profileImage: UIImage, username: String, surname: String, weight: Double, height: Double, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let collectionID = COLLECTION_USER.document(uid).collection(Endpoint.Collection.customersList).document()
        ImageUploader.uploadImage(image: profileImage) { imageUrl in
            let data = [
                Endpoint.Customer.username: username,
                Endpoint.Customer.surname: surname,
                Endpoint.Customer.weight: weight,
                Endpoint.Customer.height: height,
                Endpoint.Customer.profileImage: imageUrl,
                Endpoint.Customer.ownerTrainerUid: uid,
                Endpoint.Customer.timestamp: Timestamp(date: Date()),
                Endpoint.Customer.customerId : collectionID.documentID
            ] as [String: Any]
            COLLECTION_USER.document(uid).collection(Endpoint.Collection.customersList).document(collectionID.documentID).setData(data, completion: completion)
        }
    }
    
    static func fetchCustomers(completion: @escaping((Result<([Customers]),Error>) -> Void)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let path = COLLECTION_USER.document(uid).collection(Endpoint.Collection.customersList)
        path.getDocuments { snapshot, error in
            if let error = error {
                print("DEBUG: Failed fetch customers list from firestore \(error.localizedDescription)")
                return
            }
            guard let documents = snapshot?.documents else { return }
            let customers = documents.map { Customers(dictionary: $0.data())}
            completion(.success(customers))
        }
    }
    
    #warning("Test")
    static func createItem(itemName: String, category: Category, displayName: String, completion: @escaping(Result<String, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        let documentRef = Firestore.firestore().collection("items").document()
        Firestore.firestore().collection("items").document(documentRef.documentID).setData([
            "itemName": itemName,
            "itemId": documentRef.documentID,
            "listedDate": Timestamp(date: Date()),
            "sellerName": displayName,
            "sellerId": user.uid,
            "categoryName": category.rawValue
        ]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(documentRef.documentID))
            }
        }
    }
    
    static func createDatabaseUser(authDataResult: AuthDataResult, completion: @escaping(Result<Bool, Error>) -> ()) {
        guard let email = authDataResult.user.email else { return }
        Firestore.firestore().collection("users").document(authDataResult.user.uid).setData(
            [
                "email": email,
                "createdDate": Timestamp(date: Date()),
                "userId": authDataResult.user.uid
            ]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    // update data in users data
    static func updateDatabaseUser(displayName: String, photoURL: String, completion: @escaping(Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        Firestore.firestore().collection("users").document(user.uid).updateData(
            [
                "photoURL" : photoURL,
                "displayName" : displayName
            ]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    static func delete(item: Customers, completion: @escaping(Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        COLLECTION_USER.document(user.uid).collection(Endpoint.Collection.customersList).document(item.customerId).delete {
            error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
        
    }
}
