//
//  TabBarController.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import UIKit

final class TabBarController: UITabBarController {
    private enum Constants {
        static let indicatorWidth: CGFloat = 60.0
        static let indicatorHeight: CGFloat = 2.0
        static let shadowOffset = CGSize(width: .zero, height: 4)
        static let shadowOpacity: Float = 1.0
        static let shadowRadius: CGFloat = 12.0
        static let blueDark0 = UIColor(red: 0.02, green: 0.23, blue: 0.40, alpha: 1.0)
        static let greyBlueLight = UIColor(red: 0.4, green: 0.47, blue: 0.54, alpha: 1.0)
        static let dashboardViewCellShadow = UIColor(red: 0.12, green: 0.36, blue: 0.61, alpha: 0.3)
    }
    
    private let viewModel: TabBarViewModelProtocol
    
    init(with viewModel: TabBarViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        tabBar.selectionIndicatorImage = UIImage().createSelectionIndicator(color: Constants.blueDark0, size: CGSize(width: Constants.indicatorWidth, height: tabBar.frame.height), lineHeight: Constants.indicatorHeight)
    }
    
    private func setupTabBar() {
        tabBar.isTranslucent = false
        tabBar.tintColor = Constants.blueDark0
        tabBar.sizeToFit()
        
        tabBar.unselectedItemTintColor = Constants.greyBlueLight
        tabBar.barTintColor = .white
        setupShadow()
    }
    
    private func setupShadow() {
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowOffset = Constants.shadowOffset
        tabBar.layer.shadowColor = Constants.dashboardViewCellShadow.cgColor
        tabBar.layer.shadowOpacity = Constants.shadowOpacity
        tabBar.layer.shadowRadius = Constants.shadowRadius
    }
}

extension TabBarController: TabBarViewModelDelegate {
    func selectTabBarElement(at index: Int) {
        selectedIndex = index
    }
}

extension UIImage {
    func createSelectionIndicator(color: UIColor, size: CGSize, lineHeight: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, .zero)
        color.setFill()
        UIRectFill(CGRect(x: .zero, y: .zero, width: size.width, height: lineHeight))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
