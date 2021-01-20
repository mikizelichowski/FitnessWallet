//
//  TabBarNavigationController.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 16/12/2020.
//

import UIKit

enum ForStatusBarStyle {
    case main
    case training
    case notification
    case profile
    case defaultStyle
}

final class TabBarNavigationController: BaseNavigationController {
    private var item: TabBarItem
    
    var statusBarStyle: ForStatusBarStyle = .defaultStyle
    
    init(item: TabBarItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
        setupController()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        switch statusBarStyle {
        case .main, .training, .notification, .profile:
        return .default
        case .defaultStyle:
            return .lightContent
        }
    }
    
    private func setupController() {
        tabBarItem.title = item.title
        tabBarItem.image = item.image
    }
    
    private func setupStatusBarStyle(style: ForStatusBarStyle) {
        statusBarStyle = style
    }
}
