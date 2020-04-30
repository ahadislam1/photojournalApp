//
//  ViewController.swift
//  photojournalApp
//
//  Created by Ahad Islam on 4/30/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    private lazy var barButton: UIBarButtonItem = {
        let b = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        return b
    }()
    
    private lazy var items = [spaceButton, barButton, spaceButton]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setupNavigation()
    }
    
    private func setupNavigation() {
        navigationController?.setToolbarHidden(false, animated: false)
        toolbarItems = items
    }

}

