// MooviesUITests.swift
// Copyright © Vera Malygina. All rights reserved.

import Foundation
import XCTest
///
class MainScreenTests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testSegmentControl() throws {
        let app = XCUIApplication()

        app.segmentedControls.buttons["Популярные"].tap()
        app.segmentedControls.buttons["Топ-100"].tap()
        app.segmentedControls.buttons["Скоро"].tap()

        if app.segmentedControls.buttons["Популярные"].isSelected {
            XCTAssertTrue(app.segmentedControls.buttons["Скоро"].isSelected == false)
            XCTAssertFalse(app.segmentedControls.buttons["Скоро"].isSelected == true)
        }
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
