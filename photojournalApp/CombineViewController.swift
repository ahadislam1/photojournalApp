//
//  CombineViewController.swift
//  photojournalApp
//
//  Created by Ahad Islam on 4/30/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit
import Combine

/// A class that inherits UIViewController to host useful combine features
class CombineViewController: UIViewController {
    
    /// A place to store subscriber's subscriptions.
    var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
