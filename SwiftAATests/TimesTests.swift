//
//  TimesTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 20/02/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class TimesTests: XCTestCase {
    func testHourMinusSignConstructor() {
        XCTAssertEqual(Hour(.minus, 1, 7, 30.0).value, -1.125)
        XCTAssertEqual(Hour(.minus, -1, 7, 30.0).value, -1.125)
        XCTAssertEqual(Hour(.minus, 1, -7, 30.0).value, -1.125)
        XCTAssertEqual(Hour(.minus, 1, 7, -30.0).value, -1.125)
        XCTAssertEqual(Hour(.minus, -1, -7, 30.0).value, -1.125)
        XCTAssertEqual(Hour(.minus, 1, -7, -30.0).value, -1.125)
        XCTAssertEqual(Hour(.minus, -1, 7, -30.0).value, -1.125)
        XCTAssertEqual(Hour(.minus, -1, -7, -30.0).value, -1.125)
    }
    
    func testHourPlusSignConstructor() {
        XCTAssertEqual(Hour(.plus, 1, 7, 30.0).value, 1.125)
        XCTAssertEqual(Hour(.plus, -1, 7, 30.0).value, 1.125)
        XCTAssertEqual(Hour(.plus, 1, -7, 30.0).value, 1.125)
        XCTAssertEqual(Hour(.plus, 1, 7, -30.0).value, 1.125)
        XCTAssertEqual(Hour(.plus, -1, -7, 30.0).value, 1.125)
        XCTAssertEqual(Hour(.plus, -1, -7, -30.0).value, 1.125)
        XCTAssertEqual(Hour(.plus, -1, 7, -30.0).value, 1.125)
        XCTAssertEqual(Hour(.plus, 1, -7, -30.0).value, 1.125)
    }
    
    func testHourMinusZeroSignConstructor() {
        XCTAssertEqual(Hour(.minus, 0, 7, 30.0).value, -0.125)
        XCTAssertEqual(Hour(.minus, 0, -7, 30.0).value, -0.125)
        XCTAssertEqual(Hour(.minus, 0, 7, -30.0).value, -0.125)
        XCTAssertEqual(Hour(.minus, 0, -7, -30.0).value, -0.125)
        XCTAssertEqual(Hour(.minus, 0, 0, 90.0).value, -0.025)
        XCTAssertEqual(Hour(.minus, 0, 0, -90.0).value, -0.025)
    }
    
    func testHourPlusZeroSignConstructor() {
        XCTAssertEqual(Hour(.plus, 0, 7, 30.0).value, 0.125)
        XCTAssertEqual(Hour(.plus, 0, -7, 30.0).value, 0.125)
        XCTAssertEqual(Hour(.plus, 0, 7, -30.0).value, 0.125)
        XCTAssertEqual(Hour(.plus, 0, -7, -30.0).value, 0.125)
        XCTAssertEqual(Hour(.plus, 0, 0, 90.0).value, 0.025)
        XCTAssertEqual(Hour(.plus, 0, 0, -90.0).value, 0.025)
    }
    
    func testHourSexagesimalTransform() {
        let hplus = Hour(1.125)
        let hplussexagesimal: SexagesimalNotation = (.plus, 1, 7, 30.0)
        XCTAssertTrue(hplus.sexagesimalNotation == hplussexagesimal)
        
        let hminus = Hour(-1.125)
        let hminussexagesimal: SexagesimalNotation = (.minus, 1, 7, 30.0)
        XCTAssertTrue(hminus.sexagesimalNotation == hminussexagesimal)
    }
}
