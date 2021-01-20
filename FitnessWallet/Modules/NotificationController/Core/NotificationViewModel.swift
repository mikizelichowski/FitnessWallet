//
//  NotificationViewModel.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import Foundation

protocol NotificationViewModelProtocol: class {
    var delegate: NotificationViewModelDelegate! { get set }
}

protocol NotificationViewModelDelegate: class {
    
}

final class NotificationViewModel {
    weak var delegate: NotificationViewModelDelegate!
    
    private let coordinate: NotificationCoordinatorProtocol
    
    init(coordinate: NotificationCoordinatorProtocol) {
        self.coordinate = coordinate
    }
    
}

extension NotificationViewModel: NotificationViewModelProtocol {
    
}
