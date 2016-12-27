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
    
}


