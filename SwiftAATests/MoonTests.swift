//
//  MoonTests.swift
//  SwiftAA
//
//  Created by Alexander Vasenin on 24/12/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class MoonTests: XCTestCase {
    
    func testEquatorialCoordinates() { // p.343
        let moon = Moon(julianDay: JulianDay(year: 1992, month: 04, day: 12, hour: 00, minute: 00, second: 00))
        let equatorial = moon.equatorialCoordinates
        // FIXME: the reason for bad accuracy we use *mean* position instead of *apparent* in the book
        AssertEqual(equatorial.rightAscension, Degree(134.688470).inHours, accuracy: ArcMinute(0.1).inHours)
        AssertEqual(equatorial.declination, Degree(13.768368), accuracy: ArcMinute(0.1).inDegrees)
    }
    
    func testTimeOfPhase() { // AA p.353
        let date1 = Moon(julianDay: JulianDay(year: 1977, month: 1, day: 20)).timeOfPhase(forPhase: .new, isNext: true, mean: false)
        let date2 = Moon(julianDay: JulianDay(year: 1977, month: 2, day: 17)).timeOfPhase(forPhase: .new, isNext: true, mean: false)
        let date3 = Moon(julianDay: JulianDay(year: 1977, month: 2, day: 19)).timeOfPhase(forPhase: .new, isNext: false, mean: false)
        let date4 = Moon(julianDay: JulianDay(year: 1977, month: 3, day: 19)).timeOfPhase(forPhase: .new, isNext: false, mean: false)
        let expected = JulianDay(year: 1977, month: 2, day: 18, hour: 3, minute: 37, second: 42)
        let accuracy = JulianDay(1.0/86400.0)
        AssertEqual(date1, expected, accuracy: accuracy)
        AssertEqual(date2, expected, accuracy: accuracy)
        AssertEqual(date3, expected, accuracy: accuracy)
        AssertEqual(date4, expected, accuracy: accuracy)
    }
    
    // Based on AA+ Tests. It says that an interesting case of moon rise occur on that date, on that place.
    // I've googled around, but found nothing. That position is close to Jan Mayen Island in the Norway sea.
    func testMoonRiseSetsAboveArticCircle() {
        
        let coords = GeographicCoordinates(positivelyWestwardLongitude: -5.6306649983214818.degrees, latitude: 71.646778771324804.degrees)
        
        let moon = Moon(julianDay: JulianDay(year: 2012, month: 10, day: 30))
        let times = moon.riseTransitSetTimes(for: coords)

        XCTAssertNotNil(times.riseTime)
        AssertEqual(times.riseTime!,
                    JulianDay(year: 2012, month: 10, day: 30, hour: 13, minute: 13, second: 12.0),
                    accuracy: 90.0.seconds.inJulianDays)
        
        XCTAssertNotNil(times.setTime)
        AssertEqual(times.setTime!,
                    JulianDay(year: 2012, month: 10, day: 30, hour: 10, minute: 11, second: 01.0),
                    accuracy: 90.0.seconds.inJulianDays)
    }
    
    // Based on AA+ Tests.
    func testMoonTransitSetsAboveArticCircle() {

        let coords = GeographicCoordinates(positivelyWestwardLongitude: -5.6306649983214818.degrees, latitude: 71.646778771324804.degrees)

        let moon = Moon(julianDay: JulianDay(year: 2012, month: 10, day: 31))
        let times = moon.riseTransitSetTimes(for: coords)
        
        XCTAssertNotNil(times.transitTime)
        AssertEqual(times.transitTime!,
                    JulianDay(year: 2012, month: 10, day: 31, hour: 0, minute: 11, second: 59.0),
                    accuracy: 90.0.seconds.inJulianDays)
        
        XCTAssertNotNil(times.setTime)
        AssertEqual(times.setTime!,
                    JulianDay(year: 2012, month: 10, day: 31, hour: 11, minute: 41, second: 8.0),
                    accuracy: 120.0.seconds.inJulianDays)
    }
    
}


