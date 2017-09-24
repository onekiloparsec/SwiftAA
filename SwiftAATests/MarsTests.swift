//
//  MarsTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 07/03/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class MarsTests: XCTestCase {
    
    func testAverageColorPresence() {
        XCTAssertNotEqual(Mars.averageColor, Color.white)
    }
    
    // See AA p.291, Example 42.a
    func testPhysicalDetails() {
        let jd = JulianDay(year: 1992, month: 11, day: 9)
        let mars = Mars(julianDay: jd)

        AssertEqual(mars.planetocentricDeclinationOfTheEarth, Degree(12.44), accuracy: Degree(0.01))
        AssertEqual(mars.planetocentricDeclinationOfTheSun, Degree(-2.76), accuracy: Degree(0.01))
        AssertEqual(mars.positionAngleOfNorthernRotationPole, Degree(347.64), accuracy: Degree(0.005))
        AssertEqual(mars.aerographicLongitudeOfCentralMeridian, Degree(111.55), accuracy: Degree(0.25)) // Accuracy?
        AssertEqual(mars.angularAmountOfGreatestDefectOfIllumination, ArcSecond(1.06), accuracy: ArcSecond(0.005))
        AssertEqual(mars.positionAngleOfGreatestDefectOfIllumination, Degree(279.91), accuracy: Degree(0.005))
        AssertEqual(mars.apparentDiameter, ArcSecond(10.75), accuracy: ArcSecond(0.005))
    }
}
