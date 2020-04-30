//
//  CreateViewController.swift
//  photojournalApp
//
//  Created by Ahad Islam on 4/30/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit
import DataPersistence
import SnapKit
import Combine

class CreateViewController: CombineViewController {
    
    let persistence = DataPersistence<Page>(filename: "pages")
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person")
        iv.contentMode = .scaleAspectFill
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    private lazy var imagePicker: UIImagePickerController = {
        let ip = UIImagePickerController()
        ip.delegate = self
        return ip
    }()
    
    private lazy var tap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        return tap
    }()
    
    private lazy var textField: UITextField = {
        let tv = UITextField()
        tv.borderStyle = .roundedRect
        tv.placeholder = "Enter details here.."
        tv.delegate = self
        tv.font = tv.font?.withSize(17)
        tv.addTarget(self, action: #selector(textFieldEdit(_:)), for: .editingChanged)
        return tv
    }()
    
    private lazy var barButton: UIBarButtonItem = {
        let b = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(barButtonPressed))
        b.isEnabled = false
        return b
    }()
    
    private let hasImageSubject = PassthroughSubject<Bool, Never>()
    private let hasTextSubject = PassthroughSubject<Bool, Never>()
    
    var page: Page?
    
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(page: Page) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = page != nil ? "Edit Page" : "Create Page"
        navigationItem.rightBarButtonItem = barButton
        navigationController?.setToolbarHidden(true, animated: false)
        view.backgroundColor = .systemBackground
        updateUI()
        setupSubviews()
    }
    
    @objc private func imageTapped() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            self?.showPicker(sourceType: .camera)
        }
        let libraryAction = UIAlertAction(title: "Photo Library", style: .default) { [weak self] _ in
            self?.showPicker(sourceType: .photoLibrary)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(cameraAction)
        }
        
        alertController.addAction(libraryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    @objc private func barButtonPressed() {
        if var page = page, let image = imageView.image, let text = textField.text {
            page.imageData = image.jpegData(compressionQuality: 1.0)!
            page.text = text
            
            persistence.update(self.page!, with: page)
        } else if let data = imageView.image?.jpegData(compressionQuality: 1.0),
            let text = textField.text {
            let page = Page(imageData: data, text: text)
            do {
                try persistence.createItem(page)
            } catch {
                showMessage("Error", description: error.localizedDescription)
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func textFieldEdit(_ sender: UITextField) {
        hasTextSubject.send(sender.hasText)
    }
    
    private func updateUI() {
        hasImageSubject
            .combineLatest(hasTextSubject)
            .map { $0 && $1 }
            .assign(to: \.isEnabled, on: barButton)
            .store(in: &subscriptions)
    }
    
    private func setupSubviews() {
        setupImageView()
        setupTextView()
        
    }
    
    private func setupImageView() {
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.frame.height * 2 / 3)
        }
    }
    
    private func setupTextView() {
        view.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(imageView.snp.top)
        }
    }

}

extension CreateViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let originalImage = info[.originalImage] as? UIImage else {
            return
        }
        
        imageView.image = originalImage
        hasImageSubject.send(true)
        dismiss(animated: true, completion: nil)
    }
    
    private func showPicker(sourceType: UIImagePickerController.SourceType) {
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true)
    }
}

extension CreateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
