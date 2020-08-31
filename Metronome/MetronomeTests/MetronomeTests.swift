//
//  MetronomeTests.swift
//  MetronomeTests
//
//  Created by akrolayer on 2020/08/31.
//  Copyright © 2020 akrolayer. All rights reserved.
//

import XCTest

class MetronomeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let calcbeat = CalcBeat()
        let bpm = 120.0
        let result =  calcbeat.GetRoundDoubleDiffPerBeat(interval: Decimal(60 / bpm), judgeCount: 12, elapsedString: "6.0")
        XCTAssertEqual(result, 0.0)
    }
    
    func testGetRoundDouble() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let calcbeat = CalcBeat()
        let bpm = 120.0
        let result =  calcbeat.GetEachRoundDiffperBeat(TapTimingString: "1.0", interval: Decimal(60 / bpm), tapCount: 2)
        XCTAssertEqual(result, 0.0)
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
