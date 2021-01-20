//
//  CollectionViewDataSource.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import Foundation
import UIKit.UICollectionView
import Differ

class CollectionViewDataSource<T: DataSourceSection, U: DataSourceIdentifiable & Equatable & Hashable>: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private enum ViewType {
        case cell
        case section
        case footer
    }
    
    typealias CellConfigureClosureType = (CollectionCellDataSource<U>, U) -> (UICollectionViewCell)
    typealias SectionConfigureClosureType = (CollectionHeaderDataSource<T>, T) -> (UICollectionReusableView)
    typealias SectionHeightClosureType = (CollectionHeaderDataSource<T>, T, CGFloat, UICollectionView) -> (CGFloat)
    typealias CellDidTapClosureType = (U, [T], IndexPath) -> ()
    
    var cellDidTapClosureType: CellDidTapClosureType?
    
    private weak var collectionView: UICollectionView!
    private let cellConfigureClosureType: CellConfigureClosureType
    private let sectionConfigureClosure: SectionConfigureClosureType?
    private let sectionHeightClosure: SectionHeightClosureType?
    private var registeredIdentifiers: Set<String> = Set()
    private(set) var dataSource: [T] = []
    
    init(_ collectionView: UICollectionView, cellConfigureClosure: @escaping CellConfigureClosureType, sectionConfigureClosure: SectionConfigureClosureType? = nil, sectionHeightClosure: SectionHeightClosureType? = nil) {
        self.collectionView = collectionView
        self.cellConfigureClosureType = cellConfigureClosure
        self.sectionConfigureClosure = sectionConfigureClosure
        self.sectionHeightClosure = sectionHeightClosure
        super.init()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func update(with newDataSource: [T]) {
        self.dataSource = self.dataSource.apply(patch(from: self.dataSource, to: newDataSource))
        collectionView.reloadData()
    }
    
    private func fetchItem(for indexPath: IndexPath) -> U {
        return dataSource[indexPath.section].items[indexPath.row] as! U
    }
    
    private func fetchSection(for section: Int) -> T {
        return dataSource[section]
    }
    
    private func sectionCount() -> Int {
        return dataSource.count
    }
    
    private func itemsCount(for section: Int) -> Int {
        guard dataSource.isNotEmpty else { return .zero }
        guard section < dataSource.count else {
            fatalError("Section\(section) out of bounds (dataSource count: \(dataSource.count)")
        }
        return dataSource[section].items.count
    }
    
    private func registerViewIfNeeded(_ identifier: String, viewType: ViewType) {
        guard !registeredIdentifiers.contains(identifier) else { return}
        
        registeredIdentifiers.insert(identifier)
        
        switch viewType {
        case .cell:
            collectionView.register(UINib(nibName: identifier, bundle: Bundle(for: CollectionViewDataSource.self)), forCellWithReuseIdentifier: identifier)
            collectionView.register(CollectionViewDataSource.self, forCellWithReuseIdentifier: identifier)
        case .section, .footer:
            collectionView.register(UINib(nibName: identifier, bundle: Bundle(for: CollectionViewDataSource.self)), forCellWithReuseIdentifier: identifier)
            collectionView.register(CollectionViewDataSource.self, forCellWithReuseIdentifier: identifier)
        }
    }
    
    // MARK: - Table View Delegate & Data Source
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    // MARK: - SECTION
    #warning("WROCIC DO TEGO !!!!")
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
////        let headerItem = fetchItem(for: indexPath)
////        guard let cellIdentifier = headerItem.viewIdentifier else { fatalError("You need to specify cellIdentifier first")}
////
////        registerViewIfNeeded(cellIdentifier, viewType: .cell)
////        let cell: CollectionHeaderDataSource<T> = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellIdentifier, for: indexPath) as! CollectionHeaderDataSource
////        return sectionConfigureClosure?(cell, headerItem as! T)
//        //self.cellConfigureClosureType(cell, headerItem)
//
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = fetchItem(for: indexPath)
        guard let viewIdentifier = item.viewIdentifier else { return .zero}
        registerViewIfNeeded(viewIdentifier, viewType: .cell)
        
        
        #warning("do poprawki")
        return CGSize(width: 12, height: 12)
    }
    #warning("WROCIC DO TEGO !!!")
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//
//    }
//
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsCount(for: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = fetchItem(for: indexPath)
        guard let cellIdentifier = item.viewIdentifier else { fatalError("You need to specify cellIdentifier first")
        }
        registerViewIfNeeded(cellIdentifier, viewType: .cell)
        let cell: CollectionCellDataSource<U> = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CollectionCellDataSource
        return self.cellConfigureClosureType(cell, item)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = fetchItem(for: indexPath)
        cellDidTapClosureType?(item, dataSource, indexPath)
    }
    
}
