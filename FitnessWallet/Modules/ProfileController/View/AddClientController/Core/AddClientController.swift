//
//  AddClientController.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 11/01/2021.
//

import UIKit

final class AddClientController: UIViewController {
    private enum Constants {
        static let setWidth: CGFloat = 0.5
        static let photoImageWidth: CGFloat = 140.0
        static let photoImageHeight: CGFloat = 140.0
        static let textViewHeight: CGFloat = 50.0
        static let textViewWidth: CGFloat = 300
    }
    
    private lazy var userTextView = InputView()
    private lazy var surnameTextView = InputView()
    private lazy var weightTextView = InputView()
    private lazy var heightTextView = InputView()
    private let photoAddButton = UIButton()
    private var photoImageView: UIImage?
    private lazy var confirmButton = RoundedButton()
    private let contentStackView = UIStackView()
    private let contentscrollView = UIScrollView()
    
    var viewModel: AddClientViewModelProtocol
    
    init(with viewModel: AddClientViewModelProtocol) {
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
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .default }
    
    @objc
    func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupLayout() {
        
        setupLabel()
        setupButton()
        view.backgroundColor = .white
        
        // MARK: - ImageView
        [photoAddButton,contentscrollView, confirmButton].forEach { view.addSubview($0)}
        photoAddButton.centerX(inView: view)
        photoAddButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              paddingTop: CGFloat(StringRepresentationOfDigit.thirty))
        // MARK: - ScrollView
        contentscrollView.addSubview(contentStackView)
        contentscrollView.alwaysBounceVertical = true
        contentscrollView.indicatorStyle = .black
        contentscrollView.isScrollEnabled = true
        contentscrollView.adjustedContentInsetDidChange()
        contentscrollView.anchor(top: photoAddButton.bottomAnchor,
                                left: view.safeAreaLayoutGuide.leftAnchor,
                                right: view.safeAreaLayoutGuide.rightAnchor,
                                paddingTop: CGFloat(StringRepresentationOfDigit.thirty))
        
        // MARK: - Content StackView
        [userTextView,surnameTextView, weightTextView, heightTextView].forEach {
            contentStackView.addArrangedSubview($0)
            $0.setDimensions(height: Constants.textViewHeight, width: Constants.textViewWidth)
        }
        contentStackView.axis = .vertical
        contentStackView.spacing = CGFloat(StringRepresentationOfDigit.thirty)
        contentStackView.distribution = .fillEqually
        contentStackView.anchor(top: contentscrollView.topAnchor,
                                left: contentscrollView.leftAnchor,
                                right: contentscrollView.rightAnchor,
                                paddingTop: CGFloat(StringRepresentationOfDigit.ten),
                                paddingLeft: CGFloat(StringRepresentationOfDigit.sixteen),
                                paddingRight: CGFloat(StringRepresentationOfDigit.sixteen))
        confirmButton.anchor(top: contentscrollView.bottomAnchor,
                            left: view.safeAreaLayoutGuide.leftAnchor,
                             bottom: view.safeAreaLayoutGuide.bottomAnchor,
                             right: view.safeAreaLayoutGuide.rightAnchor,
                             paddingTop: CGFloat(StringRepresentationOfDigit.twelve),
                             paddingLeft: CGFloat(StringRepresentationOfDigit.sixteen),
                             paddingBottom: CGFloat(StringRepresentationOfDigit.twenty),
                             paddingRight: CGFloat(StringRepresentationOfDigit.sixteen))
    }
    
    private func setupLabel() {
        
        userTextView.update(renderable: viewModel.usernameRenderable )
        userTextView.isEmptyClosure = viewModel.isInputEmpty
        surnameTextView.update(renderable: viewModel.surnameRenderable)
        surnameTextView.isEmptyClosure = viewModel.isInputEmpty
        weightTextView.update(renderable: viewModel.weightRenderable)
        weightTextView.isEmptyClosure = viewModel.isInputEmpty
        heightTextView.update(renderable: viewModel.heightRenderable)
        heightTextView.isEmptyClosure = viewModel.isInputEmpty
        weightTextView.setupKeyboard(.numbersAndPunctuation)
        heightTextView.setupKeyboard(.numbersAndPunctuation)
    }
    
    private func setupButton() {
        photoAddButton.setDimensions(height: Constants.photoImageHeight, width: Constants.photoImageWidth)
        photoAddButton.layer.borderColor = UIColor.blueDark.cgColor
        photoAddButton.layer.borderWidth = CGFloat(StringRepresentationOfDigit.one)
        photoAddButton.layer.cornerRadius = 12.0
        photoAddButton.layer.addShadow(type: .alert)
        photoAddButton.addTarget(self, action: #selector(handleProfilePhotoSelect), for: .touchUpInside)
        photoAddButton.setImage(UIImage(named:Asset.upload_image_icon.name), for: .normal)
        confirmButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        confirmButton.setup(title: viewModel.buttonTitle, style: .acceptBottom)
        BorderLayer.instantiate(view: confirmButton,
                                lineWidth: Constants.setWidth,
                                strokeColor: .lineConnecting,
                                borders: .top)
    }
    
    @objc
    private func handleProfilePhotoSelect() {
     let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    @objc
    private func didTap() {
        viewModel.didTapDone(selectedImage: photoImageView,
                             username: userTextView.text,
                             surname: surnameTextView.text,
                             weight: Double(weightTextView.text ?? .empty),
                             height: Double(heightTextView.text ?? .empty))
    }

}

extension AddClientController: AddClientViewModelDelegate {
    func showLoading(_ state: Bool) {
        showLoader(state)
    }
    
    func alertMessage(title: String, message: String) {
        showMessage(withTitle: title, message: message)
    }
    
    func updateForm() {
        if userTextView.text!.isEmpty &&
            surnameTextView.text!.isEmpty &&
            weightTextView.text!.isEmpty &&
            heightTextView.text?.isEmpty == false {
//            confirmButton.isEnabled = viewModelAuthentication.formIsValid == true
        } else {
            //confirmButton.isEnabled = viewModelAuthentication.formIsValid == false
        }
    }
}

extension AddClientController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
//        viewModel.checkMaxLegnth(textView)
//        let count = textView.text.count
//        characterCountLabel.text = "\(count)/\(StringRepresentationOfDigit.twenty)"
    }
}

extension AddClientController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        photoImageView = selectedImage
        photoAddButton.layer.cornerRadius = 140 / 2
        photoAddButton.layer.addShadow(type: .alert)
        photoAddButton.layer.masksToBounds = true
        photoAddButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
}
