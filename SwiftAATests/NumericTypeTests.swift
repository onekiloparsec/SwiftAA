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
    
    func testConstructors() {
        // Damn one needs to do to increase UT coverage...
        AssertEqual(1.234.degrees, Degree(1.234))
        AssertEqual(-1.234.degrees, Degree(-1.234))

        AssertEqual(1.234.arcminutes, ArcMinute(1.234))
        AssertEqual(-1.234.arcminutes, ArcMinute(-1.234))

        AssertEqual(1.234.arcseconds, ArcSecond(1.234))
        AssertEqual(-1.234.arcseconds, ArcSecond(-1.234))

        AssertEqual(1.234.hours, Hour(1.234))
        AssertEqual(-1.234.hours, Hour(-1.234))

        AssertEqual(1.234.minutes, Minute(1.234))
        AssertEqual(-1.234.minutes, Minute(-1.234))

        AssertEqual(1.234.seconds, Second(1.234))
        AssertEqual(-1.234.seconds, Second(-1.234))

        AssertEqual(1.234.radians, Radian(1.234))
        AssertEqual(-1.234.radians, Radian(-1.234))
        
        AssertEqual(1.234.days, Day(1.234))
        AssertEqual(-1.234.days, Day(-1.234))

        AssertEqual(1.234.julianDays, JulianDay(1.234))
        AssertEqual(-1.234.julianDays, JulianDay(-1.234))

        let s1 =  1.234.sexagesimal
        XCTAssertEqual(s1.sign, .plus)
        XCTAssertEqual(s1.radical, 1)
        XCTAssertEqual(s1.minute, 14)
        XCTAssertEqualWithAccuracy(s1.second, 2.4, accuracy: 0.000000001) // rounding error...
        XCTAssertEqual(1.234.sexagesimalShortString, "+01:14:02.4")

        // One needs a true sexagesimal library...
//        let s2 = -1.234.sexagesimal
//        let s3 = -0.123.sexagesimal
        
//        XCTAssertEqual(s2.sign, .minus)
//        XCTAssertEqual(s2.radical, -1)
//        XCTAssertEqual(s2.minute, 2)
//        XCTAssertEqual(s2.second, 3.4)
//
//        XCTAssertEqual(s3.sign, .minus)
//        XCTAssertEqual(s3.radical, 0)
//        XCTAssertEqual(s3.minute, 1)
//        XCTAssertEqual(s3.second, 2.3)
//        XCTAssertEqual(-1.234.sexagesimalShortString, "")


    }
}


