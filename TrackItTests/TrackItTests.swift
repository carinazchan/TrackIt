//
//  TrackItTests.swift
//  TrackItTests
//
//  Created by Arian Tajvar on 2/26/24.
//

import XCTest
@testable import TrackIt

final class TrackItTests: XCTestCase {

    func testViewControllerIsNotNil() {
        // Given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        
        // Then
        XCTAssertNotNil(viewController, "View controller should not be nil")
    }

    func testSceneDelegateHasWindowProperty() {
        // Given
        let sceneDelegate = SceneDelegate()
        
        // Then
        XCTAssertNotNil(sceneDelegate.window, "Scene delegate should have a window property")
    }

    func testAppDelegateConformsToUIApplicationDelegateProtocol() {
        XCTAssertTrue(AppDelegate.self.conforms(to: UIApplicationDelegate.self), "AppDelegate should conform to UIApplicationDelegate protocol")
    }

    func testAppDelegateWindowIsNotNil() {
        // Given
        let appDelegate = AppDelegate()
        
        // Then
        XCTAssertNotNil(appDelegate.window, "App delegate should have a window property")
    }


    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
