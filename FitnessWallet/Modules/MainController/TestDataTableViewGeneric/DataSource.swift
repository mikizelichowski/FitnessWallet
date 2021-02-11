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
            return Category.allCases[section].rawValue
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var snapshot = self.snapshot()
            if let item  = itemIdentifier(for: indexPath) {
                snapshot.deleteItems([item])
                apply(snapshot, animatingDifferences: true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let sourceItem = itemIdentifier(for: sourceIndexPath) else { return }
        guard sourceIndexPath != destinationIndexPath else { return }
        
        let destinationItem = itemIdentifier(for: destinationIndexPath)
        var snapshot = self.snapshot()
        if let destinationItem = destinationItem {
            if let sourceIndex = snapshot.indexOfItem(sourceItem),
               let destinationIndex = snapshot.indexOfItem(destinationItem) {
                
                let isAfter = destinationIndex > sourceIndex
                    && snapshot.sectionIdentifier(containingItem: sourceItem) == snapshot.sectionIdentifier(containingItem: destinationItem)
                
                snapshot.deleteItems([sourceItem])
                if isAfter {
                    snapshot.insertItems([sourceItem], afterItem: destinationItem)
                }
                else {
                    snapshot.insertItems([sourceItem], beforeItem: destinationItem)
                }
            }
        }
        
        else {
            let destinationSection = snapshot.sectionIdentifiers[destinationIndexPath.section]
            snapshot.deleteItems([sourceItem])
            snapshot.appendItems([sourceItem], toSection: destinationSection)
        }
        apply(snapshot, animatingDifferences: false)
    }
}
