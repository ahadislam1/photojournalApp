//
//  CreateViewController.swift
//  photojournalApp
//
//  Created by Ahad Islam on 4/30/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit
import DataPersistence
import Combine

class CreateViewController: CombineViewController {
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person3")
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
        let tap = UITapGestureRecognizer(target: nil, action: nil)
        return tap
    }()
    
    private lazy var textView: UITextView = {
        let tv = UITextView()
        tv.delegate = self
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
        updateUI()
    }
    
    @objc private func imageTapped() {
        //TODO: Present picker
    }
    
    @objc private func barButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    private func updateUI() {
        hasImageSubject
            .combineLatest(hasTextSubject)
            .map { $0 && $1 }
            .assign(to: \.isEnabled, on: barButton)
            .store(in: &subscriptions)
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
}

extension CreateViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        hasTextSubject.send(textView.hasText)
        print(text)
        return false
    }
}
