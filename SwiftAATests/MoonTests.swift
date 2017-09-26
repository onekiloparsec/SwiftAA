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
        // Test accuracies not as good as I expected compared to the book. But note that the apogee parallax is 3240.679 which 
        // is precisely the number of the sum of the term in Table 50.B. There could be a little mistake in the book here.
        AssertEqual(moon.apogee(false), JulianDay(2447442.3537), accuracy: JulianDay(0.001))
        AssertEqual(moon.apogeeParallax(), ArcSecond(3240.679), accuracy: ArcSecond(2.0))
    }
    
    // See AA p.365, Example 51.a
    func testPassageThroughNodes() {
        let moon = Moon(julianDay: JulianDay(year: 1987, month: 5, day: 15))
        AssertEqual(moon.passageThroughAscendingNode(), JulianDay(2446938.76803), accuracy: JulianDay(0.00001))
    }
    
    // See AA p.370, Example 52.a
    func testGreatestDeclinationsNorth() {
        let moon = Moon(julianDay: JulianDay(year: 1988, month: 12, day: 12)) // ~ 1988.95 as in the book
        AssertEqual(moon.dateOfGreatestDeclination(false, northernly: true), JulianDay(2447518.3347), accuracy: JulianDay(0.0001))
        AssertEqual(moon.greatestDeclination(false, northernly: true), Degree(28.1562), accuracy: Degree(0.0001))
    }

    // See AA p.370, Example 52.b
    func testGreatestDeclinationsSouth() {
        let moon = Moon(julianDay: JulianDay(year: 2049, month: 4, day: 20)) // -> k = 659 as in the book
        AssertEqual(moon.dateOfGreatestDeclination(false, northernly: false), JulianDay(2469553.0834), accuracy: JulianDay(0.0001))
        AssertEqual(moon.greatestDeclination(false, northernly: false), Degree(22.1384), accuracy: Degree(0.0001))
    }

    // See AA p.374, Example 53.a
    func testLibrations() {
        let moon = Moon(julianDay: JulianDay(year: 1992, month: 4, day: 12))
        let optical = moon.geocentricOpticalLibration()
        let physical = moon.geocentricPhysicalLibration()
        let total = moon.geocentricTotalLibration()
        
        AssertEqual(optical.longitude, -1.206.degrees, accuracy: 0.005.degrees)
        AssertEqual(optical.latitude, 4.194.degrees, accuracy: 0.005.degrees)
        
        AssertEqual(physical.longitude, -0.025.degrees, accuracy: 0.001.degrees)
        AssertEqual(physical.latitude, 0.006.degrees, accuracy: 0.001.degrees)
        
        AssertEqual(total.longitude, -1.23.degrees, accuracy: 0.01.degrees)
        AssertEqual(total.latitude, 4.20.degrees, accuracy: 0.01.degrees)
        
        AssertEqual(moon.rotationAxisPositionAngle, Degree(15.08), accuracy: Degree(0.01))
    }
    
    // See AA p.377, Example 53.b
    func testSelenographicDetails() {
        let moon = Moon(julianDay: JulianDay(year: 1992, month: 4, day: 12))
        
        let pos = moon.selenographicPositionOfTheSun
        AssertEqual(pos.longitude, Degree(67.89), accuracy: Degree(0.01))
        AssertEqual(pos.latitude, Degree(1.46), accuracy: Degree(0.01))
        AssertEqual(pos.colongitude, Degree(22.11), accuracy: Degree(0.01))
    }
    
    // See AA p.346, Example 48.a
    func testPositionAngleOfBrightLimb() {
        let moon = Moon(julianDay: JulianDay(year: 1992, month: 4, day: 12))
        AssertEqual(moon.positionAngleOfTheBrightLimb(), Degree(285.0), accuracy: Degree(0.1))
    }

    // Based on USNO simulator of Moon image, for the given date. Result is given in full diameter.
    // See http://aa.usno.navy.mil/imagery/disk?body=moon&year=2017&month=9&day=24&hour=11&minute=31
    func testMoonSemiDiameter() {
        let jd = JulianDay(year: 2017, month: 9, day: 24, hour: 11, minute: 31, second: 0.0)
        let moon = Moon(julianDay: jd)
        AssertEqual(moon.geocentricSemiDiameter*2.0, Degree(.plus, 0, 29, 53.2).inArcSeconds, accuracy: ArcSecond(1.0))
        
        let geoCoords = GeographicCoordinates(positivelyWestwardLongitude: 0, latitude: Degree(51.0)) // longitude must be consistent with above.
        AssertEqual(moon.topocentricSemiDiameter(for: geoCoords)*2.0, Degree(.plus, 0, 29, 53.2).inArcSeconds + 5.0.arcseconds, accuracy: ArcSecond(1.0))
    }
    
    // See AA p.377, Example 53.c
    func testSunrise() {
        let jd = JulianDay(year: 1992, month: 4, day: 1)
        let moon = Moon(julianDay: jd)
        let copernicus = SelenographicCoordinates(longitude: -20.0, latitude: 9.7)
        let jdResult = JulianDay(year: 1992, month: 4, day: 11, hour: 19, minute: 0, second: 0)
        AssertEqual(moon.timeOfSunrise(for: copernicus), jdResult, accuracy: JulianDay(0.02))
        // At sunrise, the sun altitude is ~ 0
        AssertEqual(Moon(julianDay: jdResult).altitudeOfTheSun(for: copernicus), Degree(0.0), accuracy: Degree(0.2))
    }
    
    func testLongitudeMeanPerigeeAscendingNode() {
        let moon = Moon(julianDay: JulianDay(year: 1992, month: 4, day: 1))
        AssertEqual(moon.longitudeOfMeanPerigee, Degree(127.914), accuracy: Degree(0.1))
        AssertEqual(moon.longitudeOfMeanAscendingNode, Degree(274.983), accuracy: Degree(0.1))
        AssertEqual(moon.longitudeOfTrueAscendingNode, Degree(274.806), accuracy: Degree(0.1))
    }
}


