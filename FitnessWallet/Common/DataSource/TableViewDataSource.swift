//
//  TableViewDataSource.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 17/12/2020.
//

import Foundation
import UIKit.UITableView
import Differ

class TableViewDataSource<T: DataSourceSection, U: DataSourceIdentifiable & Equatable & Hashable>: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private enum ViewType {
        case cell
        case section
        case footer
    }
    
    typealias CellConfigureClosureType = (DataSourceCell<U>, U) -> (UITableViewCell)
    typealias SectionConfigureClosureType = (DataSourceSectionView<T>, T) -> (UITableViewHeaderFooterView)
    
    typealias SectionHeightClosureType = (DataSourceSectionView<T>, T, CGFloat, UITableView) -> (CGFloat)
    typealias CellDitTapClosureType = (U, [T], IndexPath) -> ()
    
    var cellDidTapClosure: CellDitTapClosureType?
    
    private weak var tableView: UITableView!
    private let cellConfigureClosure: CellConfigureClosureType
    private let sectionConfigureClosure: SectionConfigureClosureType?
    private let sectionHeightClosure: SectionHeightClosureType?
    private var registerIdentifiers: Set<String> = Set()
    private(set) var dataSource: [T] = []
    
    init(_ tableView: UITableView, cellConfigureClosure: @escaping CellConfigureClosureType, sectionConfigureClosure: SectionConfigureClosureType? = nil, sectionHeightClosure: SectionHeightClosureType? = nil) {
        self.tableView = tableView
        self.cellConfigureClosure = cellConfigureClosure
        self.sectionConfigureClosure = sectionConfigureClosure
        self.sectionHeightClosure = sectionHeightClosure
        super.init()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func update(with newDataSource: [T]) {
        self.dataSource = self.dataSource.apply(patch(from: self.dataSource, to: newDataSource))
        tableView.reloadData()
    }
    
    private func fetchItem(for indexPath: IndexPath) -> U {
        return dataSource[indexPath.row].items[indexPath.row] as! U
    }
    
    private func fetchSection(for section: Int) -> T {
        return dataSource[section]
    }
    
    private func sectionsCount() -> Int {
        return dataSource.count
    }
    
    private func itemsCount(for section: Int) -> Int {
        guard dataSource.isNotEmpty else {
            return .zero
        }
        guard section < dataSource.count else {
            fatalError("Section \(section) out of bounds (dataSource count: \(dataSource.count)")
        }
        return dataSource[section].items.count
    }
    
    private func registerViewIfNeeded(_ identifier: String, viewType: ViewType) {
        guard !registerIdentifiers.contains(identifier) else {
            return
        }
        registerIdentifiers.insert(identifier)
        
        switch viewType {
        case .cell:
            tableView.register(TableViewDataSource.self, forCellReuseIdentifier: identifier)
        case .section, .footer:
            tableView.register(TableViewDataSource.self, forHeaderFooterViewReuseIdentifier: identifier)
        }
    }
    
    // MARK: TableView DataSource & Delegate
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionItem = fetchSection(for: section)
        guard let viewIdentifier = sectionItem.viewIdentifier else {
            return .leastNormalMagnitude
        }
        
        registerViewIfNeeded(viewIdentifier, viewType: .section)
        let headerView: DataSourceSectionView<T> = tableView.dequeueReusableHeaderFooterView(withIdentifier: viewIdentifier) as! DataSourceSectionView
        let size = headerView.systemLayoutSizeFitting(CGSize(width: tableView.frame.width, height: .greatestFiniteMagnitude))
        return sectionHeightClosure?(headerView, sectionItem, size.height, tableView) ?? size.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionItem = fetchSection(for: section)
        guard let viewIdentifier = sectionItem.viewIdentifier, let sectionConfigureClosure = sectionConfigureClosure else { return nil }
        registerViewIfNeeded(viewIdentifier, viewType: .section)
        
        let headerView: DataSourceSectionView<T> = tableView.dequeueReusableHeaderFooterView(withIdentifier: viewIdentifier) as! DataSourceSectionView
        return sectionConfigureClosure(headerView, sectionItem)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsCount(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = fetchItem(for: indexPath)
        guard let cellIdentifier = item.viewIdentifier else {
            fatalError("You need to specify cellIdentifier first")
        }
        registerViewIfNeeded(cellIdentifier, viewType: .cell)
        
        let cell: DataSourceCell<U> = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! DataSourceCell
        return self.cellConfigureClosure(cell, item)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = fetchItem(for: indexPath)
        cellDidTapClosure?(item, dataSource, indexPath)
    }
}
