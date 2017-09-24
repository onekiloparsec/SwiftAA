//
//  PlanetaryPhenomenaTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 16/02/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class PlanetaryPhenomenaTests: XCTestCase {

    // See AA. p.252
    func testMercuryInferiorConjunction() {
        let jd = JulianDay(year: 1993, month: 10, day: 1)
        let mercury = Mercury(julianDay: jd)
        XCTAssertEqualWithAccuracy(mercury.inferiorConjunction(mean: false).value, 2449297.644, accuracy: 0.001)
    }
    
    // See AA. p.252
    func testSaturnConjunction() {
        // We take month = 6, to force looking for first conjunction after beginning of 2015, as in AA book.
        let jd = JulianDay(year: 2125, month: 6, day: 1)
        let saturn = Saturn(julianDay: jd)
        XCTAssertEqualWithAccuracy(saturn.conjunction(mean: false).value, 2497437.903, accuracy: 0.001)
    }
    
    // See AA. p.253 & 254.
    func testMercuryWesternElongation() {
        let jd = JulianDay(year: 1993, month: 11, day: 1)
        let mercury = Mercury(julianDay: jd)
        XCTAssertEqualWithAccuracy(mercury.westernElongation(mean: false).value, 2449314.14, accuracy: 0.002)
        XCTAssertEqualWithAccuracy(mercury.elongationValue(eastern: false).value, 19.7506, accuracy: 0.0001)
    }
    
//    // See AA. p.254.
//    func testMarsStation() {
//        let mars = Mars(julianDay: JulianDay(2450537.510))
//        AssertEqual(mars.station1(), JulianDay(2450566.255))
//    }

}
