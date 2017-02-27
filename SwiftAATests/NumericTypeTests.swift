//
//  NumericTypeTests.swift
//  SwiftAA
//
//  Created by Alexander Vasenin on 03/01/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class NumericTypeTests: XCTestCase {

    func testCircularInterval() {
        XCTAssertTrue(Degree(15).isWithinCircularInterval(from: 10, to: 20))
        XCTAssertFalse(Degree(55).isWithinCircularInterval(from: 10, to: 20))
        XCTAssertFalse(Degree(10).isWithinCircularInterval(from: 10, to: 20, isIntervalOpen: true))
        XCTAssertTrue(Degree(15).isWithinCircularInterval(from: 10, to: 20, isIntervalOpen: false))
        XCTAssertTrue(Degree(10).isWithinCircularInterval(from: 340, to: 20))
        XCTAssertTrue(Degree(350).isWithinCircularInterval(from: 340, to: 20))
        XCTAssertFalse(Degree(340).isWithinCircularInterval(from: 340, to: 20, isIntervalOpen: true))
        XCTAssertTrue(Degree(340).isWithinCircularInterval(from: 340, to: 20, isIntervalOpen: false))
    }
    
    func testRoundingToIncrement() {
        let accuracy = Second(1e-3).inJulianDays
        let jd = JulianDay(year: 2017, month: 1, day: 9, hour: 13, minute: 53, second: 39.87)
        AssertEqual(jd.rounded(toIncrement: Minute(1).inJulianDays), JulianDay(year: 2017, month: 1, day: 9, hour: 13, minute: 54), accuracy: accuracy)
        AssertEqual(jd.rounded(toIncrement: Minute(15).inJulianDays), JulianDay(year: 2017, month: 1, day: 9, hour: 14), accuracy: accuracy)
        AssertEqual(jd.rounded(toIncrement: Hour(3).inJulianDays), JulianDay(year: 2017, month: 1, day: 9, hour: 15), accuracy: accuracy)
    }
    
}


