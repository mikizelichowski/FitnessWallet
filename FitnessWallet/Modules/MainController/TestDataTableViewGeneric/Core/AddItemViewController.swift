//
//  AddItemViewController.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 19/01/2021.
//

import UIKit

protocol AddItemViewControllerDelegate: AnyObject {
    func didAddNewItem(_ addItemViewController: AddItemViewController, item: Items)
}

class AddItemViewController: UIViewController {
    
    private let addButton = UIButton()
    private let nameTextField = UITextField()
    private let priceTextField = UITextField()
    private let pickerView = UIPickerView()
    
    weak var delegate: AddItemViewControllerDelegate?
    var addItemsToShopListClosure: ((Items) -> ())?
    
    private var selectedCategory: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        selectedCategory = Category.allCases.first
    }
    
    private func setupUI() {
        addButton.addTarget(self, action: #selector(didAddItemToShoppingList), for: .touchUpInside)
    }
    
    @objc
    func didAddItemToShoppingList() {
        guard let name = nameTextField.text, !name.isEmpty,
              let priceText = priceTextField.text,
              !priceText.isEmpty,
              let price = Double(priceText),
              let selectedCategory = selectedCategory else {
            print("missing fields")
            return
        }
        let item = Items(name: name, price: price, category: selectedCategory)
        // use closure
        addItemsToShopListClosure?(item)
        // use delegate
        delegate?.didAddNewItem(self, item: item)
        dismiss(animated: true, completion: nil)
    }
}

extension AddItemViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // colum
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Category.allCases.count
    }
}

extension AddItemViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Category.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = Category.allCases[row]
    }
}
