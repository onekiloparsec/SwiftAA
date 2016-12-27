//
//  RiseTransitSetTests.swift
//  SwiftAA
//
//  Created by Alexander Vasenin on 24/12/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class RiseTransitSetTests: XCTestCase {
    
    func testVenusAtBoston1988() { // See AA p.103
        let boston = GeographicCoordinates(positivelyWestwardLongitude: 71.0833, latitude: 42.3333)
        let venus = Venus(julianDay: JulianDay(year: 1988, month: 3, day: 20, hour: 1, minute: 5, second: 38))
        let details = RiseTransitSetTimes(celestialBody: venus, geographicCoordinates: boston)
        let accuracy = Minute(1.0).inDays
        let expectedRise = JulianDay(year: 1988, month: 03, day: 20, hour: 12, minute: 25)
        AssertEqual(details.riseTime!, expectedRise, accuracy: accuracy)
        let expectedTransit = JulianDay(year: 1988, month: 03, day: 20, hour: 19, minute: 41)
        AssertEqual(details.transitTime!, expectedTransit, accuracy: accuracy)
        let expectedSet = JulianDay(year: 1988, month: 03, day: 20, hour: 2, minute: 55)
        AssertEqual(details.setTime!, expectedSet, accuracy: accuracy)
    }
    
    func testVenusAtMoscow2016() { // Data from SkySafari
        let moscow = GeographicCoordinates(positivelyWestwardLongitude: -37.615559, latitude: 55.752220)
        let venus = Venus(julianDay: JulianDay(year: 2016, month: 12, day: 27, hour: 6, minute: 29, second: 55))
        let details = RiseTransitSetTimes(celestialBody: venus, geographicCoordinates: moscow)
        let accuracy = Minute(2.0).inDays
        let expectedRise = JulianDay(year: 2016, month: 12, day: 27, hour: 8, minute: 18, second: 13)
        AssertEqual(details.riseTime!, expectedRise, accuracy: accuracy)
        let expectedTransit = JulianDay(year: 2016, month: 12, day: 27, hour: 12, minute: 45, second: 0)
        AssertEqual(details.transitTime!, expectedTransit, accuracy: accuracy)
        let expectedSet = JulianDay(year: 2016, month: 12, day: 27, hour: 17, minute: 12, second: 50)
        AssertEqual(details.setTime!, expectedSet, accuracy: accuracy)
    }
    
}


