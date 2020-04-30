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

    /// Presents an alert controller with a given title and optional description.
    public func showMessage(_ title: String, description: String? = nil) {
        alert(title: title, text: description)
            .sink(receiveValue: { _ in })
            .store(in: &subscriptions)
    }
    
    private func alert(title: String, text: String?) -> AnyPublisher<Void, Never> {
      let alertVC = UIAlertController(title: title,
                                      message: text,
                                      preferredStyle: .alert)

      return Future { resolve in
        alertVC.addAction(UIAlertAction(title: "OK",
                                        style: .default) { _ in
          resolve(.success(()))
        })

        self.present(alertVC, animated: true, completion: nil)
      }
      .handleEvents(receiveCancel: {
        self.dismiss(animated: true)
      })
      .eraseToAnyPublisher()
    }
    
}
