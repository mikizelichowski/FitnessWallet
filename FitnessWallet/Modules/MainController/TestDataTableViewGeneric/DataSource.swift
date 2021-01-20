//
//  DataSource.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 19/01/2021.
//

import UIKit

class DataSource: UITableViewDiffableDataSource<Category, Items> {
 
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if Category.allCases[section] == .shoppingCart {
            return "🛒 " + Category.allCases[section].rawValue
        } else {
            return Category.allCases[section].rawValue // "Running"
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 1. get the current snapshot
            var snapshot = self.snapshot()
            // 2. get the item using the itemIdentifier
            if let item  = itemIdentifier(for: indexPath) {
                // 3. delete the item from snapshot
                snapshot.deleteItems([item])
                // 4. apply the snapshot (apply changes to the datasource which in turn updates the table view)
                apply(snapshot, animatingDifferences: true)
            }
        }
    }
}
