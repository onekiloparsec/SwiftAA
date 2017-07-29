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
    func testRiseTransitSetTimes() {
        let jd = JulianDay(2465483.5000000000) // 1st of March in 2038
        let mercury = Mercury(julianDay: jd, highPrecision: true)
        let times = mercury.riseTransitSetTimes(for: GeographicCoordinates.zero)
        
        let accuracy = Hour(5.0).inJulianDays

        let expectedRise = DateComponents(calendar: Calendar.gregorianGMT, year: 2038, month: 3, day: 1, hour: 10, minute: 5, second: 52)
        AssertEqual(times.riseTime!, expectedRise.date!.julianDay, accuracy: accuracy)
        
        let expectedTransit = DateComponents(calendar: Calendar.gregorianGMT, year: 2038, month: 3, day: 1, hour: 16, minute: 13, second: 1)
        AssertEqual(times.transitTime!, expectedTransit.date!.julianDay, accuracy: accuracy)
        
        let expectedSet = DateComponents(calendar: Calendar.gregorianGMT, year: 2038, month: 3, day: 1, hour: 22, minute: 20, second: 15)
        AssertEqual(times.setTime!, expectedSet.date!.julianDay, accuracy: accuracy)

    }
}
