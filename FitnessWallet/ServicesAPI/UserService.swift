//
//  UserService.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 07/01/2021.
////
//
//import Combine
//import FirebaseAuth
//
//protocol UserServiceProtocol {
//    var currentUser: User? { get }
//    func currentUserPublisher() -> AnyPublisher<User?, Never>
//    func signIn() -> AnyPublisher<User, Error>
//    func linkAccount(email: String, password: String) -> AnyPublisher<Void, Error>
//}
//
//class UserService: ObservableObject {
//    @Published var email = ""
//    @Published var password = ""
//    @Published var username = ""
//    @Published var isSignUp = false
//}
