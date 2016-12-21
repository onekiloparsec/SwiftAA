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
    
    func testJulian2016() {
        let components = DateComponents(year: 2016, month: 12, day: 21, hour: 01, minute: 04, second: 09, nanosecond: Int(0.1035*10e9))
        let jd = JulianDay(2457743.5 + 01.0/24.0 + 04.0/1440.0 + 09.1035/86400)
        testJulian(components, jd)
    }
    
    func testJulian1980() {
        let components = DateComponents(year: 1980, month: 03, day: 15, hour: 03, minute: 47, second: 05, nanosecond: 0)
        let jd = JulianDay(2444313.5 + 03.0/24.0 + 47.0/1440.0 + 05.0/86400.0)
        testJulian(components, jd)
    }
    
    func testJulian1932() {
        let components = DateComponents(year: 1932, month: 10, day: 02, hour: 21, minute: 15, second: 59, nanosecond: 0)
        let jd = JulianDay(2426982.5 + 21.0/24.0 + 15.0/1440.0 + 59.0/86400.0)
        testJulian(components, jd)
    }
    
    func testJulian(_ components: DateComponents, _ jd: JulianDay) {
        let date = Calendar.gregorianGMT.date(from: components)!
        let date1 = jd.date()
        let jd1 = date.julianDay()
        let date2 = jd1.date()
        let jd2 = date1.julianDay()
        let accuracy = TimeInterval(1.0)
        XCTAssertEqualWithAccuracy(date.timeIntervalSinceReferenceDate, date1.timeIntervalSinceReferenceDate, accuracy: accuracy)
        XCTAssertEqualWithAccuracy(date.timeIntervalSinceReferenceDate, date2.timeIntervalSinceReferenceDate, accuracy: accuracy)
        XCTAssertEqualWithAccuracy(jd.value, jd1.value, accuracy: accuracy / 86400.0)
        XCTAssertEqualWithAccuracy(jd.value, jd2.value, accuracy: accuracy / 86400.0)
    }
    
}


