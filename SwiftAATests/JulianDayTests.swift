//
//  JulianDayTest.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/09/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class JulianDayTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDate1ToJulianDay() {
        var components = DateComponents()
        components.year = 2016
        components.month = 9
        components.day = 17
        let date = Calendar.gregorianGMT.date(from: components)
        XCTAssertEqual(date?.julianDay(), 2457648.500000)
    }

    func testDate2ToJulianDay() {
        var components = DateComponents()
        components.year = 1916
        components.month = 9
        components.day = 17
        components.hour = 2
        components.minute = 3
        components.second = 4
        components.nanosecond = 500000
        let date = Calendar.gregorianGMT.date(from: components)!
        XCTAssertEqualWithAccuracy(date.julianDay().value, 2421123.585469, accuracy: 0.000001)
    }

    func testJulianDayToDateComponents() {
        let julianDay = JulianDay(2421123.585469)
        let components = Calendar.gregorianGMT.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: julianDay.date())
        XCTAssertEqual(components.year!, 1916)
        XCTAssertEqual(components.month!, 9)
        XCTAssertEqual(components.day!, 17)
        XCTAssertEqual(components.hour!, 2)
        XCTAssertEqual(components.minute!, 3)
        XCTAssertEqual(components.second!, 4)
        XCTAssertEqual(components.nanosecond!, 521659)
    }

}
