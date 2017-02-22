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
        XCTAssertEqual(Hour(.minus, 1, 6, 90.0).value, -1.125)
        XCTAssertEqual(Hour(.minus, -1, 6, 90.0).value, -1.125)
        XCTAssertEqual(Hour(.minus, 1, -6, 90.0).value, -1.125)
        XCTAssertEqual(Hour(.minus, 1, 6, -90.0).value, -1.125)
        XCTAssertEqual(Hour(.minus, -1, -6, 90.0).value, -1.125)
        XCTAssertEqual(Hour(.minus, 1, -6, -90.0).value, -1.125)
        XCTAssertEqual(Hour(.minus, -1, 6, -90.0).value, -1.125)
        XCTAssertEqual(Hour(.minus, -1, -6, -90.0).value, -1.125)
    }
    
    func testHourPlusSignConstructor() {
        XCTAssertEqual(Hour(.plus, 1, 6, 90.0).value, 1.125)
        XCTAssertEqual(Hour(.plus, -1, 6, 90.0).value, 1.125)
        XCTAssertEqual(Hour(.plus, 1, -6, 90.0).value, 1.125)
        XCTAssertEqual(Hour(.plus, 1, 6, -90.0).value, 1.125)
        XCTAssertEqual(Hour(.plus, -1, -6, 90.0).value, 1.125)
        XCTAssertEqual(Hour(.plus, -1, -6, -90.0).value, 1.125)
        XCTAssertEqual(Hour(.plus, -1, 6, -90.0).value, 1.125)
        XCTAssertEqual(Hour(.plus, 1, -6, -90.0).value, 1.125)
    }
    
    func testHourMinusZeroSignConstructor() {
        XCTAssertEqual(Hour(.minus, 0, 6, 90.0).value, -0.125)
        XCTAssertEqual(Hour(.minus, 0, -6, 90.0).value, -0.125)
        XCTAssertEqual(Hour(.minus, 0, 6, -90.0).value, -0.125)
        XCTAssertEqual(Hour(.minus, 0, -6, -90.0).value, -0.125)
        XCTAssertEqual(Hour(.minus, 0, 0, 90.0).value, -0.025)
        XCTAssertEqual(Hour(.minus, 0, 0, -90.0).value, -0.025)
    }
    
    func testHourPlusZeroSignConstructor() {
        XCTAssertEqual(Hour(.plus, 0, 6, 90.0).value, 0.125)
        XCTAssertEqual(Hour(.plus, 0, -6, 90.0).value, 0.125)
        XCTAssertEqual(Hour(.plus, 0, 6, -90.0).value, 0.125)
        XCTAssertEqual(Hour(.plus, 0, -6, -90.0).value, 0.125)
        XCTAssertEqual(Hour(.plus, 0, 0, 90.0).value, 0.025)
        XCTAssertEqual(Hour(.plus, 0, 0, -90.0).value, 0.025)
    }
}
