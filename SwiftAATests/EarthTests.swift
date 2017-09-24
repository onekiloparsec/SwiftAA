//
//  EarthSeasonsTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/03/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

// Based on AA+ "tests"
class EarthTests: XCTestCase {

    func testAverageColor() {
        XCTAssertNotEqual(Earth.averageColor, Color.white)
    }

    func testLengthOfSeason2000() {
        let earth = Earth(julianDay: JulianDay(year: 2000, month: 2, day: 1))
        AssertEqual(earth.lengthOfSeason(.spring, northernHemisphere: true), 92.7586.days, accuracy: 0.0001.days)
        AssertEqual(earth.lengthOfSeason(.spring, northernHemisphere: false), 89.8402.days, accuracy: 0.0001.days)

        AssertEqual(earth.lengthOfSeason(.summer, northernHemisphere: true), 93.6526.days, accuracy: 0.0001.days)
        AssertEqual(earth.lengthOfSeason(.summer, northernHemisphere: false), 88.9953.days, accuracy: 0.0001.days)

        AssertEqual(earth.lengthOfSeason(.autumn, northernHemisphere: true), 89.8402.days, accuracy: 0.0001.days)
        AssertEqual(earth.lengthOfSeason(.autumn, northernHemisphere: false), 92.7586.days, accuracy: 0.0001.days)

        AssertEqual(earth.lengthOfSeason(.winter, northernHemisphere: true), 88.9953.days, accuracy: 0.0001.days)
        AssertEqual(earth.lengthOfSeason(.winter, northernHemisphere: false), 93.6526.days, accuracy: 0.0001.days)
    }
    
    // Same as Venus test, but using convenience method of Earth class.
    // See AA p.103
    func testRiseTransitSetTimesOfVenus() {
        let jd = JulianDay(year: 1988, month: 3, day: 20, hour: 0, minute: 0, second: 0)
        let earth = Earth(julianDay: jd)
        
        let boston = GeographicCoordinates(positivelyWestwardLongitude: 71.0833, latitude: 42.3333)
        let details = earth.riseTransitSetTimes(for: .VENUS, geographicCoordinates: boston)
        
        let accuracy = Minute(2.0).inJulianDays
        let expectedRise = JulianDay(year: 1988, month: 03, day: 20, hour: 12, minute: 25)
        AssertEqual(details.riseTime!, expectedRise, accuracy: accuracy)
        let expectedTransit = JulianDay(year: 1988, month: 03, day: 20, hour: 19, minute: 41)
        AssertEqual(details.transitTime!, expectedTransit, accuracy: accuracy)
        let expectedSet = JulianDay(year: 1988, month: 03, day: 20, hour: 2, minute: 55)
        AssertEqual(details.setTime!, expectedSet, accuracy: accuracy)

    }
}

