//
//  VenusTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation
import XCTest
@testable import SwiftAA

class VenusTests: XCTestCase {

    func testAverageColorPresence() {
        XCTAssertNotNil(Venus.averageColor)
    }
    
    func testApparentGeocentricCoordinates() { // See AA p.225
        let venus = Venus(julianDay: JulianDay(year: 1992, month: 12, day: 20))
        AssertEqual(Hour(venus.planetaryDetails.ApparentGeocentricRA), Hour(21.078181), accuracy: ArcSecond(0.1).inHours)
        AssertEqual(Degree(venus.planetaryDetails.ApparentGeocentricDeclination), Degree(-18.88801), accuracy: ArcSecond(0.1).inDegrees)
    }
    
    func testIlluminationFraction() { // See AA p.284
        let venus = Venus(julianDay: JulianDay(year: 1992, month: 12, day: 20))
        XCTAssertEqual(venus.illuminatedFraction, 0.647, accuracy: 0.005)
    }
    
    func testHeliocentricEclipticCoordinates() { // See AA p.225
        let venus = Venus(julianDay: JulianDay(year: 1992, month: 12, day: 20), highPrecision: false)
        let heliocentricEcliptic = venus.heliocentricEclipticCoordinates
        AssertEqual(heliocentricEcliptic.celestialLatitude, Degree(-2.62070), accuracy: ArcSecond(0.1).inDegrees)
        AssertEqual(heliocentricEcliptic.celestialLongitude, Degree(26.11428), accuracy: ArcSecond(0.1).inDegrees)
        AssertEqual(venus.radiusVector, AstronomicalUnit(0.724603), accuracy: AstronomicalUnit(0.00001))
    }
    
    func testGeocentricEquatorialCoordinates() { // See AA p.103
        let venus = Venus(julianDay: JulianDay(year: 1988, month: 03, day: 20))
        let equatorial = venus.apparentGeocentricEquatorialCoordinates
        AssertEqual(equatorial.rightAscension.inDegrees, Degree(41.73129), accuracy: ArcSecond(0.1).inDegrees)
        AssertEqual(equatorial.declination, Degree(18.44092), accuracy: ArcSecond(0.1).inDegrees)
    }
    
}
