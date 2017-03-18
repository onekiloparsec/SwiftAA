//
//  CelestialBodiesTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 24/02/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class CelestialBodiesTests: XCTestCase {

    func testParalacticAngleBeforeMeridian() {
        // Taken from iObserve airmass plot...
        let jd = JulianDay(year: 2017, month: 6, day: 14, hour: 2, minute: 0, second: 0.0)

        // gro_j1655_40, see below
        let coords = EquatorialCoordinates(alpha: Hour(.plus, 16, 54, 00.14), delta: Degree(.minus, 39, 50, 44.9))        
        let gro_j1655_40 = AstronomicalObject(name: "GRO J1655-40", coordinates: coords, julianDay: jd)
        
        // http://www.ls.eso.org/lasilla/Telescopes/2p2/D1p5M/
        let la_silla_dfosc = GeographicCoordinates(positivelyWestwardLongitude: Degree(.plus, 70, 44, 7.662), latitude: Degree(.minus, 29, 15, 14.235))
        
        // See https://www.eso.org/sci/observing/tools/calendar/ParAng.html to check values.
        let refAngle = -77.6.degrees
        
        AssertEqual(gro_j1655_40.parallacticAngle(for: la_silla_dfosc), refAngle, accuracy: Degree(0.1))
    }

    func testParalacticAngleAfterMeridian() {
        // Taken from iObserve airmass plot...
        let jd = JulianDay(year: 2017, month: 6, day: 14, hour: 6, minute: 0, second: 0.0)
        
        // gro_j1655_40, see below
        let coords = EquatorialCoordinates(alpha: Hour(.plus, 16, 54, 00.14), delta: Degree(.minus, 39, 50, 44.9))
        let gro_j1655_40 = AstronomicalObject(name: "GRO J1655-40", coordinates: coords, julianDay: jd)
        
        // http://www.ls.eso.org/lasilla/Telescopes/2p2/D1p5M/
        let la_silla_dfosc = GeographicCoordinates(positivelyWestwardLongitude: Degree(.plus, 70, 44, 7.662), latitude: Degree(.minus, 29, 15, 14.235))
        
        // See https://www.eso.org/sci/observing/tools/calendar/ParAng.html to check values.
        let refAngle = 74.4.degrees
        
        AssertEqual(gro_j1655_40.parallacticAngle(for: la_silla_dfosc), refAngle, accuracy: Degree(0.1))
    }
}
