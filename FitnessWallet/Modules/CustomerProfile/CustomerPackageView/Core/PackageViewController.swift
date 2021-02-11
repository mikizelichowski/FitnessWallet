//
//  PackageViewController.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 26/01/2021.
//

import UIKit

final class PackageViewController: UIView {
    enum SupplementaryElementKind {
        static let sectionHeader = "supplementary-section-package"
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<SectionPackageStyle, ItemPackageModels>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<SectionPackageStyle, ItemPackageModels>
    
    private var collectionView: UICollectionView!
    private var dataSource: DataSource!
    private var snapshot = DataSourceSnapshot()
    
    private var viewModel: PackageViewModelProtocol
    
    init(with viewModel: PackageViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        setupCollectionView()
        viewModel.onViewDidLoad()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            guard let sectionKind = SectionPackageStyle(rawValue: sectionIndex) else {
                fatalError("Undefined section for value \(sectionIndex)")}
            switch sectionKind {
            case .package: return CustomerProfileLayoutManager().createPackageItemSection()
            }
        }
        return layout
    }
    
    private func setupCollectionView() {
        let layout = createLayout()
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .white
        collectionView.layer.addShadow(type: .iconButton)
        collectionView.layer.cornerRadius = CGFloat(StringRepresentationOfDigit.twelve)
        collectionView.registerCell(PackageListCell.self)
        // refresh
        populateData()
    }
    
    private func populateData() {
        let packageCellRegistration = UICollectionView.CellRegistration<PackageListCell, ItemPackageModels> {
            cell, indexPath, dataPackage in
            if case .package(let package) = dataPackage.dataItem {
                cell.updateCell(model: package)
            }
        }
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, model) -> UICollectionViewCell? in
            guard let sectionKind = SectionPackageStyle(rawValue: indexPath.section) else {
                fatalError()
            }
            switch sectionKind {
            case .package:
                return collectionView.dequeueConfiguredReusableCell(using: packageCellRegistration, for: indexPath, item: model)
            }
        })
        
        let sectionHeaderRegistration = UICollectionView.SupplementaryRegistration<SectionPackageView>(elementKind: SupplementaryElementKind.sectionHeader) { header, kind, indexPath in
            guard let sectionKind = SectionPackageStyle(rawValue: indexPath.section) else {
                fatalError("Unhandled section: \(indexPath.section)")
            }
            header.label.text = sectionKind.title
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            switch kind {
            case SupplementaryElementKind.sectionHeader:
                return collectionView.dequeueConfiguredReusableSupplementary(using: sectionHeaderRegistration, for: indexPath)
            default: return nil
            }
        }
    }
}

extension PackageViewController: PackageViewModelDelegate {
    func showAction(action: ActionPackageDelegate) {
        switch action {
        case .refreshController:
            collectionView.refreshControl?.endRefreshing()
        case .showLoading(_): ()
        //            showLoader(sate)
        case .alertMessage(title: let title, message: let message, completion: let completion):
            showMessage(withTitle: title, message: message, completion: completion)
        }
    }
    
    func updateSnapshot(with model: [PackageModel]) {
        snapshot.deleteAllItems()
        snapshot.appendSections(SectionPackageStyle.allCases)
        snapshot.appendItems(model.map { ItemPackageModels(dataItem: .package($0))}, toSection: .package)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension PackageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let package = dataSource.itemIdentifier(for: indexPath) else { return }
        viewModel.updateSelectedData(with: package.dataItem)
        print("DEBUG: selected \(package.dataItem)")
    }
}
