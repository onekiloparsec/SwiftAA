//
//  PlanetaryOrbitsTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 2017-09-20.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class PlanetaryOrbitsTests: XCTestCase {

    // See AA p.211, Example 31.a
    func testMeanOrbitalElementsOfMercury() {
        let jd = JulianDay(2475460.5)
        let mercury = Mercury(julianDay: jd, highPrecision: false)

        // numeric types
        AssertEqual(mercury.semimajorAxis(), AstronomicalUnit(0.387098310))
        AssertEqual(mercury.inclination(.meanEquinoxOfTheDate(jd)), Degree(7.006171), accuracy: Degree(0.000001))
        AssertEqual(mercury.longitudeOfAscendingNode(.meanEquinoxOfTheDate(jd)), Degree(49.107650), accuracy: Degree(0.000001))
        AssertEqual(mercury.longitudeOfPerihelion(.meanEquinoxOfTheDate(jd)), Degree(78.475382), accuracy: Degree(0.000001))

        // non-numeric types
        XCTAssertEqualWithAccuracy(mercury.eccentricity(), 0.20564510, accuracy: 0.00000001)
    }

}
