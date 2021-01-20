//
//  TabBarViewModel.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import Foundation

protocol TabBarViewModelProtocol: class {
    var delegate: TabBarViewModelDelegate! { get set }
}

protocol TabBarViewModelDelegate: class {
    func selectTabBarElement(at index: Int)
}

final class TabBarViewModel: TabBarViewModelProtocol {
    weak var delegate: TabBarViewModelDelegate!
    
    private let coordinator: MainCoordinatorProtocol
    
    init(coordinator: MainCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func tabBarDidTap(at index: Int) {
        delegate.selectTabBarElement(at: index)
    }
}
