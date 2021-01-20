//
//  Items.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 19/01/2021.
//

import Foundation

// UICollectionViewDiffableDataSource<Category, Item>
struct Items: Hashable {
    let name: String
    let price: Double
    let category: Category
    let identifier = UUID()
    
    // implement the hashable property for item
    // Hasher is the (hash function) in swift
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    // create test data
    static func testData() -> [Items] {
        return [
            Items(name: "Polar Bluetooth", price: 0, category: .running),
            Items(name: "DonJoy Performance POD Ankle Brace", price: 55.66, category: .running),
            Items(name: "Cracking the Coding Interview", price: 26.99, category: .education),
            Items(name: "The Pragmatic Programmer", price: 42.66, category: .education),
            Items(name: "Tri shoes", price: 120.00, category: .triathlon),
            Items(name: "Tri suit", price: 240.0, category: .triathlon),
            Items(name: "Towel hooks", price: 50.0, category: .household),
            Items(name: "Debrox Swimmer's Ear", price: 7.99, category: .health),
            Items(name: "Fitbit Versa 2", price: 199.95, category: .technology)
        ]
    }
}
