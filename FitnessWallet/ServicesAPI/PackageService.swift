//
//  PackageService.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 26/01/2021.
//

import Foundation
import Firebase
import FirebaseFirestore

struct PackageCredentials {
    let titlePackage: String
    let trainerName: String
    let numberOfPackage: Double
    let packageId: String
    let sellerTrainerId: String
    let dataSell: Timestamp
}

struct PackageService {
    var customers: Customers?
    
    static func createPackage(titlePackage: String, numberOfPackage: Double, completion: @escaping(Result<String, Error>) -> ()) {
        guard let uid = Auth.auth().currentUser else { return }
        let packageID = COLLECTION_PACKAGE.document(uid.uid).collection(Endpoint.Collection.PackageCollection.newPackage).document()
        COLLECTION_PACKAGE.document(uid.uid).collection(Endpoint.Collection.PackageCollection.newPackage).document(packageID.documentID).setData(
            [
                Endpoint.Package.titlePackage: titlePackage,
                Endpoint.Package.numberOfPackage: numberOfPackage,
                Endpoint.Package.packageId: packageID.documentID,
                Endpoint.Package.sellerTrainerId: uid.uid,
                Endpoint.Package.dataSell: Timestamp(date: Date())
            ] as [String : Any]
        ) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(packageID.documentID))
            }
        }
    }
    
    static func fetchPackage(completion: @escaping(Result<[PackageModel], Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return}
        let path = COLLECTION_PACKAGE.document(uid).collection(Endpoint.Collection.PackageCollection.newPackage)
        path.getDocuments { snapshot, error in
            if let error = error {
                print("DEBUG: Failed fetch package card data \(error.localizedDescription)")
                return
            }
            guard let documents = snapshot?.documents else { return }
            let packageCard = documents.map { PackageModel(dictionary: $0.data())}
            completion(.success(packageCard))
        }
    }
    
    static func fetchNumberListPackage(customerId: String, completion: @escaping(Result<PackageModel, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_PACKAGE.document(uid).collection(Endpoint.Collection.PackageCollection.customerPackage)
            .document(customerId).collection(Endpoint.Collection.PackageCollection.selectedPackage)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                documents.forEach { document in
                    let package = PackageModel(dictionary: document.data())
                    completion(.success(package))
                }
            }
    }
    
    static func fetchCurrentListPackage(customerId: String, completion: @escaping(Result<PackageModel, Error>) -> Void) {
        var packageID: PackageModel?
        fetchNumberListPackage(customerId: customerId) { result in
            switch result {
            case .success(let package):
                packageID = package
            case .failure(let error):
                print("DEBUG: Failed fetch package data \(error.localizedDescription)")
            }
        }
        completion(.success(packageID!))
    }
    
    static func addSelectedPackage(packageId: String, customerId: String, completion: @escaping(Result<Bool, Error>) -> ()) {
        guard let uid = Auth.auth().currentUser else { return }
        COLLECTION_PACKAGE.document(uid.uid).collection(Endpoint.Collection.PackageCollection.customerPackage)
            .document(customerId).collection(Endpoint.Collection.PackageCollection.selectedPackage)
            .document(packageId).setData(
                [Endpoint.Package.packageId: packageId
                ] as [String: Any]
            ) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(true))
                }
            }
    }
}
