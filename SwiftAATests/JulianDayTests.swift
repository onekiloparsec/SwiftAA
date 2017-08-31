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
    
    func testDate1ToJulianDay() {
        var components = DateComponents()
        components.year = 2016
        components.month = 9
        components.day = 17
        let date = Calendar.gregorianGMT.date(from: components)
        XCTAssertEqual(date?.julianDay, 2457648.500000)
    }

    func testDate2ToJulianDay() {
        var components = DateComponents()
        components.year = 1916
        components.month = 9
        components.day = 17
        components.hour = 2
        components.minute = 3
        components.second = 4
        components.nanosecond = 500000000
        let date = Calendar.gregorianGMT.date(from: components)!
        let jd = JulianDay(2421123.5 + 2.0/24.0 + 3.0/1440.0 + (4.0+500000000/1e9)/86400.0)
        AssertEqual(date.julianDay, jd, accuracy: Second(0.001).inJulianDays)
    }

    func testJulianDayToDateComponents() {
        let julianDay = JulianDay(2421123.585469)
        let components = Calendar.gregorianGMT.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: julianDay.date)
        XCTAssertEqual(components.year!, 1916)
        XCTAssertEqual(components.month!, 9)
        XCTAssertEqual(components.day!, 17)
        XCTAssertEqual(components.hour!, 2)
        XCTAssertEqual(components.minute!, 3)
        XCTAssertEqual(components.second!, 4)
        XCTAssertEqual(Double(components.nanosecond!)/1e9, 521659000/1e9, accuracy: 0.001)
    }

    func testDate1ToModifiedJulianDay() {
        var components = DateComponents()
        components.year = 2016
        components.month = 9
        components.day = 17
        let date = Calendar.gregorianGMT.date(from: components)
        XCTAssertEqual(date?.julianDay.modified, 57648.0)
    }
    
    func testJulian2016() {
        let components = DateComponents(year: 2016, month: 12, day: 21, hour: 01, minute: 04, second: 09, nanosecond: Int(0.1035*1e9))
        let jd = JulianDay(2457743.5 + 01.0/24.0 + 04.0/1440.0 + 09.1035/86400)
        testJulian(components, jd)
        let jd2 = JulianDay(year: 2016, month: 12, day: 21, hour: 1, minute: 4, second: 9.1035)
        AssertEqual(jd, jd2, accuracy: Second(0.001).inJulianDays)
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
        let date1 = jd.date
        let jd1 = date.julianDay
        let date2 = jd1.date
        let jd2 = date1.julianDay
        let accuracy = TimeInterval(0.001)
        XCTAssertEqual(date.timeIntervalSinceReferenceDate, date1.timeIntervalSinceReferenceDate, accuracy: accuracy)
        XCTAssertEqual(date.timeIntervalSinceReferenceDate, date2.timeIntervalSinceReferenceDate, accuracy: accuracy)
        AssertEqual(jd, jd1, accuracy: Second(accuracy).inJulianDays)
        AssertEqual(jd, jd2, accuracy: Second(accuracy).inJulianDays)
    }
    
    func testMeanGreenwichSiderealTime1() { // See AA p.88
        let jd = JulianDay(year: 1987, month: 04, day: 10)
        let gmst = jd.meanGreenwichSiderealTime()
        AssertEqual(gmst, Hour(.plus, 13, 10, 46.3668), accuracy: Second(0.001).inHours)
    }

    func testApparentGreenwichSiderealTime1() { // See also AA p.88
        let jd = JulianDay(year: 1987, month: 04, day: 10)
        let gmst = jd.apparentGreenwichSiderealTime()
        AssertEqual(gmst, Hour(.plus, 13, 10, 46.1351), accuracy: Second(0.001).inHours)
    }

    func testMeanGreenwichSiderealTime2() { // See AA p.89
        let jd = JulianDay(year: 1987, month: 04, day: 10, hour: 19, minute: 21, second: 00)
        let gmst = jd.meanGreenwichSiderealTime()
        AssertEqual(gmst, Hour(.plus, 8, 34, 57.0898), accuracy: Second(0.001).inHours)
    }
    
    func testMeanLocalSiderealTime1() { // Data from SkySafari
        let jd = JulianDay(year: 2016, month: 12, day: 1, hour: 14, minute: 15, second: 3)
        let geographic = GeographicCoordinates(positivelyWestwardLongitude: -37.615559, latitude: 55.752220)
        let lmst = jd.meanLocalSiderealTime(longitude: geographic.longitude)
        AssertEqual(lmst, Hour(.plus, 21, 28, 59.0), accuracy: Second(1.0).inHours)
    }
    
    func testMidnight() {
        let jd1 = JulianDay(year: 2016, month: 12, day: 20, hour: 3, minute: 5, second: 3.5)
        AssertEqual(jd1.midnight, JulianDay(year: 2016, month: 12, day: 20))
        
        let jd2 = JulianDay(year: 2016, month: 12, day: 19, hour: 23, minute: 13, second: 39.1)
        AssertEqual(jd2.midnight, JulianDay(year: 2016, month: 12, day: 19))
        AssertEqual(jd2.midnight, jd2.midnight.midnight)
        AssertEqual(jd2.midnight, jd2.midnight.midnight.midnight)
    }
    
    func testLocalMidnightForLongitude() {
        let jd = JulianDay(year: 2016, month: 12, day: 20, hour: 3, minute: 5, second: 3.5)
        
        let longitude1 = 0.0.degrees        
        AssertEqual(jd.localMidnight(longitude: longitude1), JulianDay(year: 2016, month: 12, day: 20, hour: 0))
        
        let longitude2 = 15.0.degrees
        AssertEqual(jd.localMidnight(longitude: longitude2), JulianDay(year: 2016, month: 12, day: 20, hour: 1))
        
        let longitude3 = -15.0.degrees
        AssertEqual(jd.localMidnight(longitude: longitude3), JulianDay(year: 2016, month: 12, day: 19, hour: 23))
        
        let longitude4 = 90.0.degrees
        AssertEqual(jd.localMidnight(longitude: longitude4), JulianDay(year: 2016, month: 12, day: 19, hour: 6))
        
        let longitude5 = -90.0.degrees
        AssertEqual(jd.localMidnight(longitude: longitude5), JulianDay(year: 2016, month: 12, day: 19, hour: 18))
    }
    
    func testLocalMidnightForTimeZone() {
        let jd = JulianDay(year: 2016, month: 12, day: 20, hour: 3, minute: 5, second: 3.5)
        
        let timeZone0 = TimeZone(secondsFromGMT: 0)!
        AssertEqual(jd.localMidnight(timeZone: timeZone0), JulianDay(year: 2016, month: 12, day: 20, hour: 0))
        
        let timeZone1 = TimeZone(secondsFromGMT: -1 * 60 * 60)!
        AssertEqual(jd.localMidnight(timeZone: timeZone1), JulianDay(year: 2016, month: 12, day: 20, hour: 1))
        
        let timeZone2 = TimeZone(secondsFromGMT: +1 * 60 * 60)!
        AssertEqual(jd.localMidnight(timeZone: timeZone2), JulianDay(year: 2016, month: 12, day: 19, hour: 23))
        
        let timeZone3 = TimeZone(secondsFromGMT: -6 * 60 * 60)!
        AssertEqual(jd.localMidnight(timeZone: timeZone3), JulianDay(year: 2016, month: 12, day: 19, hour: 6))
        
        let timeZone4 = TimeZone(secondsFromGMT: +6 * 60 * 60)!
        AssertEqual(jd.localMidnight(timeZone: timeZone4), JulianDay(year: 2016, month: 12, day: 19, hour: 18))
    }
    
    func testLocalMidnightWestward() {
        let jd = JulianDay(year: 2016, month: 12, day: 20, hour: 3, minute: 5, second: 3.5)
        
        let longitude1 = 0.0.degrees
        XCTAssertEqual(jd.localMidnight(longitude: longitude1).date, JulianDay(year: 2016, month: 12, day: 20, hour: 0).date)

        let longitude2 = 15.0.degrees // positive = going west, midnight is "later" than UTC hour of input jd
        XCTAssertEqual(jd.localMidnight(longitude: longitude2).date, JulianDay(year: 2016, month: 12, day: 20, hour: 1).date)
        
        let longitude3 = 30.0.degrees
        XCTAssertEqual(jd.localMidnight(longitude: longitude3).date, JulianDay(year: 2016, month: 12, day: 20, hour: 2).date)
        
        let longitude4 = 60.0.degrees // from now on, jump back by one day, degree(60)=hour(4) is greater than input 3hm5s3.5
        XCTAssertEqual(jd.localMidnight(longitude: longitude4).date, JulianDay(year: 2016, month: 12, day: 19, hour: 4).date)
        
        let longitude5 = 90.0.degrees
        XCTAssertEqual(jd.localMidnight(longitude: longitude5).date, JulianDay(year: 2016, month: 12, day: 19, hour: 6).date)

        let longitude6 = 180.0.degrees
        XCTAssertEqual(jd.localMidnight(longitude: longitude6).date, JulianDay(year: 2016, month: 12, day: 19, hour: 12).date)
        
        let longitude7 = 270.0.degrees
        XCTAssertEqual(jd.localMidnight(longitude: longitude7).date, JulianDay(year: 2016, month: 12, day: 19, hour: 18).date)

        let longitude8 = 360.0.degrees // back to Dec 20.
        XCTAssertEqual(jd.localMidnight(longitude: longitude8).date, JulianDay(year: 2016, month: 12, day: 20, hour: 0).date)
    }
    
    func testLocalMidnightEastward() {
        let jd = JulianDay(year: 2016, month: 12, day: 20, hour: 3, minute: 5, second: 3.5)
        
        let longitude1 = 0.0.degrees
        XCTAssertEqual(jd.localMidnight(longitude: longitude1).date, JulianDay(year: 2016, month: 12, day: 20, hour: 0).date)
    
        let longitude2 = -15.0.degrees // negative = going east, midnight is "earlier" than UTC hour of input jd
        XCTAssertEqual(jd.localMidnight(longitude: longitude2).date, JulianDay(year: 2016, month: 12, day: 19, hour: 23).date)
        
        let longitude3 = -30.0.degrees
        XCTAssertEqual(jd.localMidnight(longitude: longitude3).date, JulianDay(year: 2016, month: 12, day: 19, hour: 22).date)
        
        let longitude4 = -60.0.degrees
        XCTAssertEqual(jd.localMidnight(longitude: longitude4).date, JulianDay(year: 2016, month: 12, day: 19, hour: 20).date)
        
        let longitude5 = -90.0.degrees
        XCTAssertEqual(jd.localMidnight(longitude: longitude5).date, JulianDay(year: 2016, month: 12, day: 19, hour: 18).date)
    
        let longitude6 = -180.0.degrees
        XCTAssertEqual(jd.localMidnight(longitude: longitude6).date, JulianDay(year: 2016, month: 12, day: 19, hour: 12).date)
        
        let longitude7 = -270.0.degrees // From now on, jump forward by one day, since we crossed the line.
        XCTAssertEqual(jd.localMidnight(longitude: longitude7).date, JulianDay(year: 2016, month: 12, day: 20, hour: 6).date)

        let longitude8 = -360.0.degrees
        XCTAssertEqual(jd.localMidnight(longitude: longitude8).date, JulianDay(year: 2016, month: 12, day: 20, hour: 0).date)
    }
    
    // See AA p.78
    func testDeltaTWithNewMoon() {
        // See AA. p353, ex. 49.a for the value.
        // This is the value of the Dynamical Time (TD) of the New Moon on Feb. 1997
        // To me, the value given by AA of 48 seconds is probably too cautious.
        let jd_td = JulianDay(2443192.65118)
        AssertEqual(jd_td.deltaT(), Second(48.0), accuracy: Second(0.5))
    }
}


