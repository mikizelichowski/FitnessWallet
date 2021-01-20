//
//  InformationAlertController.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 09/01/2021.
//

// ustawic layouty alertu
// stworzyc przykladowy view alert z ITem jak jest w przykladzie Blik
// alert helper stworzyc pozniej

import UIKit

final class InformationAlertController: UIViewController {
    private enum Constants {
        static let contentViewSize = CGSize(width: 270, height: 408)
        static let contentViewSizeConfirmation = CGSize(width: 270, height: 197)
        static let cornerRadius: CGFloat = 4.0
    }
    
    private let backgroundView = UIView()
    private let contentView = UIView()
    private let contentStackView = UIStackView()
    private let iconImageView = CustomImage(style: .categories)
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let buttonStackView = UIStackView()
    private var confirmButton = RoundedButton()
    private var cancelButton = RoundedButton()
    private let contentViewBottomConstraint = NSLayoutConstraint()
    
    private let indicatorActivity = UIActivityIndicatorView()
    
    private var viewModel: InformationControllerViewModelProtocol
    
    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchTap))
    
    init(with viewModel: InformationControllerViewModelProtocol) {
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
    
    private func setupLayout() {
        view.backgroundColor = .clear
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = Constants.cornerRadius
        contentView.backgroundColor = .white
        contentView.layer.addShadow(type: .alert)
        backgroundView.backgroundColor = .alertBackground
        indicatorActivity.isHidden = !viewModel.replaceImageToIndicator
        if viewModel.replaceImageToIndicator {
            indicatorActivity.style = .large
            indicatorActivity.startAnimating()
        }
        
        backgroundView.fillSuperView()
        view.addSubview(backgroundView)
        backgroundView.addSubview(contentView)
        contentView.anchor(top: backgroundView.topAnchor,
                           left: backgroundView.leftAnchor,
                           bottom: backgroundView.bottomAnchor,
                           right: backgroundView.rightAnchor,
                           paddingTop: 100,
                           paddingLeft: 32,
                           paddingBottom: 100,
                           paddingRight: 32)
        contentView.layer.addShadow(type: .alert)
        [contentStackView, buttonStackView].forEach{ contentView.addSubview($0)}
        [iconImageView, indicatorActivity, titleLabel, descriptionLabel].forEach{ contentStackView.addArrangedSubview($0)}
        [confirmButton, cancelButton].forEach{ buttonStackView.addArrangedSubview($0)}
        setupStackView()
    }
    
    private func setupStackView() {
        contentStackView.axis = .vertical
        contentStackView.spacing = 5
        contentStackView.anchor(top: contentView.topAnchor,
                                left: contentView.leftAnchor,
                                right: contentView.rightAnchor)
        buttonStackView.anchor(top: contentStackView.bottomAnchor,
                               left: contentView.leftAnchor,
                               bottom: contentView.bottomAnchor,
                               right: contentView.rightAnchor,
                               paddingTop: 20,
                               paddingBottom: 20)
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 5
        confirmButton.setHeight(44)
        cancelButton.setHeight(44)
    }
    
    private func setupTexts() {
        iconImageView.image = viewModel.alertIcon?.image
        iconImageView.isHidden = viewModel.alertIcon == nil
        
        titleLabel.text = viewModel.alertTitle
        titleLabel.textColor = .blueDark
        titleLabel.font = .font(with: .bold, size: .bigMedium)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = .zero
        
        descriptionLabel.text = viewModel.alertDescription
        descriptionLabel.textColor = .blueDark
        descriptionLabel.font = .font(with: .regular, size: .smallerMedium)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = .zero
        
        confirmButton.isHidden = viewModel.confirmButtonTitle == nil
        confirmButton.setup(title: viewModel.confirmButtonTitle ?? .empty, style: .acceptBottom)
        cancelButton.isHidden = viewModel.cancelButtonTitle == nil
        cancelButton.setup(title: viewModel.cancelButtonTitle ?? .empty , style: .cancelBottom)
        
        confirmButton.addTarget(self, action: #selector(confirmButtonTap), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTap), for: .touchUpInside)
    }
    
    private func setupStyle() {
        if viewModel.tapGestureRecognizer {
            view.addGestureRecognizer(tapGesture)
        }
        
        switch viewModel.alertStyle {
        case .success:
            setupBoilerplateStyle(color: .green)
        case .failure:
            setupBoilerplateStyle(color: .red)
        case .confirmation:
            setupConfirmationAlert()
            setupBoilerplateStyle()
        case .Informational:
            setupLoginInformationAlert()
            setupBoilerplateStyle()
        case .simpleText:
            setupBoilerplateStyle()
        case .resetPassword:
            break
        }
        
        guard viewModel.confirmButtonTitle != nil ||
                viewModel.cancelButtonTitle != nil else {
            contentViewBottomConstraint.constant = .zero
            return
        }
    }
    
    private func setupBoilerplateStyle(color: UIColor? = .blueDark) {
        iconImageView.tintColor = color
        titleLabel.textColor = color
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ contentView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    private func setupLoginInformationAlert() {
        contentView.subviews.forEach { $0.removeFromSuperview()}
        let loginView = LoginInformationAlert()
        loginView.updateView(buttonTitle: viewModel.alertTitle, imageView: Asset.infoImage, buttonTapClosure: viewModel.cancelDidTap)
        contentView.addSubview(loginView)
        loginView.fillSuperViewArea()
    }
    
    private func setupConfirmationAlert() {
        contentView.subviews.forEach { $0.removeFromSuperview()}
        let confiramtionAlert = ConfirmationAlert()
        confiramtionAlert.updateView(buttonTitle: viewModel.cancelButtonTitle ?? .empty, imageView: Asset.infoImage, titleText: viewModel.alertTitle, descriptionText: viewModel.alertDescription, buttonTapClosure: viewModel.cancelDidTap)
        contentView.addSubview(confiramtionAlert)
        confiramtionAlert.fillSuperViewArea()
    }
    
    @objc
    func touchTap() {
        dismiss(animated: false) {
            self.viewModel.touchDidTap()
        }
    }
    
    @objc
    func confirmButtonTap() {
        dismiss(animated: false) {
            self.viewModel.confirmDidTap()
        }
    }
    
    @objc
    func cancelButtonTap() {
        dismiss(animated: false) {
            self.viewModel.cancelDidTap()
        }
    }
}

extension InformationAlertController: InformationAlertControllerViewModelDelegate {}
