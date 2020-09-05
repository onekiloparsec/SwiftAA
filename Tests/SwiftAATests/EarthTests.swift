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

        XCTAssertNil(details.transitError)
    }
    
    func testRiseTransitSetTimesInvalidPlanet() {
        let jd = JulianDay(year: 1988, month: 3, day: 20, hour: 0, minute: 0, second: 0)
        let earth = Earth(julianDay: jd)
        
        let boston = GeographicCoordinates(positivelyWestwardLongitude: 71.0833, latitude: 42.3333)
        let details = earth.riseTransitSetTimes(for: .UNDEFINED, geographicCoordinates: boston)
        
        XCTAssertNil(details.riseTime)
        XCTAssertNil(details.transitTime)
        XCTAssertNil(details.setTime)
        XCTAssertNotNil(details.transitError)
    }
    
    func testEquinoxes() {
        let earth = Earth(julianDay: JulianDay(year: 1962, month: 1, day: 1))
        AssertEqual(earth.equinox(of: .northwardSpring), JulianDay(2437744.60425), accuracy: JulianDay(0.00001))
        
        // AA+ Tests Values
        // Result in time TT, not UTC.
        AssertEqual(earth.equinox(of: .northwardSpring), JulianDay(year: 1962, month: 3, day: 21, hour: 2, minute: 30, second: 7.231168), accuracy: Second(5.0).inJulianDays)
        AssertEqual(earth.equinox(of: .southwardSpring), JulianDay(year: 1962, month: 9, day: 23, hour: 12, minute: 35, second: 49.865869), accuracy: Second(5.0).inJulianDays)
    }

    // See AA p.180, Example 27.a
    func testSolstices() {
        let earth = Earth(julianDay: JulianDay(year: 1962, month: 1, day: 1), highPrecision: true)
        let northernSummer = earth.solstice(of: .northernSummer)
        AssertEqual(northernSummer, JulianDay(2437837.39215), accuracy: JulianDay(0.00001))
        
        // AA+ Tests Values
        // Result in time TT, not UTC.
        AssertEqual(earth.solstice(of: .northernSummer), JulianDay(year: 1962, month: 6, day: 21, hour: 21, minute: 24, second: 40.266644), accuracy: Second(5.0).inJulianDays)
        AssertEqual(earth.solstice(of: .southernSummer), JulianDay(year: 1962, month: 12, day: 22, hour: 8, minute: 15, second: 49.259721), accuracy: Second(5.0).inJulianDays)
    }
    
    // See AATests.cpp.
    // Procedure: Run AAPlusTests Xcode target, put breakpoints on lines ~1125 and read memory values.
    func testLongLatRadius () {
        let earthLowPrecision = Earth(julianDay: JulianDay(2448908.5), highPrecision: false)
        let earthHighPrecision = Earth(julianDay: JulianDay(2448908.5), highPrecision: true)
        
        XCTAssertEqual(earthLowPrecision.heliocentricEclipticCoordinates.celestialLongitude.value, 19.907371990723732)
        XCTAssertEqual(earthHighPrecision.heliocentricEclipticCoordinates.celestialLongitude.value, 19.907297242049481)
        
        XCTAssertEqual(earthLowPrecision.heliocentricEclipticCoordinates.celestialLatitude.value, -0.00017901250407703628)
        XCTAssertEqual(earthHighPrecision.heliocentricEclipticCoordinates.celestialLatitude.value, -0.00020664594472918907)
        
        XCTAssertEqual(earthLowPrecision.radiusVector.value, 0.99760774951494113)
        XCTAssertEqual(earthHighPrecision.radiusVector.value, 0.99760852023559332)
    }
}

