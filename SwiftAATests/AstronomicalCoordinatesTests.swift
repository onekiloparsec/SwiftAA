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
        let equatorial = EquatorialCoordinates(alpha: Hour(.plus, 7, 45, 18.946), delta: Degree(.plus, 28, 1, 34.26))
        let ecliptic = equatorial.makeEclipticCoordinates()
        AssertEqual(ecliptic.lambda, Degree(113.215630), accuracy: ArcSecond(0.01).inDegrees)
        AssertEqual(ecliptic.beta, Degree(6.684170), accuracy: ArcSecond(0.01).inDegrees)
        let eqBack = ecliptic.makeEquatorialCoordinates()
        AssertEqual(eqBack.rightAscension, equatorial.rightAscension, accuracy: ArcSecond(0.01).inHours)
        AssertEqual(eqBack.declination, equatorial.declination, accuracy: ArcSecond(0.01).inDegrees)
    }
    
    func testEquatorial2Horizontal() { // p.95
        let jd = JulianDay(year: 1987, month: 4, day: 10, hour: 19, minute: 21, second: 0)
        let equatorial = EquatorialCoordinates(alpha: Hour(.plus, 23, 9, 16.641), delta: Degree(.minus, 6, 43, 11.61))
        let geographic = GeographicCoordinates(positivelyWestwardLongitude: Degree(.plus, 77, 3, 56.0), latitude: Degree(.plus, 38, 55, 17.0))
        let horizontal = equatorial.makeHorizontalCoordinates(with: geographic, julianDay: jd)
        AssertEqual(horizontal.altitude, Degree(15.1249), accuracy: ArcSecond(5.0).inDegrees)
        AssertEqual(horizontal.azimuth, Degree(68.0337), accuracy: ArcSecond(5.0).inDegrees)
        let eqBack = horizontal.makeEquatorialCoordinates(julianDay: jd)
        AssertEqual(eqBack!.rightAscension, equatorial.rightAscension, accuracy: ArcSecond(0.01).inHours)
        AssertEqual(eqBack!.declination, equatorial.declination, accuracy: ArcSecond(0.01).inDegrees)
    }
    
    func testEquatorial2Galactic() { // p.95
        let equatorial = EquatorialCoordinates(alpha: Hour(.plus, 17, 48, 59.74), delta: Degree(.minus, 14, 43, 8.2), epoch: StandardEpoch_B1950_0)
        let galactic = equatorial.makeGalacticCoordinates()
        AssertEqual(galactic.l, Degree(12.9593), accuracy: ArcSecond(1.0).inDegrees)
        AssertEqual(galactic.b, Degree(6.0463), accuracy: ArcSecond(1.0).inDegrees)
        let eqBack = galactic.makeEquatorialCoordinates()
        AssertEqual(eqBack.rightAscension, equatorial.rightAscension, accuracy: ArcSecond(0.01).inHours)
        AssertEqual(eqBack.declination, equatorial.declination, accuracy: ArcSecond(0.01).inDegrees)
    }
    
    func testHorizontalSeparation() {
        let horizontal1 = HorizontalCoordinates(azimuth: 0, altitude: 0)
        let horizontal2 = HorizontalCoordinates(azimuth: 0, altitude: 45)
        let horizontal3 = HorizontalCoordinates(azimuth: 90, altitude: 45)
        AssertEqual(horizontal1.angularSeparation(with: horizontal2), Degree(45), accuracy: ArcSecond(0.0001).inDegrees)
        AssertEqual(horizontal2.angularSeparation(with: horizontal3), Degree(60), accuracy: ArcSecond(0.0001).inDegrees)
        AssertEqual(horizontal3.angularSeparation(with: horizontal1), Degree(90), accuracy: ArcSecond(0.0001).inDegrees)
    }    
}


