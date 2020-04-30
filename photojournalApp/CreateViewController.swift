//
//  CreateViewController.swift
//  photojournalApp
//
//  Created by Ahad Islam on 4/30/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit
import DataPersistence

class CreateViewController: CombineViewController {
    
    var page: Page?
    
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
        // Do any additional setup after loading the view.
    }

}
