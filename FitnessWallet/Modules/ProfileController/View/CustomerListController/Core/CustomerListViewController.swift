//
//  CustomerListViewController.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 20/01/2021.
//

import UIKit

final class CustomerListViewController: UIViewController {
    enum Sections {
        case main
    }
    
    typealias DataSource = UITableViewDiffableDataSource<SectionCustomerListDataSource, Customers>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<SectionCustomerListDataSource, Customers>
    
    private var tableView: UITableView!
    private var dataSource: DataSource!
    private var snapshot = DataSourceSnapshot()
    
    var viewModel: CustomerListViewModelProtocol
    
    init(with viewModel: CustomerListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onViewDidLoad()
        setupTableView()
        populateData()
        refresher()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController(false)
        navigationItem.title = viewModel.title
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(toggleEditState))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCustomer))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        setupNavigationController(true)
    }
    
    private func setupTableView() {
        view.backgroundColor = .white
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.layer.addShadow(type: .iconButton)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .clear
        tableView.registerCell(CustomerListCell.self)
        view.addSubview(tableView)
    }
    
    private func populateData() {
        dataSource = DataSource(tableView: tableView,
                                cellProvider: { (tableView, indexPath, customers) -> UITableViewCell? in
            let cell: CustomerListCell = tableView.dequeueReusableTableViewCell(indexPath: indexPath)
            cell.update(with: customers)
            return cell
        })
        dataSource.defaultRowAnimation = .fade
    }
    
    private func refresher() {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refresher
    }
    
    @objc
    private func handleRefresh() {
        viewModel.send(action: .refreshView(true))
    }
    
    @objc
    private func addNewCustomer() {
        viewModel.showAddCustomerView()
    }
    
    @objc
    private func toggleEditState() {
    }
}

extension CustomerListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let customer = dataSource.itemIdentifier(for: indexPath) else { return }
        print("DEBUG: Selected customer \(customer.username)")
    }
}

extension CustomerListViewController: CustomerListViewModelDelegate {
    func showAction(action: ActionDelegate) {
        switch action {
        case .refreshController:
            tableView.refreshControl?.endRefreshing()
        case .showLoading(let state):
            showLoader(state)
        }
    }
    
    func updateSnapshot(with model: [Customers]) {
        snapshot.deleteAllItems()
        snapshot.appendSections(viewModel.sectionDataSource)
        snapshot.appendItems(model)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
