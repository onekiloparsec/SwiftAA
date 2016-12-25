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
    
    func testPosition() { // p.343
        let date = Calendar.gregorianGMT.date(from: DateComponents(year: 1992, month: 04, day: 12, hour: 00, minute: 00, second: 00))!
        let moon = Moon(julianDay: date.julianDay)
        let equatorial = moon.equatorialCoordinates
        // FIXME: the reason for bad accuracy we use *mean* position instead of *apparent* in the book
        XCTAssertEqualWithAccuracy(equatorial.rightAscension.value, 134.688470/15.0, accuracy: 0.1/3600.0)
        XCTAssertEqualWithAccuracy(equatorial.declination.value, 13.768368, accuracy: 10.0/3600.0)
    }
    
}


