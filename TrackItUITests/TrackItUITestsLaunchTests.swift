//
//  TrackItUITestsLaunchTests.swift
//  TrackItUITests
//
//  Created by Arian Tajvar on 2/26/24.
//

import XCTest

final class TrackItUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    func testContentViewLayout() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Verify that the ContentView layout appears correctly
        XCTAssertTrue(app.staticTexts["Dashboard"].exists)
        XCTAssertTrue(app.staticTexts["Welcome back, John Doe!"].exists)
        // Add more assertions to check other UI elements as needed
    }

    func testNavigationLinks() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Tap on navigation links and verify navigation
        app.buttons["Map View"].tap()
        XCTAssertTrue(app.staticTexts["Map View"].exists)

        // Tap on other navigation links and verify navigation similarly
    }

    func testBudgetItemView() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Verify the BudgetItemView displays correct data
        XCTAssertTrue(app.staticTexts["Food"].exists)
        XCTAssertTrue(app.staticTexts["$500"].exists)
        XCTAssertTrue(app.staticTexts["$400"].exists)

        // Add assertions to check other BudgetItemView instances similarly
    }

    func testTransactionRowView() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Verify the TransactionRowView displays correct data
        XCTAssertTrue(app.staticTexts["Target"].exists)
        XCTAssertTrue(app.staticTexts["-$50"].exists)

        // Add assertions to check other TransactionRowView instances similarly
    }

    func testNavigationBarView() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Tap on each navigation link and verify navigation
        app.buttons["Home"].tap()
        XCTAssertTrue(app.staticTexts["Dashboard"].exists)

        // Tap on other navigation links and verify navigation similarly
    }
}
