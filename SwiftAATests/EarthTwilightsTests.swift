//
//  EarthTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 25/01/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class EarthTests: XCTestCase {
    
    func testValidTwilightNorthernHemisphereWestLongitude() {
        
        let paris = GeographicCoordinates(positivelyWestwardLongitude: Degree(.minus, 2, 21, 0.0),
                                          latitude: Degree(.plus, 48, 52, 0.0),
                                          altitude: Meter(30))
        
        let earth = Earth(julianDay: JulianDay(year: 2017, month: 1, day: 30))
        
        let twilights = earth.twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
        
        XCTAssertNotNil(twilights.rise)
        XCTAssertNotNil(twilights.transit)
        XCTAssertNotNil(twilights.set)
        XCTAssertNil(twilights.error)

        XCTAssertTrue(twilights.rise! < twilights.set!)
    }

    func testValidTwilightSouthernHemisphereWestLongitude() {
        
        let parisSouth = GeographicCoordinates(positivelyWestwardLongitude: Degree(-2.3508333333),
                                               latitude: Degree(-48.8566666667),
                                               altitude: Meter(30))
        
        let earth = Earth(julianDay: JulianDay(year: 2017, month: 1, day: 30))
        
        let twilights = earth.twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: parisSouth)
        
        XCTAssertNotNil(twilights.rise)
        XCTAssertNotNil(twilights.transit)
        XCTAssertNotNil(twilights.set)
        XCTAssertNil(twilights.error)
        
        XCTAssertTrue(twilights.rise! < twilights.set!)
    }
    

