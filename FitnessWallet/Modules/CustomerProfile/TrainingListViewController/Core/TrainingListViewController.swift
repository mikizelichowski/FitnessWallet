//
//  TrainingListViewController.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 28/01/2021.
//

import UIKit

final class TrainingListViewController: UIView {
    typealias DataSource = UITableViewDiffableDataSource<SectionTrainingListDataSource, PackageModel>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<SectionTrainingListDataSource, PackageModel>
    
    private var tableView: UITableView!
    private var dataSource: DataSource!
    private var snapshot = DataSourceSnapshot()
    
    private var viewModel: TrainingListViewModelProtocol
    
    init(with viewModel: TrainingListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupTableView()
        viewModel.onViewDidLoad()
    }
    
    private func setupTableView() {
        
        backgroundColor = .white
        tableView = UITableView(frame: bounds, style: .insetGrouped)
        tableView.layer.addShadow(type: .iconButton)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .clear
        tableView.registerCell(TrainingListCell.self)
        addSubview(tableView)
        populateData()
    }
    
    private func populateData() {
        dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, trainingList) -> UITableViewCell? in
            let cell: TrainingListCell = tableView.dequeueReusableTableViewCell(indexPath: indexPath)
            cell.update(with: trainingList)
            return cell
        })
        dataSource.defaultRowAnimation = .left
    }
}

extension TrainingListViewController: TrainingListViewModelDelegate {
    func updateSnapshotPackage(with model: [PackageModel]) {
        snapshot.deleteAllItems()
        snapshot.appendSections(viewModel.sectionDataSource)
        snapshot.appendItems(model)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
