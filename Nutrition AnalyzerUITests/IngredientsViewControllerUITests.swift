//
//  Nutrition_AnalyzerUITests.swift
//  Nutrition AnalyzerUITests
//
//  Created by Mahmoud Eissa on 6/1/21.
//

import XCTest

class IngredientsViewControllerUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }
    
    func testAnalizeButtonStatus() {
        XCTAssertTrue(app.buttons["analyize-button"].exists)
        XCTAssertTrue(app.textViews["input-textView"].exists)
        XCTAssertFalse(app.buttons["analyize-button"].isEnabled)
        app.textViews["input-textView"].tap()
        app.textViews["input-textView"].typeText("1 Apple")
        XCTAssertTrue(app.buttons["analyize-button"].isEnabled)
        app.textViews["input-textView"].clear()
        XCTAssertFalse(app.buttons["analyize-button"].isEnabled)
    }
    
    func testActivityIndicatorViewWillShow() {
        app.textViews["input-textView"].tap()
        app.textViews["input-textView"].typeText("1 Apple")
        XCUIApplication().toolbars.buttons["Done"].tap()
        app.buttons["analyize-button"].tap()
        XCTAssertTrue(app.activityIndicators.element.exists)
    }
    
    func testActivityIndicatorViewWillHideOnSuccess() {
        app.textViews["input-textView"].tap()
        app.textViews["input-textView"].typeText("1 Apple")
        XCUIApplication().toolbars.buttons["Done"].tap()
        app.buttons["analyize-button"].tap()
        expectation(for: .init(format: "exists == false"),
                    evaluatedWith: app.activityIndicators.element, handler: nil)
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    func testActivityIndicatorViewWillHideOnFailure() {
        app.textViews["input-textView"].tap()
        app.textViews["input-textView"].typeText(".....")
        XCUIApplication().toolbars.buttons["Done"].tap()
        app.buttons["analyize-button"].tap()
        expectation(for: .init(format: "exists == false"),
                    evaluatedWith: app.activityIndicators.element, handler: nil)
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    func testAlertViewControllerWillShowOnFailure() {
        app.textViews["input-textView"].tap()
        app.textViews["input-textView"].typeText(".....")
        XCUIApplication().toolbars.buttons["Done"].tap()
        app.buttons["analyize-button"].tap()
        expectation(for: .init(format: "exists == true"),
                    evaluatedWith: app.alerts.element, handler: nil)
        waitForExpectations(timeout: 60, handler: nil)
    }
    
}
extension XCUIElement {
    func clear() {
        guard let value = self.value as? String else {
            XCTFail("Tried to clear into a non string value")
            return
        }
        
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue,
                                  count: value.count)
        typeText(deleteString)
    }
}
