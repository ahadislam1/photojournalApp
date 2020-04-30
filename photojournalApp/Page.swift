//
//  Page.swift
//  photojournalApp
//
//  Created by Ahad Islam on 4/30/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import Foundation

struct Page: Codable, Equatable {
    let id: String
    let date = Date()
    var imageData: Data
    var text: String
    
    init(imageData: Data, text: String) {
        id = UUID().uuidString
        self.imageData = imageData
        self.text = text
    }
    
    static func == (lhs: Page, rhs: Page) -> Bool {
        lhs.id == rhs.id
    }
    
}
