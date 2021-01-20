//
//  LayoutManager.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 05/01/2021.
//

import UIKit

enum ReuseIdentifier {
    enum SupplementaryElementKind {
        static let sectionHeader = "supplementary-section-header"
    }
    enum DecorationKind {
        static let customerListBackground = "decoration-customerListBacground"
    }
}

struct LayoutManager {
    private enum Constants {
        static let sectionSpacing: CGFloat = 40.0
        static let fractionWidthOne: CGFloat = 1.0
        static let fractionHeightOne: CGFloat = 1.0
        static let sectionHeaderHight: CGFloat = 50.0
        static let groupSizeHeightTraining: CGFloat = 250.0
        static let marginTop: CGFloat = 4.0
        static let marginBottom: CGFloat = 4.0
        static let marginLeft: CGFloat = 10.0
        static let marginRight: CGFloat = 10.0
        static let customerGroupSizeHeight: CGFloat = 180.0
        static let customerGroupSizeWidth: CGFloat = 230.0
    }
    
    func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            guard let sectionKind = Section(rawValue: sectionIndex) else {
                fatalError("Undefined section for value: \(sectionIndex)")
            }
            switch sectionKind {
            case .training:     return createTrainingSection()
            case .customerList: return createCustomerList()
            case .remaining:    return createRemainingSection()
            }
        }
        
        layout.register(CustomerBackgroundDecoration.self, forDecorationViewOfKind: ReuseIdentifier.DecorationKind.customerListBackground)
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = Constants.sectionSpacing
        layout.configuration = configuration
        return layout
    }
    
    // MARK: - Section Title
    
    func createSectionHeaderSupplementary() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.fractionWidthOne), heightDimension: .absolute(Constants.sectionHeaderHight))
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: ReuseIdentifier.SupplementaryElementKind.sectionHeader, alignment: .top)
        return headerSupplementary
    }
    
    func createTrainingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.fractionWidthOne), heightDimension: .fractionalHeight(Constants.fractionHeightOne))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.fractionWidthOne), heightDimension: .estimated(Constants.groupSizeHeightTraining))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [createSectionHeaderSupplementary()]
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
    
    func createCustomerList() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.fractionWidthOne), heightDimension: .fractionalHeight(Constants.fractionHeightOne))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: Constants.marginTop, leading: Constants.marginLeft, bottom: Constants.marginBottom, trailing: Constants.marginRight)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(Constants.customerGroupSizeWidth), heightDimension: .estimated(Constants.customerGroupSizeHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [createSectionHeaderSupplementary()]
        
        section.decorationItems = [NSCollectionLayoutDecorationItem.background(elementKind: ReuseIdentifier.DecorationKind.customerListBackground)]
        return section
    }
    
    func createRemainingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.fractionWidthOne), heightDimension: .fractionalHeight(Constants.fractionHeightOne))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: CGFloat(StringRepresentationOfDigit.two),
                                                     leading: CGFloat(StringRepresentationOfDigit.four),
                                                     bottom: CGFloat(StringRepresentationOfDigit.two),
                                                     trailing: CGFloat(StringRepresentationOfDigit.four))
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.fractionWidthOne), heightDimension: .estimated(CGFloat(StringRepresentationOfDigit.hundred)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [createSectionHeaderSupplementary()]
        
        section.decorationItems = [NSCollectionLayoutDecorationItem.background(elementKind: ReuseIdentifier.DecorationKind.customerListBackground)]
        return section
    }
}
