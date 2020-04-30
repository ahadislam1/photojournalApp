//
//  photojournalAppTests.swift
//  photojournalAppTests
//
//  Created by Ahad Islam on 4/30/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import XCTest
import DataPersistence
@testable import photojournalApp

class photojournalAppTests: XCTestCase {
    
    let persistence = DataPersistence<Page>(filename: "pages")

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
    
    func testLoad() {
        var something: [Page]? = nil
        do {
            something = try persistence.loadItems()
        } catch {
            XCTFail("failure")
        }
        XCTAssertNotNil(something)
    }
    
    func testDeleteAll() {
        persistence.removeAll()
        var x = [Page]()
        do {
            x = try persistence.loadItems()
        } catch {
            XCTFail("failure")
        }
        XCTAssert(x.count == 0)
    }

}
