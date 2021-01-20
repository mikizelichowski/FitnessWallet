//
//  Customer.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 14/01/2021.
//

import Firebase

struct Customers: Hashable, Equatable, Identifiable {
    let identifier = UUID()
    let username: String
    let surname: String
    var weight: Double
    var height: Double
    let imageUrl: String
    let timestamp: Timestamp
    
    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? .empty
        self.surname = dictionary["surname"] as? String ?? .empty
        self.weight = dictionary["weight"] as? Double ?? 0
        self.height = dictionary["height"] as? Double ?? 0
        self.imageUrl = dictionary["profileImage"] as? String ?? .empty
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    
    static func == (left: Customers, right: Customers) -> Bool {
        left.identifier == right.identifier
    }
}
