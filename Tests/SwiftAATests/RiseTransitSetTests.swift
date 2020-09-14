//
//  RiseTransitSetTests.swift
//  SwiftAA
//
//  Created by Alexander Vasenin on 24/12/2016.
//  MIT Licence. See LICENCE file.
//

import XCTest
@testable import SwiftAA

class RiseTransitSetTests: XCTestCase {
    
    let moscow = GeographicCoordinates(positivelyWestwardLongitude: -37.615559, latitude: 55.752220)
    let boston = GeographicCoordinates(positivelyWestwardLongitude: 71.0833, latitude: 42.3333)
    
    func testVenusAtBoston1988() { // See AA p.103
        let venus = Venus(julianDay: JulianDay(year: 1988, month: 3, day: 20, hour: 0, minute: 0, second: 0))
        
        let details = RiseTransitSetTimes(celestialBody: venus, geographicCoordinates: boston)
        
        let accuracy = Minute(2.0).inJulianDays
        let expectedRise = JulianDay(year: 1988, month: 03, day: 20, hour: 12, minute: 25)
        AssertEqual(details.riseTime!, expectedRise, accuracy: accuracy)
        let expectedTransit = JulianDay(year: 1988, month: 03, day: 20, hour: 19, minute: 41)
        AssertEqual(details.transitTime!, expectedTransit, accuracy: accuracy)
        let expectedSet = JulianDay(year: 1988, month: 03, day: 20, hour: 2, minute: 55)
        AssertEqual(details.setTime!, expectedSet, accuracy: accuracy)
    }
    
    func testVenusAtBoston2017() { // See http://aa.usno.navy.mil/data/docs/mrst.php
        let sexagesimalLongitude = boston.longitude.inHours.sexagesimal
        let venus = Venus(julianDay: JulianDay(year: 2017, month: 3, day: 20, hour: 0 + sexagesimalLongitude.radical, minute: sexagesimalLongitude.minute, second: sexagesimalLongitude.second))
        
        let details = RiseTransitSetTimes(celestialBody: venus, geographicCoordinates: boston)
        
        let accuracy = Minute(2.0).inJulianDays
        let expectedRise = JulianDay(year: 2017, month: 03, day: 20, hour: 10, minute: 24)
        AssertEqual(details.riseTime!, expectedRise, accuracy: accuracy)
        let expectedTransit = JulianDay(year: 2017, month: 03, day: 20, hour: 17, minute: 06)
        AssertEqual(details.transitTime!, expectedTransit, accuracy: accuracy)
        let expectedSet = JulianDay(year: 2017, month: 03, day: 20, hour: 23, minute: 48)
        AssertEqual(details.setTime!, expectedSet, accuracy: accuracy)
    }
    
    
    func testVenusAtMoscow2016() { // Data from SkySafari
        let venus = Venus(julianDay: JulianDay(year: 2016, month: 12, day: 27, hour: 6, minute: 29, second: 55))
        
        let details = RiseTransitSetTimes(celestialBody: venus, geographicCoordinates: moscow)
        
        let accuracy = Minute(2.0).inJulianDays
        let expectedRise = JulianDay(year: 2016, month: 12, day: 27, hour: 8, minute: 18, second: 13)
        AssertEqual(details.riseTime!, expectedRise, accuracy: accuracy)
        let expectedTransit = JulianDay(year: 2016, month: 12, day: 27, hour: 12, minute: 45, second: 0)
        AssertEqual(details.transitTime!, expectedTransit, accuracy: accuracy)
        let expectedSet = JulianDay(year: 2016, month: 12, day: 27, hour: 17, minute: 12, second: 50)
        AssertEqual(details.setTime!, expectedSet, accuracy: accuracy)
    }
    
    func testSunAtMoscow2016() { // Data from SkySafari
        let sun = Sun(julianDay: JulianDay(year: 2016, month: 12, day: 27, hour: 3, minute: 1, second: 34))
        
        let details = RiseTransitSetTimes(celestialBody: sun, geographicCoordinates: moscow)
        
        let accuracy = Minute(2.0).inJulianDays
        let expectedRise = JulianDay(year: 2016, month: 12, day: 27, hour: 5, minute: 58, second: 24)
        AssertEqual(details.riseTime!, expectedRise, accuracy: accuracy)
        let expectedTransit = JulianDay(year: 2016, month: 12, day: 27, hour: 9, minute: 29, second: 41)
        AssertEqual(details.transitTime!, expectedTransit, accuracy: accuracy)
        let expectedSet = JulianDay(year: 2016, month: 12, day: 27, hour: 13, minute: 1, second: 6)
        AssertEqual(details.setTime!, expectedSet, accuracy: accuracy)
    }
    
