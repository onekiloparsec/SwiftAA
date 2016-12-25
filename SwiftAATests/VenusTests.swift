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

    // See AA p.225
    func testApparentGeocentricCoordinates() {
        // Months going from 1 to 12
        var components = DateComponents()
        components.year = 1992
        components.month = 12
        components.day = 20
        let date = Calendar.gregorianGMT.date(from: components)!
        let venus = Venus(julianDay: date.julianDay)
        
        XCTAssertEqualWithAccuracy(venus.planetaryDetails.ApparentGeocentricRA, 21.078181, accuracy: 0.000001)
        XCTAssertEqualWithAccuracy(venus.planetaryDetails.ApparentGeocentricDeclination, -18.88801, accuracy: 0.000001)
    }
    
    
    // See AA p.284
    func testIlluminationFraction() {
        // Months going from 1 to 12
        var components = DateComponents()
        components.year = 1992
        components.month = 12
        components.day = 20
        let date = Calendar.gregorianGMT.date(from: components)!
        // Both radius vector are correct. Not Delta! Check.
        let frac = Venus(julianDay: date.julianDay).illuminatedFraction
        XCTAssertEqualWithAccuracy(frac, 0.647, accuracy: 0.005)
    }
    
    func testHeliocentricEclipticCoordinates() { // AA p.225
        let date = Calendar.gregorianGMT.date(from: DateComponents(year: 1992, month: 12, day: 20))!.julianDay
        let venus = Venus(julianDay: date, highPrecision: false)
        let heliocentricEcliptic = venus.eclipticCoordinates
        XCTAssertEqualWithAccuracy(heliocentricEcliptic.celestialLatitude.value, -2.62070, accuracy: 0.00001)
        XCTAssertEqualWithAccuracy(heliocentricEcliptic.celestialLongitude.value, 26.11428, accuracy: 0.00001)
        XCTAssertEqualWithAccuracy(venus.radiusVector.value, 0.724603, accuracy: 0.00001)
    }
    
    func testEquatorialCoordinates() { // p.103
        let date = Calendar.gregorianGMT.date(from: DateComponents(year: 1988, month: 03, day: 20, hour: 00, minute: 00, second: 00))!
        let equatorial = Venus(julianDay: date.julianDay).equatorialCoordinates
        XCTAssertEqualWithAccuracy(equatorial.rightAscension.inDegrees.value, 41.73129, accuracy: 0.1/60.0)
        XCTAssertEqualWithAccuracy(equatorial.declination.value, 18.44092, accuracy: 0.1/60.0)
    }

}
