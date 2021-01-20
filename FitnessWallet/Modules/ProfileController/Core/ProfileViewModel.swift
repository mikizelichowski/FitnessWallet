//
//  File.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import Foundation

protocol ProfileViewModelProtocol: class {
    var delegate: ProfileViewModelDelegate! { get set }
}

protocol ProfileViewModelDelegate: class {
    
}

final class ProfileViewModel {
    weak var delegate: ProfileViewModelDelegate!
    
    private let coordinate: ProfileCoordinatorProtocol
    
    init(coordinate: ProfileCoordinatorProtocol) {
        self.coordinate = coordinate
    }
}

extension ProfileViewModel: ProfileViewModelProtocol {
    
}