    // Not sure we can trust data from SkySafari
    //    func testMoonAtMoscow2016() { // Data from SkySafari
    //        let moon = Moon(julianDay: JulianDay(year: 2016, month: 12, day: 27, hour: 23, minute: 10, second: 14))
    //        let details = RiseTransitSetTimes(celestialBody: moon, geographicCoordinates: moscow)
    //        let accuracy = Minute(10.0).inJulianDays
    //        let expectedRise = JulianDay(year: 2016, month: 12, day: 27, hour: 3, minute: 38, second: 32)+1
    //        AssertEqual(details.riseTime!, expectedRise, accuracy: accuracy)
    //        let expectedTransit = JulianDay(year: 2016, month: 12, day: 27, hour: 7, minute: 57, second: 43)+1
    //        AssertEqual(details.transitTime!, expectedTransit, accuracy: accuracy)
    //        let expectedSet = JulianDay(year: 2016, month: 12, day: 27, hour: 12, minute: 12, second: 46)+1
    //        AssertEqual(details.setTime!, expectedSet, accuracy: accuracy)
    //    }
    
    // See https://github.com/onekiloparsec/SwiftAA/issues/95 for the problem
    // See https://github.com/codebox/star-rise-and-set-times/blob/master/test/spec/calc-spec.js for the test
    func testSiriusInCerroParanalChile() {
        let jd1 = JulianDay(year: 2018, month: 1, day: 1, hour: 12, minute: 0, second: 0)
        let jd2 = JulianDay(year: 2018, month: 6, day: 1, hour: 12, minute: 0, second: 0)
        
        let coords = EquatorialCoordinates(rightAscension: Hour(.plus, 6, 45, 9.25), declination: Degree(.minus, 16, 42, 47.3))
        
        let sirius1 = AstronomicalObject(name: "Sirius", coordinates: coords, julianDay:jd1)
        let sirius2 = AstronomicalObject(name: "Sirius", coordinates: coords, julianDay:jd2)
        
        let paranal = GeographicCoordinates(positivelyWestwardLongitude: Degree(24.627222),latitude: Degree(-70.404167), altitude: 2400)
        
        let results1 = sirius1.riseTransitSetTimes(for: paranal)
        let results2 = sirius2.riseTransitSetTimes(for: paranal)
        
        XCTAssertNotNil(results1.riseTime)
        XCTAssertNotNil(results1.transitTime)
        XCTAssertNotNil(results1.setTime)
        
        XCTAssertNotNil(results2.riseTime)
        XCTAssertNotNil(results2.transitTime)
        XCTAssertNotNil(results2.setTime)

        XCTAssertNil(results2.transitError)

        //        AssertEqual(results1.riseTime!.date.fractionalHour, Double(22.151388), accuracy: Double(0.001), "")
    }
    
    func testPolarisTtransitErrorAlwaysAbove() {
        let coords = EquatorialCoordinates(rightAscension: Hour(.plus, 2, 31, 47.08), declination: Degree(.plus, 89, 15, 50.9))
        let polaris = AstronomicalObject(name: "Polaris", coordinates: coords, julianDay: JulianDay(year: 2020, month: 9, day: 6))
        let us_coords = GeographicCoordinates(positivelyWestwardLongitude: Degree(.plus, 7, 46, 42), latitude: Degree(.plus, 49, 9, 3), altitude: 210)
        let results = polaris.riseTransitSetTimes(for: us_coords)
        XCTAssertEqual(results.transitError!, CelestialBodyTransitError.alwaysAboveAltitude)
    }
    
    func testPolarisTtransitErrorAlwaysBelow() {
        let coords = EquatorialCoordinates(rightAscension: Hour(.plus, 2, 31, 47.08), declination: Degree(.plus, 89, 15, 50.9))
        let polaris = AstronomicalObject(name: "Polaris", coordinates: coords, julianDay: JulianDay(year: 2020, month: 9, day: 6))
        let paranal = GeographicCoordinates(positivelyWestwardLongitude: Degree(24.627222),latitude: Degree(-70.404167), altitude: 2400)
        let results = polaris.riseTransitSetTimes(for: paranal)
        XCTAssertEqual(results.transitError!, CelestialBodyTransitError.alwaysBelowAltitude)
    }

}


