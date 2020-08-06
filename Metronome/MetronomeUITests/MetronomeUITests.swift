//
//  MetronomeUITests.swift
//  MetronomeUITests
//
//  Created by akrolayer on 2020/07/31.
//  Copyright © 2020 akrolayer. All rights reserved.
//

import XCTest

class MetronomeUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
//        let bpmTextField = app.textFields["bpmTextBox"]
//        bpmTextField.tap()
//
//        //XCUIApplication().pickerWheels["picker"].adjust(toPickerWheelValue: "130")
//
//        let firstPredicate = NSPredicate(format: "label BEGINSWITH 'PickerWheel'")
//        let firstPicker = app.pickerWheels.element(matching: firstPredicate)
//        firstPicker.adjust(toPickerWheelValue: "123")
//        let secondPredicate = NSPredicate(format: "label BEGINSWITH 'PickerWheel")
//        let secondPicker = app.pickerWheels.element(matching: secondPredicate)
//        secondPicker.adjust(toPickerWheelValue: "16")
//
//        app.buttons["done"].tap()
//
//        XCTAssertEqual(app.staticTexts["changedBPMLabel"].label, "130")

        
        let silentkeepButton = app.buttons["silentKeepButton"]
        silentkeepButton.tap()
        
        XCTAssert(app.buttons["startButton1"].exists)
        XCTAssertTrue(app.buttons["startButton1"].isEnabled)
        
        XCTAssert(app.buttons["stopButton1"].exists)
        XCTAssertFalse(app.buttons["stopButton1"].isEnabled)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
