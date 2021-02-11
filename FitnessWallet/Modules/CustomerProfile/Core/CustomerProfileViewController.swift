//
//  CustomerProfileViewController.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 21/01/2021.
//

import UIKit

final class CustomerProfileViewController: UIViewController {
    private enum Constants {
        static let paddingTen: CGFloat = 10.0
        static let paddingStackView: CGFloat = 32.0
        static let heightBackgroundView: CGFloat = 100.0
    }
    
    // MARK: - HeaderView
    private let profileImage = CustomImage(style: .profileCustomer)
    private let nameLabel = CustomLabel(style: .title)
    private let numberOfTrainigLabel = CustomLabel(style: .subtitle)
    private let numberOfPackageLabel = CustomLabel(style: .subtitle)
    
    // MARK: - Category Section
    private lazy var packageTrainingButton = CustomButtton(type: .system)
    private lazy var trainingListButton = CustomButtton(type: .system)
    private lazy var exercisesButton = CustomButtton(type: .system)
    private lazy var statInfoButton = CustomButtton(type: .system)
    
    private let backgroundView = UIView()
    private let sectionBackgroundView = UIView()
    private let textStackView = UIStackView()
    private let stackView = UIStackView()
    private let horizontalStackView = UIStackView()
    
    private var viewModel: CustomerProfileViewModelProtocol
    
    init(with viewModel: CustomerProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        createLayout()
        show(true)
        viewModel.showDataItem()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .default }
    
    private func setupButton() {
        [packageTrainingButton, trainingListButton, exercisesButton, statInfoButton].forEach {
            $0.layoutSubviews()
        }
        packageTrainingButton.setup(style: .packageTraining)
        packageTrainingButton.addTarget(self, action: #selector(handleTapPackage), for: .touchUpInside)
        trainingListButton.setup(style: .trainingList)
        trainingListButton.addTarget(self, action: #selector(handleTrainingList), for: .touchUpInside)
        exercisesButton.setup(style: .exercises)
        exercisesButton.addTarget(self, action: #selector(handleExercises), for: .touchUpInside)
        statInfoButton.setup(style: .statistic)
        statInfoButton.addTarget(self, action: #selector(handleStatInfo), for: .touchUpInside)
    }
    
    private func setupLabel() {
        backgroundView.backgroundColor = .white
        #warning("fix later, fetch data for numberOfTrainigLabel ")
        numberOfTrainigLabel.text = String( "treningów zostało: 8 / 12")
        updateLabel()
    }
    
    private func updateLabel() {
        viewModel.fetchDataClosure = { [weak self] data in
            guard let self = self else { return }
            guard let profileImageURL = URL(string: data.imageUrl) else { return }
            self.nameLabel.text = data.username
            self.profileImage.sd_setImage(with: profileImageURL)
            self.profileImage.clipsToBounds = true
        }
    }
}


extension CustomerProfileViewController {
    @objc
    private func handleTapPackage() {
        show(true)
    }
    
    func show(_ state: Bool? = false) {
        if packageTrainingButton.isEnabled == state {
            viewModel.showPackageViewControllerClosure = { [weak self] viewController in
                self?.sectionBackgroundView.addSubview(viewController)
                viewController.anchor(top: self?.sectionBackgroundView.topAnchor,
                                      left: self?.sectionBackgroundView.leftAnchor,
                                      bottom: self?.sectionBackgroundView.bottomAnchor,
                                      right: self?.sectionBackgroundView.rightAnchor)
            }
        }
        packageTrainingButton.isEnabled = false
    }
    
    @objc
    private func handleTrainingList() {
        print("DEBUG: handlde training list")
    }
    
    @objc
    private func handleExercises() {
        print("DEBUG: handle exercsies")
    }
    
    @objc
    private func handleStatInfo() {
        print("DEBUG: handle stat info ")
    }
}

extension CustomerProfileViewController {
    private func createLayout() {
        [profileImage, nameLabel, backgroundView, numberOfTrainigLabel, numberOfPackageLabel].forEach { view.addSubview($0)}
        [nameLabel, numberOfTrainigLabel, numberOfPackageLabel].forEach { textStackView.addArrangedSubview($0) }
        textStackView.axis = .vertical
        [profileImage, textStackView].forEach { horizontalStackView.addArrangedSubview($0)}
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = CGFloat(StringRepresentationOfDigit.twenty)
        view.addSubview(horizontalStackView)
        horizontalStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                   left: view.safeAreaLayoutGuide.leftAnchor,
                                   right: view.safeAreaLayoutGuide.rightAnchor,
                                   paddingTop: CGFloat(StringRepresentationOfDigit.six),
                                   paddingLeft: Constants.paddingStackView,
                                   paddingRight: Constants.paddingStackView)
        view.addSubview(backgroundView)
        backgroundView.addSubview(stackView)
        backgroundView.setHeight(Constants.heightBackgroundView)
        backgroundView.anchor(top: horizontalStackView.bottomAnchor,
                              left: view.safeAreaLayoutGuide.leftAnchor,
                              right: view.safeAreaLayoutGuide.rightAnchor,
                              paddingTop: CGFloat(StringRepresentationOfDigit.twenty),
                              paddingLeft: CGFloat(StringRepresentationOfDigit.sixteen),
                              paddingRight: CGFloat(StringRepresentationOfDigit.sixteen))
        backgroundView.layer.addShadow(type: .iconButton)
        [packageTrainingButton, trainingListButton, exercisesButton, statInfoButton].forEach { stackView.addArrangedSubview($0)
        }
        stackView.axis = .horizontal
        stackView.spacing = CGFloat(StringRepresentationOfDigit.twenty)
        stackView.alignment = .center
        stackView.centerX(inView: backgroundView)
        stackView.centerY(inView: backgroundView)
        
        view.addSubview(sectionBackgroundView)
        sectionBackgroundView.backgroundColor = .whiteAlphaTf
        sectionBackgroundView.layer.addShadow(type: .iconButton)
        sectionBackgroundView.anchor(top: backgroundView.bottomAnchor,
                                     left: view.safeAreaLayoutGuide.leftAnchor,
                                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     right: view.safeAreaLayoutGuide.rightAnchor,
                                     paddingTop: CGFloat(StringRepresentationOfDigit.ten),
                                     paddingLeft: CGFloat(StringRepresentationOfDigit.eight),
                                     paddingBottom: CGFloat(StringRepresentationOfDigit.eight),
                                     paddingRight: CGFloat(StringRepresentationOfDigit.eight))
        setupLabel()
        setupButton()
    }
}

extension CustomerProfileViewController: CustomerProfileViewModelDelegate {}
