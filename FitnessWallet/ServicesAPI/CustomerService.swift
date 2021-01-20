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
        ImageUploader.uploadImage(image: profileImage) { imageUrl in
            let data = [
                Endpoint.Customer.username: username,
                Endpoint.Customer.surname: surname,
                Endpoint.Customer.weight: weight,
                Endpoint.Customer.height: height,
                Endpoint.Customer.profileImage: imageUrl,
                Endpoint.Customer.ownerTrainerUid: uid,
                Endpoint.Customer.timestamp: Timestamp(date: Date())
            ] as [String: Any]
            COLLECTION_USER.document(uid).collection(Endpoint.Collection.customersList).addDocument(data: data, completion: completion)
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
    
    
    
    
    // MARK: -----------------------------------------------------
    static func getUserID(_ completion: @escaping(Int) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(42)
        }
    }
    
    static func getUserFirstName(userID: Int, completion: @escaping(String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion("Miki")
        }
    }
    
    static func getUserLastName(userId: Int, completion: @escaping(String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion("Sullivan")
        }
    }
    
    static func getUser() {
        getUserID { userId in
            getUserFirstName(userID: userId) { firstName in
                getUserLastName(userId: userId) { lastName in
                    print("DEBUG: Hello \(firstName) \(lastName)")
                }
            }
        }
    }
}
