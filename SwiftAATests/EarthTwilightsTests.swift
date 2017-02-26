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
    
    
    
    // See http://aa.usno.navy.mil/cgi-bin/aa_rstablew.pl?ID=AA&year=2017&task=4&place=&lon_sign=1&lon_deg=2&lon_min=21&lat_sign=1&lat_deg=48&lat_min=52&tz=0&tz_sign=-1
    // for a table for the 2017 table.
    func testValidTwilightNorthernHemisphereWestLongitude() {
        let accuracy = 1.0.seconds.inDays
        
        let gregorianCalendar = Calendar.gregorianGMT

        let paris = GeographicCoordinates(positivelyWestwardLongitude: Degree(.minus, 2, 21, 0.0),
                                          latitude: Degree(.plus, 48, 52, 0.0),
                                          altitude: Meter(30))
        
        var date = JulianDay(year: 2017, month: 1, day: 1).date
        let earth = Earth(julianDay: JulianDay(date))
        let twilights = earth.twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)

        AssertEqual(twilights.rise!, JulianDay(year: 2017, month: 1, day: 1, hour: 5, minute: 48, second: 55.0), accuracy: accuracy)
        AssertEqual(twilights.set!, JulianDay(year: 2017, month: 1, day: 1, hour: 18, minute: 00, second: 25.0), accuracy: accuracy)
        
        for _ in 1...10 {
//            let sun = Sun(julianDay: JulianDay(date).midnight+0.5)
//            let horiz = sun.equatorialCoordinates.makeHorizontalCoordinates(with: paris, julianDay: sun.julianDay)
//            print("alt: \(horiz.altitude) \(horiz.azimuth)")
            
            let earth = Earth(julianDay: JulianDay(date))
            
            let twilights = earth.twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
            
            if let rise = twilights.rise {
                print("dawn: \(rise.date)")
            } else {
                print("dawn: ---")
            }
            if let set = twilights.set {
                print("dusk: \(set.date)")
            } else {
                print("dusk: ---")
            }
            
            date = gregorianCalendar.date(byAdding: .day, value: 1, to: date)!
        }

//        let earth = Earth(julianDay: JulianDay(year: 2017, month: 1, day: 1))
//        
//        let twilights = earth.twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
    }
}


