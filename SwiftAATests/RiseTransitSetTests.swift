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
    
    func testVenusAtBoston1988() { // AA p.103
        let boston = GeographicCoordinates(positivelyWestwardLongitude: 71.0833, latitude: 42.3333)
        let date = Calendar.gregorianGMT.date(from: DateComponents(year: 1988, month: 03, day: 20))!
        let venus = Venus(julianDay: date.julianDay)
        let details = RiseTransitSetTimes(celestialBody: venus, geographicCoordinates: boston)
        let expectedRise = Calendar.gregorianGMT.date(from: DateComponents(year: 1988, month: 03, day: 20, hour: 12, minute: 25))!
        let expectedTransit = Calendar.gregorianGMT.date(from: DateComponents(year: 1988, month: 03, day: 20, hour: 19, minute: 41))!
        let expectedSet = Calendar.gregorianGMT.date(from: DateComponents(year: 1988, month: 03, day: 20, hour: 2, minute: 55))!
        XCTAssertEqualWithAccuracy(details.riseTime!.value, expectedRise.julianDay.value, accuracy: 1.0/1440.0)
        XCTAssertEqualWithAccuracy(details.transitTime!.value, expectedTransit.julianDay.value, accuracy: 1.0/1440.0)
        XCTAssertEqualWithAccuracy(details.setTime!.value, expectedSet.julianDay.value, accuracy: 1.0/1440.0)
    }
    
}


