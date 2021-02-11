//
//  ItemFeedViewController.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 19/01/2021.
//

#warning(" TEST -  DELETE")

import UIKit

class ViewBaseController: UIViewController {
    private var tableView: UITableView!
    private var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureDataSource()
        configureNavBar()
    }
    
    private func configureNavBar() {
        navigationItem.title = "Training List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditState))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddVC))
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .systemGroupedBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    private func configureDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            if (item.price != nil) {
                let formattedPrice = String(format: "%.2f", item.price ?? 0)
                cell.textLabel?.text = "\(item.name)\nPrice: $\(formattedPrice)"
            } else {
                let formattedReps = String(item.reps ?? 0)
                cell.textLabel?.text = "\(item.name)\nReps: \(formattedReps)"
            }
            cell.textLabel?.numberOfLines = 0
            return cell
        })
        dataSource.defaultRowAnimation = .fade
        
        var snapshot = NSDiffableDataSourceSnapshot<Category, Items>()

        for category in Category.allCases {
            let items = Items.testData().filter { $0.category == category }
            snapshot.appendSections([category])
            snapshot.appendItems(items)
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    @objc
    private func toggleEditState() {
        // change editing for delete( no swipe)
        // true -> false -> true
        tableView.setEditing(!tableView.isEditing, animated: true)
        navigationItem.leftBarButtonItem?.title = tableView.isEditing ? "Done" : "Edit"
    }
    
    @objc
    private func presentAddVC() {
        let controller = AddItemViewController()
        navigationController?.present(controller, animated: true, completion: nil)
    }
}

extension ViewBaseController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let client = dataSource.itemIdentifier(for: indexPath) else { return }
        print("DEBUG: \(client.category.rawValue)")
        print("DEBUG: \(client.name)")
    }
}

//extension ViewBaseController: AddItemViewControllerDelegate {
//    func didAddItem(item: Items) {
//        var snapshot = dataSource.snapshot()
//        snapshot.appendItems([item], toSection: item.category)
//        dataSource.apply(snapshot, animatingDifferences: true)
//    }
//}

extension ViewBaseController: AddItemViewControllerDelegate {
    func didAddNewItem(_ addItemViewController: AddItemViewController, item: Items) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems([item], toSection: item.category)
        
        // no need for reloadData()
        // no need for property observers
        // apply snapshot is all we need with diffable data source
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
