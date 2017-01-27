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
        
        let paris = GeographicCoordinates(positivelyWestwardLongitude: Degree(-2.3508333333),
                                          latitude: Degree(48.8566666667),
                                          altitude: Meter(30))
        
        let earth = Earth(julianDay: JulianDay(year: 2017, month: 1, day: 30))
        
        let twilights = earth.twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: paris)
        
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
        
        let twilights = earth.twilights(forSunAltitude: TwilightSunAltitude.astronomical.rawValue, coordinates: parisSouth)
        
        XCTAssertNotNil(twilights.rise)
        XCTAssertNotNil(twilights.set)
        XCTAssertNil(twilights.error)
        
        XCTAssertTrue(twilights.rise! < twilights.set!)
    }
}


