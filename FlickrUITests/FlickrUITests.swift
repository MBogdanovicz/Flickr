//
//  FlickrUITests.swift
//  FlickrUITests
//
//  Created by Marcelo Bogdanovicz on 19/07/19.
//  Copyright © 2019 Flickr. All rights reserved.
//

import XCTest

class FlickrUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {

        super.setUp()
        continueAfterFailure = false

        app = XCUIApplication()
    }

    func testInfo() {
        app.launch()
        
        let isDisplaying = app.otherElements["Home View"].exists
        XCTAssertTrue(isDisplaying)
    }
    
    func testSelection() {
        let firstChild = app.collectionViews.children(matching: .any).element(boundBy: 0)
        XCTAssertTrue(firstChild.waitForExistence(timeout: 10))

        firstChild.tap()
        let isInfoDisplaying = app.otherElements["Info View"].exists
        XCTAssertTrue(isInfoDisplaying)
        
        app.terminate()
    }
}
