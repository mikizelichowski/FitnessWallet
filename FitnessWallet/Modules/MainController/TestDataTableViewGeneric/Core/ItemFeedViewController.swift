//
//  ItemFeedViewController.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 19/01/2021.
//

import UIKit

class ViewBaseController: UIViewController {
    
    private var tableView: UITableView!
    private var dataSource: DataSource!
//    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureDataSource()
        configureNavBar()
    }
    
    private func configureNavBar() {
        navigationItem.title = "Shopping List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditState))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddVC))
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .systemGroupedBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.registerCell(UITableViewCell.self)
        view.addSubview(tableView)
    }
    
    private func configureDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "\(item.name)"
            return cell
        })
        
        // setup type of animation
        dataSource.defaultRowAnimation = .fade
        
        // setup initial snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Category, Items>()
        
        // populate snapshot with sections and items for each section
        // CaseIterable allows us to iterate through all the cases of an enum
        for category in Category.allCases { // all cases from the Category enum
            // filter the testData [items] for particular category's items
            let items = Items.testData().filter { $0.category == category }
            snapshot.appendSections([category]) // add section to table View
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
        // TODO:
        // 1. create a AddItemViewController.swift file
        // 2. add a View Controller object
        // 3. add 2 textfields, one for the item name and other for price
        // 4. add a picker view to manage the categories
        // 5. user is able to add a new item to a given category and click on a submit button
        // 6. use any communication paradigm to get data from AddItemViewController back to the ViewController
        // types: delegation, KVO, notification center, unwind seque, callback, combine
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
