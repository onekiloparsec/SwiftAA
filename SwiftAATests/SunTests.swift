//
//  SunTests.swift
//  SwiftAA
//
//  Created by Alexander Vasenin on 24/12/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class SunTests: XCTestCase {
    
    func testPosition() { // See AA p.165
        let sun = Sun(julianDay: JulianDay(year: 1993, month: 10, day: 13))
        let equatorial = sun.equatorialCoordinates
        // FIXME: the reason for very bad accuracy we use *mean* position instead of *apparent* in the book
        AssertEqual(equatorial.rightAscension, Hour(13.225389), accuracy: Degree(0.5).inHours)
        AssertEqual(equatorial.declination, Degree(-7.78507), accuracy: Degree(0.1))
    }
    
}


