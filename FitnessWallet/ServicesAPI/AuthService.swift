//
//  AuthService.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 07/01/2021.
//

import UIKit
import Firebase
import FirebaseFirestore

struct AuthCredentials {
    let email: String
    let username: String
    let password: String
    let profileImageUrl: UIImage? = nil
}

var userID: String?

struct AuthService {
    static func registerUser(withCredentials credentials: AuthCredentials, completion: @escaping(Error?) -> Void) {
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
            if let error = error {
                print("DEBUG: Failed to register user \(error.localizedDescription)")
                return
            }
            guard let uid = result?.user.uid else { return }
            let data: [String: Any] = [ Endpoint.User.email: credentials.email,
                                        Endpoint.User.username: credentials.username,
                                        Endpoint.User.uid: uid ]
            Firestore.firestore().collection(Endpoint.Collection.user)
                .document(uid)
                .setData(data, completion: completion)
            userID = Auth.auth().currentUser?.uid
        }
    }
    
    static func loginUser(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            guard (Auth.auth().currentUser?.uid) != nil else { return}
            completion?(result, err)
        }
    }
    
    static func logout() {
        do {
            try Auth.auth().signOut()
            userID = nil
        } catch {
            print("DEBUG: Error signing out.. \(error.localizedDescription)")
        }
    }
    
    static func resetPassword(withEmail email: String, completion: SendPasswordResetCallback?) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: completion)
    }
}
