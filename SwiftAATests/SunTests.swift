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
    
    func testPosition() { // p.165
        let date = Calendar.gregorianGMT.date(from: DateComponents(year: 1993, month: 10, day: 13, hour: 00, minute: 00, second: 00))!
        let sun = Sun(julianDay: date.julianDay)
        let equatorial = sun.equatorialCoordinates
        // FIXME: the reason for very bad accuracy we use *mean* position instead of *apparent* in the book
        XCTAssertEqualWithAccuracy(equatorial.rightAscension.value, 13.225389, accuracy: 1.0/60.0)
        XCTAssertEqualWithAccuracy(equatorial.declination.value, -7.78507, accuracy: 0.1)
    }
    
}


