//
//  AberrationTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 2017-09-20.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class AberrationTests: XCTestCase {

    // See AA. p156, example 23.b
    func testHighPrecisionEquatorialAberration() {
        
        // theta Persei, mean equinox J2000, allowing for proper motion.
        let alpha = Hour(.plus, 2, 44, 12.9747)
        let delta = Degree(.plus, 49, 13, 39.896)
        let coords = EquatorialCoordinates(alpha: alpha, delta: delta)
        
        // In teh book, it is written 2028 Nov. 13.19 TD.
        let sexagesimalHour = Hour(0.19*24.0).sexagesimal
        let jd = JulianDay(year: 2028, month: 11, day: 13, hour: sexagesimalHour.radical, minute: sexagesimalHour.minute, second: sexagesimalHour.second)
        XCTAssertEqual(jd.value, 2462088.69)
        
        // If highPrecision = false, the Ron-Vondrák algorithm is used. See AA p.153.
        // If highPrecision = true, the VSOP87 theory is used. (but we don;t have reference value to test against).
        let correctedCoordsLowPrecision = coords.correctedForAnnualAberration(julianDay: jd, highPrecision: false)
        AssertEqual((correctedCoordsLowPrecision.alpha-coords.alpha).inDegrees.inArcSeconds, Degree(0.0083223).inArcSeconds, accuracy: ArcSecond(0.0001))        
    }

}
