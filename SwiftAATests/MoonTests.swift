//
//  MoonTests.swift
//  SwiftAA
//
//  Created by Alexander Vasenin on 24/12/2016.
//  MIT Licence. See LICENCE file.
//

import XCTest
@testable import SwiftAA

class MoonTests: XCTestCase {
    
    // See AA p.343
    func testEquatorialCoordinates() {
        let moon = Moon(julianDay: JulianDay(year: 1992, month: 04, day: 12, hour: 00, minute: 00, second: 00))
        let equatorial = moon.equatorialCoordinates
        // FIXME: the reason for bad accuracy we use *mean* position instead of *apparent* in the book
        AssertEqual(equatorial.rightAscension, Degree(134.688470).inHours, accuracy: ArcMinute(0.1).inHours)
        AssertEqual(equatorial.declination, Degree(13.768368), accuracy: ArcMinute(0.1).inDegrees)
    }
    
    // See AA p.353, Example 49.a
    func testTimeOfPhase() {
        let date1 = Moon(julianDay: JulianDay(year: 1977, month: 1, day: 20)).time(of: .newMoon, forward: true, mean: false)
        let date2 = Moon(julianDay: JulianDay(year: 1977, month: 2, day: 17)).time(of: .newMoon, forward: true, mean: false)
        let date3 = Moon(julianDay: JulianDay(year: 1977, month: 2, day: 19)).time(of: .newMoon, forward: false, mean: false)
        let date4 = Moon(julianDay: JulianDay(year: 1977, month: 3, day: 19)).time(of: .newMoon, forward: false, mean: false)
        let expected = JulianDay(year: 1977, month: 2, day: 18, hour: 3, minute: 37, second: 42)
        let accuracy = JulianDay(1.0/86400.0) // 1 second
        AssertEqual(date1, expected, accuracy: accuracy)
        AssertEqual(date2, expected, accuracy: accuracy)
        AssertEqual(date3, expected, accuracy: accuracy)
        AssertEqual(date4, expected, accuracy: accuracy)
    }
    
    // See AA p.353, Example 49.b
    func testTimeOfPhaseAgain() {
        let moon = Moon(julianDay: JulianDay(2467636.88597))
        AssertEqual(moon.time(of: .lastQuarter, forward: false, mean: false), JulianDay(2467636.49186), accuracy: JulianDay(0.000005))
    }
    
    // Based on AA+ Tests. It says that an interesting case of moon rise occur on that date, on that place.
    // I've googled around, but found nothing. That position is close to Jan Mayen Island in the Norway sea.
    func testMoonRiseSetsAboveArticCircle() {
        
        let coords = GeographicCoordinates(positivelyWestwardLongitude: -5.6306649983214818.degrees, latitude: 71.646778771324804.degrees)
        
        let moon = Moon(julianDay: JulianDay(year: 2012, month: 10, day: 30))
        let times = moon.riseTransitSetTimes(for: coords)

        XCTAssertNotNil(times.riseTime)
        AssertEqual(times.riseTime!,
                    JulianDay(year: 2012, month: 10, day: 30, hour: 13, minute: 13, second: 12.0),
                    accuracy: 90.0.seconds.inJulianDays)
        
        XCTAssertNotNil(times.setTime)
        AssertEqual(times.setTime!,
                    JulianDay(year: 2012, month: 10, day: 30, hour: 10, minute: 11, second: 01.0),
                    accuracy: 90.0.seconds.inJulianDays)
    }
    
    // Based on AA+ Tests.
    func testMoonTransitSetsAboveArticCircle() {

        let coords = GeographicCoordinates(positivelyWestwardLongitude: -5.6306649983214818.degrees, latitude: 71.646778771324804.degrees)

        let moon = Moon(julianDay: JulianDay(year: 2012, month: 10, day: 31))
        let times = moon.riseTransitSetTimes(for: coords)
        
        XCTAssertNotNil(times.transitTime)
        AssertEqual(times.transitTime!,
                    JulianDay(year: 2012, month: 10, day: 31, hour: 0, minute: 11, second: 59.0),
                    accuracy: 90.0.seconds.inJulianDays)
        
        XCTAssertNotNil(times.setTime)
        AssertEqual(times.setTime!,
                    JulianDay(year: 2012, month: 10, day: 31, hour: 11, minute: 41, second: 8.0),
                    accuracy: 120.0.seconds.inJulianDays)
    }
 
    // See AA p.342, Example 47.a
    func testGeocentricLongitudeLatitudeDistanceQuatorialHorizontalParallax() {
        
        let jd = JulianDay(2448724.5)
        let moon = Moon(julianDay: jd)
        
        // mean longitude = L prime
        AssertEqual(moon.meanLongitude, Degree(134.290182), accuracy: Degree(0.000001))
        // elongation = D
        AssertEqual(moon.meanElongation, Degree(113.842304), accuracy: Degree(0.000001))
        // mean anomaly = M prime
        AssertEqual(moon.meanAnomaly, Degree(5.150833), accuracy: Degree(0.000001))
        // argument of latitude = F
        AssertEqual(moon.argumentOfLatitude, Degree(219.889721), accuracy: Degree(0.000001))
        // Distance
        AssertEqual(moon.distance, Kilometer(368409.7), accuracy: Kilometer(0.1))
        // Horizontal Parallax
        AssertEqual(moon.horizontalParallax, Degree(0.991990), accuracy: Degree(0.000001))
    }

    // See AA p.342, Example 47.a
    func testApparentRightAscensionDeclination() {
        
        let jd = JulianDay(2448724.5)
        let moon = Moon(julianDay: jd)
        let eclCoords = moon.eclipticCoordinates
        
        AssertEqual(eclCoords.lambda, Degree(133.167265), accuracy: Degree(0.000001))
        AssertEqual(eclCoords.beta, Degree(-3.229126), accuracy: Degree(0.000001))
        
        // Not entirely satisfied with the accuracy here.
        let equCoords = moon.apparentEquatorialCoordinates
        AssertEqual(equCoords.rightAscension, Hour(.plus, 8, 58, 45.2), accuracy: Second(0.1).inHours)
        AssertEqual(equCoords.declination, Degree(.plus, 13, 46, 6.0), accuracy: ArcSecond(10.0).inDegrees)
    }
    
    // See AA p.345, Example 48.a
    func testIlluminatedFraction() {
        let jd = JulianDay(year: 1992, month: 4, day: 12)
        let moon = Moon(julianDay: jd)

        // Phase angle not as accuracte as one can expect from the book.
        AssertEqual(moon.phaseAngle(), Degree(69.0756), accuracy: Degree(0.002))
        XCTAssertEqualWithAccuracy(moon.illuminatedFraction(), 0.68, accuracy: 0.005)
    }
    
    // See AA p.357, Example 50.a
    func testApogeeTimeAndParallax() {
        let moon = Moon(julianDay: JulianDay(2447442.8191))
        AssertEqual(moon.apogee(true), JulianDay(2447442.3537), accuracy: JulianDay(0.0001))
        XCTAssertEqualWithAccuracy(moon.apogeeParallax(), 3240.679, accuracy: 0.1)
    }
}


