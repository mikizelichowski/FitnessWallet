//
//  TrainingViewModel.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import Foundation

protocol TrainingViewModelProtocol: class {
    var delegate: TrainingViewModelDelegate! { get set }
}

protocol TrainingViewModelDelegate: class {
}

final class TrainingViewModel {
    weak var delegate: TrainingViewModelDelegate!
    
    private let coordinate: TrainingCoordinatorProtocol
    
    init(coordinate: TrainingCoordinatorProtocol) {
        self.coordinate = coordinate
    }
}

extension TrainingViewModel: TrainingViewModelProtocol {
    
}