//    func testPrintTwilights() {
//        var date = JulianDay(year: 2017, month: 1, day: 1).date
//        let paris = GeographicCoordinates(positivelyWestwardLongitude: Degree(.minus, 2, 21, 0.0),
//                                          latitude: Degree(.plus, 48, 52, 0.0),
//                                          altitude: Meter(30))
//
//        let gregorianCalendar = Calendar.gregorianGMT
//
//        for _ in 1...365 {
//
//            let sun = Sun(julianDay: JulianDay(date))
//
//            let riseTransitSetTimes = RiseTransitSetTimes(celestialBody: sun, geographicCoordinates: paris, riseSetAltitude: TwilightSunAltitude.astronomical.rawValue)
//
//            print("dawn: \(riseTransitSetTimes.riseTime?.date) | dusk: \(riseTransitSetTimes.setTime?.date)")
//
//            date = gregorianCalendar.date(byAdding: .day, value: 1, to: date)!
//        }
//    }
    
    
    // See http://aa.usno.navy.mil/cgi-bin/aa_rstablew.pl?ID=AA&year=2017&task=4&place=&lon_sign=1&lon_deg=2&lon_min=21&lat_sign=1&lat_deg=48&lat_min=52&tz=0&tz_sign=-1
    // for a reference table for the 2017 year
    func testValidTwilightNorthernHemisphereWestLongitudeAgainstUSNOReference() {
        
        let paris = GeographicCoordinates(positivelyWestwardLongitude: Degree(.minus, 2, 21, 0.0),
                                          latitude: Degree(.plus, 48, 52, 0.0),
                                          altitude: Meter(30))
        
        let accuracy1 = 1.0.minutes.inJulianDays
        let accuracy2 = 2.0.minutes.inJulianDays
        let accuracy5 = 5.0.minutes.inJulianDays
        let accuracy10 = 10.0.minutes.inJulianDays

        var date = JulianDay(year: 2017, month: 1, day: 1).date // january 1st
        var twilights = Earth(julianDay: JulianDay(date)).twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
        AssertEqual(twilights.rise!, JulianDay(year: 2017, month: 1, day: 1, hour: 5, minute: 48), accuracy: accuracy2)
        AssertEqual(twilights.set!,  JulianDay(year: 2017, month: 1, day: 1, hour: 18, minute: 00), accuracy: accuracy5)

        date = JulianDay(year: 2017, month: 2, day: 1).date // february 1st
        twilights = Earth(julianDay: JulianDay(date)).twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
        AssertEqual(twilights.rise!, JulianDay(year: 2017, month: 2, day: 1, hour: 5, minute: 32), accuracy: accuracy2)
        AssertEqual(twilights.set!,  JulianDay(year: 2017, month: 2, day: 1, hour: 18, minute: 37), accuracy: accuracy10)

        date = JulianDay(year: 2017, month: 3, day: 1).date // march 1st
        twilights = Earth(julianDay: JulianDay(date)).twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
        AssertEqual(twilights.rise!, JulianDay(year: 2017, month: 3, day: 1, hour: 4, minute: 48), accuracy: accuracy2)
        AssertEqual(twilights.set!,  JulianDay(year: 2017, month: 3, day: 1, hour: 19, minute: 19), accuracy: accuracy10)

        date = JulianDay(year: 2017, month: 4, day: 1).date // april 1st
        twilights = Earth(julianDay: JulianDay(date)).twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
        AssertEqual(twilights.rise!, JulianDay(year: 2017, month: 4, day: 1, hour: 3, minute: 37), accuracy: accuracy1)
        AssertEqual(twilights.set!,  JulianDay(year: 2017, month: 4, day: 1, hour: 20, minute: 13), accuracy: accuracy10)

        date = JulianDay(year: 2017, month: 5, day: 1).date // may 1st
        twilights = Earth(julianDay: JulianDay(date)).twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
        AssertEqual(twilights.rise!, JulianDay(year: 2017, month: 5, day: 1, hour: 2, minute: 17), accuracy: accuracy2)
        AssertEqual(twilights.set!,  JulianDay(year: 2017, month: 5, day: 1, hour: 21, minute: 21), accuracy: accuracy10)

        date = JulianDay(year: 2017, month: 6, day: 1).date // june 1st
        twilights = Earth(julianDay: JulianDay(date)).twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
        AssertEqual(twilights.rise!, JulianDay(year: 2017, month: 6, day: 1, hour: 0, minute: 44), accuracy: accuracy2)
        AssertEqual(twilights.set!,  JulianDay(year: 2017, month: 6, day: 1, hour: 22, minute: 56), accuracy: accuracy10)

        date = JulianDay(year: 2017, month: 7, day: 1).date // july 1st
        twilights = Earth(julianDay: JulianDay(date)).twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
        AssertEqual(twilights.rise!, JulianDay(year: 2017, month: 7, day: 1, hour: 0, minute: 3), accuracy: accuracy1)
        AssertEqual(twilights.set!,  JulianDay(year: 2017, month: 7, day: 1, hour: 23, minute: 38), accuracy: accuracy5)

        date = JulianDay(year: 2017, month: 8, day: 1).date // august 1st
        twilights = Earth(julianDay: JulianDay(date)).twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
        AssertEqual(twilights.rise!, JulianDay(year: 2017, month: 8, day: 1, hour: 1, minute: 57), accuracy: accuracy2)
        AssertEqual(twilights.set!,  JulianDay(year: 2017, month: 8, day: 1, hour: 21, minute: 55), accuracy: accuracy5)

        date = JulianDay(year: 2017, month: 9, day: 1).date // september 1st
        twilights = Earth(julianDay: JulianDay(date)).twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
        AssertEqual(twilights.rise!, JulianDay(year: 2017, month: 9, day: 1, hour: 3, minute: 11), accuracy: accuracy2)
        AssertEqual(twilights.set!,  JulianDay(year: 2017, month: 9, day: 1, hour: 20, minute: 28), accuracy: accuracy5)

        date = JulianDay(year: 2017, month: 10, day: 1).date // october 1st
        twilights = Earth(julianDay: JulianDay(date)).twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
        AssertEqual(twilights.rise!, JulianDay(year: 2017, month: 10, day: 1, hour: 4, minute: 5), accuracy: accuracy5)
        AssertEqual(twilights.set!,  JulianDay(year: 2017, month: 10, day: 1, hour: 19, minute: 15), accuracy: accuracy5)

        date = JulianDay(year: 2017, month: 11, day: 1).date // november 1st
        twilights = Earth(julianDay: JulianDay(date)).twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
        AssertEqual(twilights.rise!, JulianDay(year: 2017, month: 11, day: 1, hour: 4, minute: 51), accuracy: accuracy5)
        AssertEqual(twilights.set!,  JulianDay(year: 2017, month: 11, day: 1, hour: 18, minute: 17), accuracy: accuracy5)

        date = JulianDay(year: 2017, month: 12, day: 1).date // december 1st
        twilights = Earth(julianDay: JulianDay(date)).twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
        AssertEqual(twilights.rise!, JulianDay(year: 2017, month: 12, day: 1, hour: 5, minute: 29), accuracy: accuracy5)
        AssertEqual(twilights.set!,  JulianDay(year: 2017, month: 12, day: 1, hour: 17, minute: 50), accuracy: accuracy5)
    }
    
    func testValidTwilightNorthernHemisphereAboveArticCircle() {
        
        // Latitude must be > 66º33'.
        let north = GeographicCoordinates(positivelyWestwardLongitude: Degree(.minus, 2, 21, 0.0),
                                          latitude: Degree(75.0),
                                          altitude: Meter(30))
        
        // Winter
        var earth = Earth(julianDay: JulianDay(year: 2017, month: 1, day: 30))
        var twilights = earth.twilights(forSunAltitude: TwilightSunAltitude.riseAndSet.rawValue, coordinates: north)
        XCTAssertNil(twilights.rise)
        XCTAssertNil(twilights.transit)
        XCTAssertNil(twilights.set)
        XCTAssertTrue(twilights.error == .alwaysBelowAltitude)
        
        // Summer
        earth = Earth(julianDay: JulianDay(year: 2017, month: 7, day: 30))
        twilights = earth.twilights(forSunAltitude: TwilightSunAltitude.riseAndSet.rawValue, coordinates: north)
        XCTAssertNil(twilights.rise)
        XCTAssertNotNil(twilights.transit)
        XCTAssertNil(twilights.set)
        XCTAssertTrue(twilights.error == .alwaysAboveAltitude)
    }

    func testValidTwilightSouthernHemisphereBelowAntarcticCircle() {
        
        // Latitude must be < 66º33'.
        let north = GeographicCoordinates(positivelyWestwardLongitude: Degree(.minus, 2, 21, 0.0),
                                          latitude: Degree(-75.0),
                                          altitude: Meter(30))
        
        // Summer
        var earth = Earth(julianDay: JulianDay(year: 2017, month: 1, day: 30))
        var twilights = earth.twilights(forSunAltitude: TwilightSunAltitude.riseAndSet.rawValue, coordinates: north)
        XCTAssertNil(twilights.rise)
        XCTAssertNotNil(twilights.transit)
        XCTAssertNil(twilights.set)
        XCTAssertTrue(twilights.error == .alwaysAboveAltitude)
        
        // Winter
        earth = Earth(julianDay: JulianDay(year: 2017, month: 7, day: 30))
        twilights = earth.twilights(forSunAltitude: TwilightSunAltitude.riseAndSet.rawValue, coordinates: north)
        XCTAssertNil(twilights.rise)
        XCTAssertNil(twilights.transit)
        XCTAssertNil(twilights.set)
        XCTAssertTrue(twilights.error == .alwaysBelowAltitude)
    }
}


