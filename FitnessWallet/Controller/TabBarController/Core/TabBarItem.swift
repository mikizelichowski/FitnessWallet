//
//  TabBarItem.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 16/12/2020.
//

import UIKit

enum TabBarItem: Int, CaseIterable {
    case main
    case training
    case notification
    case profile
    
    var title: String {
        switch self {
        case .main:
            return "Main"
        case .training:
            return "Training"
        case .notification:
            return "Notification"
        case .profile:
            return "Profile"
        }
    }
    
    var image: UIImage {
        switch self {
        case .main:
            return UIImage(systemName: "house")!
        case .training:
            return UIImage(systemName: "flame")!
        case .notification:
            return UIImage(systemName: "paperplane")!
        case .profile:
            return UIImage(systemName: "person")!
        }
    }
}
