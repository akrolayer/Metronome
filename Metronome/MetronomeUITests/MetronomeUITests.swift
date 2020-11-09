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

    func testViewController() throws {
//        //pickerを二つ並べ、それを下から出しているがそのテスト方法がわかっていない
//        let app = XCUIApplication()
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
    }
    func testNextViewController() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        //let bpmTextField = app.textFields["bpmTextBox"]
        //bpmTextField.doubleTap()

        let silentkeepButton = app.buttons["silentKeepButton"]
        silentkeepButton.tap()
        
        let startButton = app.buttons["startButton1"]
        let stopButton = app.buttons["stopButton1"]
        //存在確認
        XCTAssert(startButton.exists)
        XCTAssertTrue(startButton.isEnabled)
        XCTAssert(stopButton.exists)
        XCTAssertFalse(stopButton.isEnabled)
        //Enable,Unableの切り替え
        startButton.tap()
        XCTAssertTrue(stopButton.isEnabled)
        XCTAssertFalse(startButton.isEnabled)
        stopButton.tap()
        XCTAssertTrue(startButton.isEnabled)
        XCTAssertFalse(stopButton.isEnabled)
        //枠内に入っているか確認
        let window = app.windows.element(boundBy: 0)
        XCTAssert(window.frame.contains(startButton.frame))
        XCTAssert(window.frame.contains(stopButton.frame))
        
        startButton.tap()
        sleep(12)
        stopButton.tap()
        XCTAssertEqual(app.staticTexts["resultLabel"].label, "0拍ずれたよ！")
    }

    func testNextViewController2() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let constantKeepButton = app.buttons["constantKeepButton"]
        constantKeepButton.tap()
        
        let startButton = app.buttons["startButton2"]
        let stopButton = app.buttons["stopButton2"]
        //存在確認
        XCTAssert(startButton.exists)
        XCTAssertTrue(startButton.isEnabled)
        XCTAssert(stopButton.exists)
        XCTAssertFalse(stopButton.isEnabled)
        //枠内に入っているか確認
        let window = app.windows.element(boundBy: 0)
        XCTAssert(window.frame.contains(app.buttons["startButton2"].frame))
        
        //画像が変わっているか確認
        let image = startButton.images
        startButton.tap()
        XCTAssertTrue(app.buttons["stopButton2"].isEnabled)
        XCTAssertFalse(app.buttons["startButton2"].images == image)
        XCTAssert(window.frame.contains(app.buttons["stopButton2"].frame))
        
        for _ in 0...11{
        startButton.tap()
        sleep(1)
        }
        XCTAssertEqual(app.staticTexts["textView"].label, "0拍ずれたよ！")
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
