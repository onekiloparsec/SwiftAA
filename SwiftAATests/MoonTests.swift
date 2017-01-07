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
    
}


