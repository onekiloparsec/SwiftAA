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
    
}


