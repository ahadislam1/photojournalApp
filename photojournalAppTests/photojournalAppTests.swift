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
        var page2 = page
        page2.text = "Something's wrong..."
        XCTAssertNotEqual(id, page.id)
        let newId = page.id
        XCTAssertEqual(newId, page.id)
        XCTAssert(page == page2)
    }

}
