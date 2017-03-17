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
    
    // See AATests.cpp
    func testTTtoUTRoundTripping() {
        let earth = Earth(julianDay: JulianDay(year: 1962, month: 1, day: 1), highPrecision: false)
        let northwardEquinox = earth.equinox(true)
        XCTAssertEqual(northwardEquinox.value, JulianDay(2437744.6042503607).value)
        
        // TT
        XCTAssertEqual(northwardEquinox, JulianDay(year: 1962, month: 3, day: 21, hour: 2, minute: 30, second: 7.231168))

        // TT -> UT
        XCTAssertEqual(northwardEquinox.TTtoUTC(), JulianDay(year: 1962, month: 3, day: 21, hour: 2, minute: 29, second: 33.112424))

        // TT -> UT -> TT
        XCTAssertEqual(northwardEquinox.TTtoUTC().UTCtoTT(), JulianDay(year: 1962, month: 3, day: 21, hour: 2, minute: 30, second: 7.231168))
    }
    
    // See AATests.cpp
    func testTTtoTAIRoundTripping() {
        let earth = Earth(julianDay: JulianDay(year: 1962, month: 1, day: 1), highPrecision: false)
        let northwardEquinox = earth.equinox(true)
        XCTAssertEqual(northwardEquinox.value, JulianDay(2437744.6042503607).value)
        
        // TT -> TAI
        XCTAssertEqual(northwardEquinox.TTtoTAI(), JulianDay(year: 1962, month: 3, day: 21, hour: 2, minute: 29, second: 35.047155))
        
        // TT -> TAI -> TT
        XCTAssertEqual(northwardEquinox.TTtoTAI().TAItoTT(), JulianDay(year: 1962, month: 3, day: 21, hour: 2, minute: 30, second: 7.231168))
    }
    
    // See AATests.cpp
    func testTTtoUT1RoundTripping() {
        let earth = Earth(julianDay: JulianDay(year: 1962, month: 1, day: 1), highPrecision: false)
        let northwardEquinox = earth.equinox(true)
        XCTAssertEqual(northwardEquinox.value, JulianDay(2437744.6042503607).value)
        
        // TT -> UT1
        XCTAssertEqual(northwardEquinox.TTtoUT1(), JulianDay(year: 1962, month: 3, day: 21, hour: 2, minute: 29, second: 33.140024))
        
        // TT -> UT1 -> TT
        XCTAssertEqual(northwardEquinox.TTtoUT1().UT1toTT(), JulianDay(year: 1962, month: 3, day: 21, hour: 2, minute: 30, second: 7.231168))
    }
}
