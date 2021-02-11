//
//  AddItemViewController.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 19/01/2021.
//

#warning("TEST - Delete !")

import UIKit

protocol AddItemViewControllerDelegate: AnyObject {
    func didAddNewItem(_ addItemViewController: AddItemViewController, item: Items)
}

class AddItemViewController: UIViewController {
    private enum Constants {
        static let placeholderTitle = "Add new item"
        static let buttonTitle = "Add Item to Training List"
        static let padding32: CGFloat = 32.0
        static let heightTf: CGFloat = 80.0
        static let heicghtPickerView: CGFloat = 200.0
        static let paddingFifty: CGFloat = 50.0
    }
    
    private let addButton = UIButton()
    private let nameTextField = UITextField()
    private let priceTextField = UITextField()
    private let pickerView = UIPickerView()
    
    weak var delegate: AddItemViewControllerDelegate?
    var addItemsToShopListClosure: ((Items) -> ())?
    
    private var selectedCategory: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        pickerView.dataSource = self
        pickerView.delegate = self
        selectedCategory = Category.allCases.first
        setupUI()
    }
    
    private func setupUI() {
        [nameTextField, priceTextField].forEach {
            $0.placeholder = Constants.placeholderTitle
            $0.textColor = .white
            $0.layer.cornerRadius = CGFloat(StringRepresentationOfDigit.four)
            $0.layer.borderWidth = CGFloat(StringRepresentationOfDigit.one)
            $0.layer.borderColor = UIColor.black.cgColor
        }
        addButton.setTitle(Constants.buttonTitle, for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.isUserInteractionEnabled = true
        
        [nameTextField, priceTextField, addButton, pickerView].forEach { view.addSubview($0)}
        addButton.addTarget(self, action: #selector(didAddItemToShoppingList), for: .touchUpInside)
        nameTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                             left: view.safeAreaLayoutGuide.leftAnchor,
                             right: view.safeAreaLayoutGuide.rightAnchor,
                             paddingTop: Constants.padding32,
                             paddingLeft: Constants.padding32,
                             paddingRight: Constants.padding32,
                             height: Constants.heightTf)
        priceTextField.anchor(top: nameTextField.bottomAnchor,
                              left: view.safeAreaLayoutGuide.leftAnchor,
                              right: view.safeAreaLayoutGuide.rightAnchor,
                              paddingTop: CGFloat(StringRepresentationOfDigit.twenty),
                              paddingLeft: Constants.padding32,
                              paddingRight: Constants.padding32,
                              height: Constants.heightTf)
        addButton.anchor(top: priceTextField.bottomAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor,
                         paddingTop: Constants.paddingFifty,
                         paddingLeft: Constants.padding32,
                         paddingRight: Constants.padding32,
                         height: Constants.heightTf)
        pickerView.anchor(left: view.safeAreaLayoutGuide.leftAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          right: view.safeAreaLayoutGuide.rightAnchor,
                          height: Constants.heicghtPickerView)
    }
    
    @objc
    func didAddItemToShoppingList() {
        guard let name = nameTextField.text, !name.isEmpty,
              let reps = priceTextField.text, !reps.isEmpty,
              let priceText = priceTextField.text,
              !priceText.isEmpty,
              let repsString = Int(reps),
              let price = Double(priceText),
              let selectedCategory = selectedCategory else {
            print("missing fields")
            return
        }
        let item = Items(name: name, reps: repsString, price: price, category: selectedCategory)
        // use closure
        addItemsToShopListClosure?(item)
        // use delegate
        delegate?.didAddNewItem(self, item: item)
        dismiss(animated: true, completion: nil)
    }
}

extension AddItemViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
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
