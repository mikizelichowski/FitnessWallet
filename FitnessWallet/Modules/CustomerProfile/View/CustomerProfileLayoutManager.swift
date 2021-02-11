//
//  CustomerProfileLayoutManager.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 22/01/2021.
//

import UIKit

enum ReuseIdentifierCustomerProfile {
    enum SupplementaryElementKind {
        static let sectionHeader = "supplementary-section-package"
    }
    enum DecorationKind {
        static let categoryKindBackground = "decoration-categoryBackground"
    }
}

struct CustomerProfileLayoutManager {
    private enum Constants {
        static let sectionSpacing: CGFloat = 20.0
        static let fractionWidthOne: CGFloat = 1.0
        static let fractionHeightOne: CGFloat = 1.0
        static let sectionCategoryHeaderHight: CGFloat = 200
        static let sectionHeaderHeight: CGFloat = 50.0
        static let marginTop: CGFloat = 4.0
        static let marginBottom: CGFloat = 4.0
        static let marginLeft: CGFloat = 10.0
        static let marginRight: CGFloat = 10.0
        static let packageGroupSizeHeight: CGFloat = 220.0
        static let categoryGroupSizeWidth: CGFloat = 150.0
    }
 
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            guard let sectionKind = SectionCustomerProfile(rawValue: sectionIndex) else { fatalError("Undefined section for value: \(sectionIndex)") }
            switch sectionKind {
            case .package: return createPackageItemSection()
            case .trainingList: return createTrainingListItemSection()
            case .exercises: return createTrainingListItemSection()
            }
        }
        
        layout.register(CustomerBackgroundDecoration.self, forDecorationViewOfKind: ReuseIdentifier.DecorationKind.customerListBackground)
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = Constants.sectionSpacing
        layout.configuration = configuration
        return layout
    }
    
    func createSectionHeaderSupplementary() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.fractionWidthOne), heightDimension: .absolute(Constants.sectionHeaderHeight))
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: ReuseIdentifierCustomerProfile.SupplementaryElementKind.sectionHeader, alignment: .top)
        return headerSupplementary
    }
    
    func createPackageItemSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.fractionHeightOne), heightDimension: .fractionalHeight(Constants.fractionHeightOne))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.fractionWidthOne), heightDimension: .estimated(Constants.packageGroupSizeHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.boundarySupplementaryItems = [createSectionHeaderSupplementary()]
        return section
    }
    
    func createTrainingListItemSection() -> NSCollectionLayoutSection {
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
