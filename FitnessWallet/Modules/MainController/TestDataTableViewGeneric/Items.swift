//
//  Items.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 19/01/2021.
//
#warning("TEST - Delete")
import Foundation

struct Items: Hashable {
    let name: String
    let reps: Int?
    let price: Double?
    let category: Category
    let identifier = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func testData() -> [Items] {
        return [
            Items(name: "K-bell", reps: 10, price: nil, category: .crossfit),
            Items(name: "Bench press", reps: 15, price: nil, category: .chest),
            Items(name: "Hack machine", reps: 12, price: nil, category: .legs),
            Items(name: "Dead lift", reps: 10, price: nil, category: .back),
            Items(name: "Dumbbell", reps: 20, price: nil, category: .arms),
            Items(name: "Rope pull down", reps: 20, price: nil, category: .arms),
            Items(name: "Run", reps: 1500, price: nil, category: .triathlon),
            Items(name: "Whey Protein", reps: nil, price: 19.90, category: .shoppingCart),
            Items(name: "Bcaa", reps: nil, price: 25.50, category: .shoppingCart)
        ]
    }
}
