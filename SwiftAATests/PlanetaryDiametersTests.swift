//
//  PlanetaryDiametersTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 2017-09-23.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class PlanetaryDiametersTests: XCTestCase {

    func testOldValues() {
        let jd = JulianDay(Date())
        XCTAssertNotNil(Mercury(julianDay: jd).equatorialSemiDiameter(usingOldValues: true))
        XCTAssertNotNil(Venus(julianDay: jd).equatorialSemiDiameter(usingOldValues: true))
        XCTAssertNotNil(Mars(julianDay: jd).equatorialSemiDiameter(usingOldValues: true))
        XCTAssertNotNil(Jupiter(julianDay: jd).equatorialSemiDiameter(usingOldValues: true))
        XCTAssertNotNil(Saturn(julianDay: jd).equatorialSemiDiameter(usingOldValues: true))
        XCTAssertNotNil(Uranus(julianDay: jd).equatorialSemiDiameter(usingOldValues: true))
        XCTAssertNotNil(Neptune(julianDay: jd).equatorialSemiDiameter(usingOldValues: true))
        
        XCTAssertThrowsError(Pluto(julianDay: jd).equatorialSemiDiameter(usingOldValues: true))
    }

    func testNewValues() {
        let jd = JulianDay(Date())
        XCTAssertNotNil(Mercury(julianDay: jd).equatorialSemiDiameter())
        XCTAssertNotNil(Venus(julianDay: jd).equatorialSemiDiameter())
        XCTAssertNotNil(Mars(julianDay: jd).equatorialSemiDiameter())
        XCTAssertNotNil(Jupiter(julianDay: jd).equatorialSemiDiameter())
        XCTAssertNotNil(Saturn(julianDay: jd).equatorialSemiDiameter())
        XCTAssertNotNil(Uranus(julianDay: jd).equatorialSemiDiameter())
        XCTAssertNotNil(Neptune(julianDay: jd).equatorialSemiDiameter())
        XCTAssertNotNil(Pluto(julianDay: jd).equatorialSemiDiameter())
    }
    
    func testEquatorialPolarComparedValues() {
        let jd = JulianDay(Date())
        XCTAssertEqual(Mercury(julianDay: jd).equatorialSemiDiameter(), Mercury(julianDay: jd).polarSemiDiameter())
        XCTAssertEqual(Venus(julianDay: jd).equatorialSemiDiameter(), Mercury(julianDay: jd).polarSemiDiameter())
        XCTAssertEqual(Mars(julianDay: jd).equatorialSemiDiameter(), Mercury(julianDay: jd).polarSemiDiameter())
        
        XCTAssertNotEqual(Jupiter(julianDay: jd).equatorialSemiDiameter(), Mercury(julianDay: jd).polarSemiDiameter())
        XCTAssertNotEqual(Saturn(julianDay: jd).equatorialSemiDiameter(), Mercury(julianDay: jd).polarSemiDiameter())
        
        XCTAssertEqual(Uranus(julianDay: jd).equatorialSemiDiameter(), Mercury(julianDay: jd).polarSemiDiameter())
        XCTAssertEqual(Neptune(julianDay: jd).equatorialSemiDiameter(), Mercury(julianDay: jd).polarSemiDiameter())        
    }

}
