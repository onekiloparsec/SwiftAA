//
//  AstronomicalCoordinatesTests.swift
//  SwiftAA
//
//  Created by Alexander Vasenin on 24/12/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class AstronomicalCoordinatesTests: XCTestCase {
    
    func testEquatorial2Ecliptic() { // p.95
        let equatorial = EquatorialCoordinates(alpha: Hour(7.0 + 45.0/60.0 + 18.946/3600.0), delta: Degree(28.0 + 1.0/60.0 + 34.26/3600.0))
        let ecliptic = equatorial.toEclipticCoordinates()
        XCTAssertEqualWithAccuracy(ecliptic.lambda.value, 113.215630, accuracy: 0.01/3600.0)
        XCTAssertEqualWithAccuracy(ecliptic.beta.value, 6.684170, accuracy: 0.01/3600.0)
        let eqBack = ecliptic.toEquatorialCoordinates()
        XCTAssertEqualWithAccuracy(eqBack.rightAscension.value, equatorial.rightAscension.value, accuracy: 0.1/3600.0)
        XCTAssertEqualWithAccuracy(eqBack.declination.value, equatorial.declination.value, accuracy: 0.1/3600.0)
    }
    
    func testEquatorial2Horizontal() { // p.95
        let date = Calendar.gregorianGMT.date(from: DateComponents(year: 1987, month: 04, day: 10, hour: 19, minute: 21, second: 00))!
        let equatorial = EquatorialCoordinates(alpha: Hour(23.0 + 9.0/60.0 + 16.641/3600.0), delta: Degree( -6.0 - 43.0/60.0 - 11.61/3600.0))
        let geographic = GeographicCoordinates(positivelyWestwardLongitude: Degree(77.0 + 3.0/60.0 + 56.0/3600.0), latitude: Degree(38.0 + 55.0/60.0 + 17.0/3600.0))
        let horizontal = equatorial.toHorizontalCoordinates(forGeographicalCoordinates: geographic, julianDay: date.julianDay)
        XCTAssertEqualWithAccuracy(horizontal.altitude.value, 15.1249, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(horizontal.azimuth.value, 68.0337, accuracy: 0.001)
        let eqBack = horizontal.toEquatorialCoordinates()
        XCTAssertEqualWithAccuracy(eqBack.rightAscension.value, equatorial.rightAscension.value, accuracy: 0.1/3600.0)
        XCTAssertEqualWithAccuracy(eqBack.declination.value, equatorial.declination.value, accuracy: 0.1/3600.0)
    }
    
    func testEquatorial2Galactic() { // p.95
        let equatorial = EquatorialCoordinates(alpha: Hour(17.0 + 48.0/60.0 + 59.74/3600.0), delta: Degree( -14.0 - 43.0/60.0 - 8.2/3600.0), epsilon: StandardEpoch_B1950_0)
        let galactic = equatorial.toGalacticCoordinates()
        XCTAssertEqualWithAccuracy(galactic.l.value, 12.9593, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(galactic.b.value, 6.0463, accuracy: 0.001)
        let eqBack = galactic.toEquatorialCoordinates()
        XCTAssertEqualWithAccuracy(eqBack.rightAscension.value, equatorial.rightAscension.value, accuracy: 0.1/3600.0)
        XCTAssertEqualWithAccuracy(eqBack.declination.value, equatorial.declination.value, accuracy: 0.1/3600.0)
    }
    
}


