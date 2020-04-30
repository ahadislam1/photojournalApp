//
//  ViewController.swift
//  photojournalApp
//
//  Created by Ahad Islam on 4/30/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit
import DataPersistence
import SnapKit

class ViewController: CombineViewController {
    
    let persistence = DataPersistence<Page>(filename: "pages")
    
    private var pages = [Page]()
    
    private lazy var spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    private lazy var barButton: UIBarButtonItem = {
        let b = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(barButtonPressed))
        return b
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(JournalViewCell.self, forCellWithReuseIdentifier: "journalCell")
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .systemGroupedBackground
        return cv
    }()
    
    private lazy var items = [spaceButton, barButton, spaceButton]
                
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigation()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    @objc
    private func barButtonPressed() {
        navigationController?.pushViewController(CreateViewController(), animated: true)
    }
    
    private func loadData() {
        do {
           pages = try persistence.loadItems()
        } catch {
            showMessage("Error", description: error.localizedDescription)
        }
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        toolbarItems = items
        title = "Photojournal"
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "journalCell", for: indexPath) as? JournalViewCell else {
            return UICollectionViewCell()
        }
        //TODO: Configure cell, store subscriber for cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: view.frame.height / 2)
    }
    
}
