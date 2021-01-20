//
//  MainViewController.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 16/12/2020.
//

import UIKit
import SDWebImage

final class MainViewController: UIViewController {
    enum SupplementaryElementKind {
        static let sectionHeader = "supplementary-section-header"
    }
    
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, Model>
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Model>

    private var collectionView: UICollectionView!
    private var dataSource: DataSource!
    private var snapshot = DataSourceSnapshot()
    
    var viewModel: MainViewModelProtocol
    
    init(with viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backgroundColor = .black
        createLayout()
        viewModel.onViewDidLoad()
    }
    
    private func populateData() {
        let exercisesListCellRegistration = UICollectionView.CellRegistration<ExercisesCell, Model> {
            cell, indexPath, dataItem in
            if case .exercises(let exercises) = dataItem.dataItem {
                cell.populate(with: exercises)
            }
        }
        
        let customersListCellRegistration = UICollectionView.CellRegistration<CustomersCell, Model> {
            cell, indexPath, dataItem in
            if case .customers(let customers) = dataItem.dataItem {
                cell.populate(with: customers)
            }
        }
        
        let remainingCellRegistration = UICollectionView.CellRegistration<RemainingCell, Model> {
            cell, indexPath, dataItem in
            if case .remaining(let remaining) = dataItem.dataItem {
                cell.populate(with: remaining)
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, model) -> UICollectionViewCell? in
            guard let sectionKind = Section(rawValue: indexPath.section) else {
                fatalError("Unhandled section: \(indexPath.section)")
            }
            switch sectionKind {
            case .training:
                return collectionView.dequeueConfiguredReusableCell(using: exercisesListCellRegistration, for: indexPath, item: model)
            case .customerList:
                return collectionView.dequeueConfiguredReusableCell(using: customersListCellRegistration, for: indexPath, item: model)
            case .remaining:
                return collectionView.dequeueConfiguredReusableCell(using: remainingCellRegistration, for: indexPath, item: model)
            }
        })
        
        let sectionHeaderRegistration = UICollectionView.SupplementaryRegistration<SectionHeaderView>(elementKind: SupplementaryElementKind.sectionHeader) { header, kind, indexPath in
            guard let sectionKind = Section(rawValue: indexPath.section) else {
                fatalError("Unhandled section: \(indexPath.section)")
            }
            header.label.text = sectionKind.sectionHeader
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            switch kind {
            case SupplementaryElementKind.sectionHeader:
                return collectionView.dequeueConfiguredReusableSupplementary(using: sectionHeaderRegistration, for: indexPath)
            default:
                return nil
            }
        }
    }
    
    private func createLayout() {
        let layout = LayoutManager().createLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
//        collectionView.backgroundColor = //.systemBackground
        view.addSubview(collectionView)
        collectionView.fillSuperView()  //fillSuperViewArea()
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        populateData()
        refresher()
    }
    
    private func refresher() {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refresher
    }
    
    @objc
    private func handleRefresh() {
        viewModel.send(action: .refreshView(true))
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let customer = dataSource.itemIdentifier(for: indexPath) else { return }
        
    }
}

extension MainViewController: MainViewModelDelegate {
    func udpateDataSource(_ dataSource: [SectionModel]) {
        // nie wiem, sprawdzic i rozwiazac ten problem....
    }
    
    func updateSnapshot(clients: [Customers]) {
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(clients.map { Model(dataItem: .exercises($0))}, toSection: .training)
        snapshot.appendItems(clients.map { Model(dataItem: .customers($0))}, toSection: .customerList)
        snapshot.appendItems(clients.map { Model(dataItem: .remaining($0))}, toSection: .remaining)
        
        // sprawdzic jutro
//        snapshot.reloadSections([SectionModel(style: .customerList))
        self.dataSource.apply(self.snapshot, animatingDifferences: true)
    }
    
    func refreshController() {
        collectionView.refreshControl?.endRefreshing()
    }
    
    func showLoading(_ state: Bool) {
        showLoader(state)
    }
}
