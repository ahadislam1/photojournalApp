//
//  photojournalAppTests.swift
//  photojournalAppTests
//
//  Created by Ahad Islam on 4/30/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import XCTest
@testable import photojournalApp

class photojournalAppTests: XCTestCase {

    func testEquality() {
        let id = UUID().uuidString
        let page = Page(imageData: Data(), text: "OK")
        XCTAssertNotEqual(id, page.id)
        let newId = page.id
        XCTAssertEqual(newId, page.id)
    }

}
