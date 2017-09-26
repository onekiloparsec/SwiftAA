//
//  SunTests.swift
//  SwiftAA
//
//  Created by Alexander Vasenin on 24/12/2016.
//  MIT Licence. See LICENCE file.
//

import XCTest
@testable import SwiftAA

class SunTests: XCTestCase {
    
    // See AA p.165
    func testPosition() {
        let sun = Sun(julianDay: JulianDay(year: 1993, month: 10, day: 13))
        let equatorial = sun.equatorialCoordinates
        // FIXME: the reason for very bad accuracy we use *mean* position instead of *apparent* in the book
        AssertEqual(equatorial.rightAscension, Hour(13.225389), accuracy: Degree(0.5).inHours)
        AssertEqual(equatorial.declination, Degree(-7.78507), accuracy: Degree(0.1))
    }
    
    // See AA p.189
    func testPhysicalObservations() {
        let jd = JulianDay(year: 1992, month: 10, day: 13)
        XCTAssertEqual(jd.value, 2448908.5)
        
        let sun = Sun(julianDay: jd)
        AssertEqual(sun.positionAngleOfNorthernRotationAxisPoint, Degree(26.27), accuracy: Degree(0.005))
        AssertEqual(sun.heliographicLongitudeOfSolarDiskCenter, Degree(238.6317), accuracy: Degree(0.01))
        AssertEqual(sun.heliographicLatitudeOfSolarDiskCenter, Degree(5.99), accuracy: Degree(0.005))
    }

    // See AA p.192
    func testSynodicRotationStartTime() {
        let jdResult = JulianDay(2444480.7224)
        AssertEqual(Sun.timeOfStartOfSynodicRotation(rotationNumber: 1699), jdResult, accuracy: JulianDay(0.001))
        
        // A Synodic rotation is about 27 days. Taking the date from the above result, moving backward a bit, 
        // one can make an additional test.
        let sun = Sun(julianDay: jdResult - 15.0)
        AssertEqual(sun.nextStartOfTimeOfRotation(), jdResult, accuracy: JulianDay(0.001))
    }

    // See AA p.384, Example 28.a
    func testEquationOfTime() {
        let sun = Sun(julianDay: JulianDay(2448908.5))
        AssertEqual(sun.equationOfTime(), Minute(13.70940), accuracy: Minute(0.0003))
    }
    
    // See AA p.384, Example 28.a
    func testApparentCoordinatesAndRadiusVector() {
        let sun = Sun(julianDay: JulianDay(2448908.5))
        AssertEqual(sun.radiusVector, AstronomicalUnit(0.99760775), accuracy: AstronomicalUnit(0.000001))
        
        let eclCoords = sun.apparentEclipticCoordinates
        AssertEqual(eclCoords.lambda, Degree(.plus, 199, 54, 21.82), accuracy: ArcSecond(0.5).inDegrees)
        AssertEqual(eclCoords.beta, Degree(.plus, 0, 0, 0.62), accuracy: ArcSecond(0.5).inDegrees)
        
        let equCoords = sun.apparentEquatorialCoordinates
        AssertEqual(equCoords.alpha, Hour(.plus, 13, 13, 30.763), accuracy: ArcSecond(0.5).inHours)
        AssertEqual(equCoords.delta, Degree(.minus, 7, 47, 01.94), accuracy: ArcSecond(0.5).inDegrees)
    }
    
    // See AA p.389
    func testSemiDiameters() {
        let sun = Sun(julianDay: JulianDay(2448908.5))
        AssertEqual(sun.equatorialSemiDiameter, ArcSecond(Sun.semiDiameterAtOneAU.value/sun.radiusVector.value), accuracy: ArcSecond(0.01))
        AssertEqual(sun.equatorialSemiDiameter, sun.polarSemiDiameter)
    }
}


