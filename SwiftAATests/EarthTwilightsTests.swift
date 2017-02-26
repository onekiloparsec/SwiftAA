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
    
    func testValidLowAccuracyTwilightNorthernHemisphereWestLongitude() {
        
        let paris = GeographicCoordinates(positivelyWestwardLongitude: Degree(.minus, 2, 21, 0.0),
                                          latitude: Degree(.plus, 48, 52, 0.0),
                                          altitude: Meter(30))
        
        let earth = Earth(julianDay: JulianDay(year: 2017, month: 1, day: 30))
        
        let twilights = earth.twilightsLowAccuracy(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
        
        XCTAssertNotNil(twilights.rise)
        XCTAssertNotNil(twilights.set)
        XCTAssertNil(twilights.error)

        XCTAssertTrue(twilights.rise! < twilights.set!)
    }

    func testValidTwilightSouthernHemisphereWestLongitude() {
        
        let parisSouth = GeographicCoordinates(positivelyWestwardLongitude: Degree(-2.3508333333),
                                               latitude: Degree(-48.8566666667),
                                               altitude: Meter(30))
        
        let earth = Earth(julianDay: JulianDay(year: 2017, month: 1, day: 30))
        
        let twilights = earth.twilightsLowAccuracy(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: parisSouth)
        
        XCTAssertNotNil(twilights.rise)
        XCTAssertNotNil(twilights.set)
        XCTAssertNil(twilights.error)
        
        XCTAssertTrue(twilights.rise! < twilights.set!)
    }
    
    
    
    func testValidTwilightNorthernHemisphereWestLongitude() {
        
        let paris = GeographicCoordinates(positivelyWestwardLongitude: Degree(.minus, 2, 21, 0.0),
                                          latitude: Degree(.plus, 48, 52, 0.0),
                                          altitude: Meter(30))
        
        let accuracy = 0.5.seconds.inDays

        // See http://aa.usno.navy.mil/cgi-bin/aa_rstablew.pl?ID=AA&year=2017&task=4&place=&lon_sign=1&lon_deg=2&lon_min=21&lat_sign=1&lat_deg=48&lat_min=52&tz=0&tz_sign=-1
        // for a reference table for the 2017 year

        var date = JulianDay(year: 2017, month: 1, day: 1).date // january 1st
        var twilights = Earth(julianDay: JulianDay(date)).twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
        AssertEqual(twilights.rise!, JulianDay(year: 2017, month: 1, day: 1, hour: 5, minute: 48, second: 55.0), accuracy: accuracy)
        AssertEqual(twilights.set!,  JulianDay(year: 2017, month: 1, day: 1, hour: 18, minute: 00, second: 25.0), accuracy: accuracy)

//        date = JulianDay(year: 2017, month: 2, day: 1).date // february 1st
//        twilights = Earth(julianDay: JulianDay(date)).twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
//        AssertEqual(twilights.rise!, JulianDay(year: 2017, month: 2, day: 1, hour: 5, minute: 32, second: 55.0), accuracy: accuracy)
//        AssertEqual(twilights.set!,  JulianDay(year: 2017, month: 2, day: 1, hour: 18, minute: 37, second: 25.0), accuracy: accuracy)
//
//        date = JulianDay(year: 2017, month: 3, day: 1).date // march 1st
//        twilights = Earth(julianDay: JulianDay(date)).twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
//        AssertEqual(twilights.rise!, JulianDay(year: 2017, month: 3, day: 1, hour: 5, minute: 48, second: 55.0), accuracy: accuracy)
//        AssertEqual(twilights.set!,  JulianDay(year: 2017, month: 3, day: 1, hour: 18, minute: 00, second: 25.0), accuracy: accuracy)
//
//        date = JulianDay(year: 2017, month: 4, day: 1).date // april 1st
//        twilights = Earth(julianDay: JulianDay(date)).twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
//        AssertEqual(twilights.rise!, JulianDay(year: 2017, month: 4, day: 1, hour: 5, minute: 48, second: 55.0), accuracy: accuracy)
//        AssertEqual(twilights.set!,  JulianDay(year: 2017, month: 4, day: 1, hour: 18, minute: 00, second: 25.0), accuracy: accuracy)
//
//        date = JulianDay(year: 2017, month: 5, day: 1).date // may 1st
//        twilights = Earth(julianDay: JulianDay(date)).twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
//        AssertEqual(twilights.rise!, JulianDay(year: 2017, month: 5, day: 1, hour: 5, minute: 48, second: 55.0), accuracy: accuracy)
//        AssertEqual(twilights.set!,  JulianDay(year: 2017, month: 5, day: 1, hour: 18, minute: 00, second: 25.0), accuracy: accuracy)
//
//        date = JulianDay(year: 2017, month: 6, day: 1).date // june 1st
//        twilights = Earth(julianDay: JulianDay(date)).twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
//        AssertEqual(twilights.rise!, JulianDay(year: 2017, month: 6, day: 1, hour: 5, minute: 48, second: 55.0), accuracy: accuracy)
//        AssertEqual(twilights.set!,  JulianDay(year: 2017, month: 6, day: 1, hour: 18, minute: 00, second: 25.0), accuracy: accuracy)
//
//        date = JulianDay(year: 2017, month: 7, day: 1).date // july 1st
//        twilights = Earth(julianDay: JulianDay(date)).twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
//        AssertEqual(twilights.rise!, JulianDay(year: 2017, month: 7, day: 1, hour: 5, minute: 48, second: 55.0), accuracy: accuracy)
//        AssertEqual(twilights.set!,  JulianDay(year: 2017, month: 7, day: 1, hour: 18, minute: 00, second: 25.0), accuracy: accuracy)
//
//        date = JulianDay(year: 2017, month: 8, day: 1).date // august 1st
//        twilights = Earth(julianDay: JulianDay(date)).twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
//        AssertEqual(twilights.rise!, JulianDay(year: 2017, month: 8, day: 1, hour: 5, minute: 48, second: 55.0), accuracy: accuracy)
//        AssertEqual(twilights.set!,  JulianDay(year: 2017, month: 8, day: 1, hour: 18, minute: 00, second: 25.0), accuracy: accuracy)
//
//        date = JulianDay(year: 2017, month: 9, day: 1).date // september 1st
//        twilights = Earth(julianDay: JulianDay(date)).twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
//        AssertEqual(twilights.rise!, JulianDay(year: 2017, month: 9, day: 1, hour: 5, minute: 48, second: 55.0), accuracy: accuracy)
//        AssertEqual(twilights.set!,  JulianDay(year: 2017, month: 9, day: 1, hour: 18, minute: 00, second: 25.0), accuracy: accuracy)
//
//        date = JulianDay(year: 2017, month: 10, day: 1).date // october 1st
//        twilights = Earth(julianDay: JulianDay(date)).twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
//        AssertEqual(twilights.rise!, JulianDay(year: 2017, month: 10, day: 1, hour: 5, minute: 48, second: 55.0), accuracy: accuracy)
//        AssertEqual(twilights.set!,  JulianDay(year: 2017, month: 10, day: 1, hour: 18, minute: 00, second: 25.0), accuracy: accuracy)
//
//        date = JulianDay(year: 2017, month: 11, day: 1).date // november 1st
//        twilights = Earth(julianDay: JulianDay(date)).twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
//        AssertEqual(twilights.rise!, JulianDay(year: 2017, month: 11, day: 1, hour: 5, minute: 48, second: 55.0), accuracy: accuracy)
//        AssertEqual(twilights.set!,  JulianDay(year: 2017, month: 11, day: 1, hour: 18, minute: 00, second: 25.0), accuracy: accuracy)
//
//        date = JulianDay(year: 2017, month: 12, day: 1).date // december 1st
//        twilights = Earth(julianDay: JulianDay(date)).twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
//        AssertEqual(twilights.rise!, JulianDay(year: 2017, month: 12, day: 1, hour: 5, minute: 48, second: 55.0), accuracy: accuracy)
//        AssertEqual(twilights.set!,  JulianDay(year: 2017, month: 12, day: 1, hour: 18, minute: 00, second: 25.0), accuracy: accuracy)

        
        let gregorianCalendar = Calendar.gregorianGMT

        for _ in 1...365 {
//            let sun = Sun(julianDay: JulianDay(date).midnight+0.5)
//            let horiz = sun.equatorialCoordinates.makeHorizontalCoordinates(with: paris, julianDay: sun.julianDay)
//            print("alt: \(horiz.altitude) \(horiz.azimuth)")
            
            let earth = Earth(julianDay: JulianDay(date))
            
//            print("date: \(date)")

            let twilights = earth.twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
            
            print("dawn: \(twilights.rise?.date) | dusk: \(twilights.set?.date)")
            
            date = gregorianCalendar.date(byAdding: .day, value: 1, to: date)!
        }

//        let earth = Earth(julianDay: JulianDay(year: 2017, month: 1, day: 1))
//
//        let twilights = earth.twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
    }
}


