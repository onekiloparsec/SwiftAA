//
//  MercuryTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/03/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class MercuryTests: XCTestCase {

    func testAverageColorPresence() {
        XCTAssertNotNil(Mercury.averageColor)
    }
    
    // Taken from AA+ tests
    func testRiseTransitSetTimesLowPrecision() {
        let jd = JulianDay(2465483.5000000000) // 1st of March in 2038
        let mercury = Mercury(julianDay: jd, highPrecision: false)
        let times = mercury.riseTransitSetTimes(with: GeographicCoordinates(positivelyWestwardLongitude: 0.0.degrees, latitude: 0.0.degrees))
        let expected_rise = DateComponents(calendar: Calendar.gregorianGMT, year: 2038, month: 3, day: 1, hour: 10, minute: 5, second: 52)
        AssertEqual(times.riseTime!, expected_rise.date!.julianDay, accuracy: 1.0.seconds.inJulianDays)
    }

//    func testRiseTransitSetTimesHighPrecision() {
//        let jd = JulianDay(2465483.5000000000) // 1st of March in 2038
//        let mercury = Mercury(julianDay: jd, highPrecision: true)
//        let times = mercury.riseTransitSetTimes(with: GeographicCoordinates(positivelyWestwardLongitude: 0.0.degrees, latitude: 0.0.degrees))
//    }
}
