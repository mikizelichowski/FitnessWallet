//
//  AddNewPackageController.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 26/01/2021.
//

import UIKit

final class AddNewPackageController: UIViewController {
    private enum Constants {
        static let lineWidth: CGFloat = 0.5
        static let textSetHeight: CGFloat = 50.0
        static let textSetWidth: CGFloat = 300.0
        static let cardBackgroundViewHeight: CGFloat = 200.0
    }
    
    private let cardView = CardView()
    private let contentBackgroundView = UIView()
    private let contentScrollView = UIScrollView()
    private let contentStackView = UIStackView()
    private lazy var titlePackageTextView = InputView()
    private lazy var numberOfTrainingsTextView = InputView()
    private lazy var confirmButton = RoundedButton()
    
    private var viewModel: AddNewPackageViewModelProtocol!
    
    init(with viewModel: AddNewPackageViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        setupNavigationController(false)
    }
    
    private func setupLabel() {
        
        titlePackageTextView.update(renderable: viewModel.titlePackageRenderable)
        titlePackageTextView.isEmptyClosure = viewModel.isInputEmpty
        numberOfTrainingsTextView.update(renderable: viewModel.numberOfTrainingsRenderable)
        numberOfTrainingsTextView.isEmptyClosure = viewModel.isInputEmpty
        numberOfTrainingsTextView.setupKeyboard(.numbersAndPunctuation)
    }
    
    private func setupButton() {
        confirmButton.setup(title: viewModel.buttonTitle, style: .acceptBottom)
        confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        BorderLayer.instantiate(view: confirmButton, lineWidth: Constants.lineWidth, strokeColor: .lineConnecting, borders: .top)
    }
    
    @objc
    private func didTapConfirmButton() {
        viewModel.didTapConfirm(title: titlePackageTextView.text, numberOfTrainings: Double(numberOfTrainingsTextView.text ?? .empty))
    }
}

extension AddNewPackageController {
    private func setupLayout() {
        setupLabel()
        setupButton()
        view.backgroundColor = .white
        view.addSubview(cardView)
        cardView.anchor(top: view.topAnchor,
                        left: view.leftAnchor,
                        right: view.rightAnchor)
        cardView.setHeight(Constants.cardBackgroundViewHeight)
        cardView.layer.addShadow(type: .iconButton)
        view.addSubview(contentBackgroundView)
        contentBackgroundView.backgroundColor = .white
        contentBackgroundView.layer.addShadow(type: .iconButton)
        contentBackgroundView.anchor(top: cardView.bottomAnchor,
                                     left: view.leftAnchor,
                                     bottom: view.bottomAnchor,
                                     right: view.rightAnchor,
                                     paddingTop: CGFloat(StringRepresentationOfDigit.twenty))
        
        // MARK: - Content ScrollView
        [contentScrollView, confirmButton].forEach { contentBackgroundView.addSubview($0)}
        contentScrollView.addSubview(contentStackView)
        contentScrollView.alwaysBounceVertical = true
        contentScrollView.indicatorStyle = .black
        contentScrollView.isScrollEnabled = true
        contentScrollView.adjustedContentInsetDidChange()
        contentScrollView.anchor(top: contentBackgroundView.topAnchor,
                                 left: contentBackgroundView.leftAnchor,
                                 bottom: contentBackgroundView.bottomAnchor,
                                 right: contentBackgroundView.rightAnchor,
                                 paddingTop: CGFloat(StringRepresentationOfDigit.sixty))
        
        // MARK: - Content StackView
        [titlePackageTextView, numberOfTrainingsTextView].forEach { contentStackView.addArrangedSubview($0)
            $0.setDimensions(height: Constants.textSetHeight, width: Constants.textSetWidth)}
        contentStackView.axis = .vertical
        contentStackView.spacing = CGFloat(StringRepresentationOfDigit.thirty)
        contentStackView.distribution = .fillEqually
        contentStackView.anchor(top: contentScrollView.topAnchor,
                                left: contentScrollView.leftAnchor,
                                right: contentScrollView.rightAnchor,
                                paddingTop: CGFloat(StringRepresentationOfDigit.ten),
                                paddingLeft: CGFloat(StringRepresentationOfDigit.sixteen),
                                paddingRight: CGFloat(StringRepresentationOfDigit.sixteen))
        confirmButton.anchor(top: contentScrollView.bottomAnchor,
                             left: contentBackgroundView.leftAnchor,
                             bottom: contentBackgroundView.bottomAnchor,
                             right: contentBackgroundView.rightAnchor,
                             paddingTop: CGFloat(StringRepresentationOfDigit.twelve),
                             paddingLeft: CGFloat(StringRepresentationOfDigit.sixteen),
                             paddingBottom: CGFloat(StringRepresentationOfDigit.sixty),
                             paddingRight: CGFloat(StringRepresentationOfDigit.sixteen))
    }
}

extension AddNewPackageController: AddNewPackageViewModelDelegate {
    func action(action: ActionAddPackage) {
        switch action {
        case .showLoading(state: let state):
            showLoader(state)
        case .alertMessage(title: let title, message: let message):
            showMessage(withTitle: title, message: message, completion: nil)
        case .updateView(state: let state):
            if state == true {
                titlePackageTextView.text = .empty
                numberOfTrainingsTextView.text = .empty
            }
        }
    }
}
