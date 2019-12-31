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
        XCTAssertNotNil(try! Mercury(julianDay: jd).equatorialSemiDiameter(usingOldValues: true))
        XCTAssertNotNil(try! Venus(julianDay: jd).equatorialSemiDiameter(usingOldValues: true))
        XCTAssertNotNil(try! Mars(julianDay: jd).equatorialSemiDiameter(usingOldValues: true))
        XCTAssertNotNil(try! Jupiter(julianDay: jd).equatorialSemiDiameter(usingOldValues: true))
        XCTAssertNotNil(try! Saturn(julianDay: jd).equatorialSemiDiameter(usingOldValues: true))
        XCTAssertNotNil(try! Uranus(julianDay: jd).equatorialSemiDiameter(usingOldValues: true))
        XCTAssertNotNil(try! Neptune(julianDay: jd).equatorialSemiDiameter(usingOldValues: true))
        
        XCTAssertThrowsError(try Pluto(julianDay: jd).equatorialSemiDiameter(usingOldValues: true))
    }

    func testNewValues() {
        let jd = JulianDay(Date())
        XCTAssertNotNil(try! Mercury(julianDay: jd).equatorialSemiDiameter())
        XCTAssertNotNil(try! Venus(julianDay: jd).equatorialSemiDiameter())
        XCTAssertNotNil(try! Mars(julianDay: jd).equatorialSemiDiameter())
        XCTAssertNotNil(try! Jupiter(julianDay: jd).equatorialSemiDiameter())
        XCTAssertNotNil(try! Saturn(julianDay: jd).equatorialSemiDiameter())
        XCTAssertNotNil(try! Uranus(julianDay: jd).equatorialSemiDiameter())
        XCTAssertNotNil(try! Neptune(julianDay: jd).equatorialSemiDiameter())
        XCTAssertNotNil(try! Pluto(julianDay: jd).equatorialSemiDiameter())
    }
    
    func testEquatorialPolarComparedValues() {
        let jd = JulianDay(Date())
        XCTAssertEqual(try! Mercury(julianDay: jd).equatorialSemiDiameter(), try! Mercury(julianDay: jd).polarSemiDiameter())
        XCTAssertEqual(try! Venus(julianDay: jd).equatorialSemiDiameter(), try! Venus(julianDay: jd).polarSemiDiameter())
        XCTAssertEqual(try! Mars(julianDay: jd).equatorialSemiDiameter(), try! Mars(julianDay: jd).polarSemiDiameter())
        
        XCTAssertNotEqual(try! Jupiter(julianDay: jd).equatorialSemiDiameter(), try! Jupiter(julianDay: jd).polarSemiDiameter())
        XCTAssertNotEqual(try! Saturn(julianDay: jd).equatorialSemiDiameter(), try! Saturn(julianDay: jd).polarSemiDiameter())
        
        XCTAssertEqual(try! Uranus(julianDay: jd).equatorialSemiDiameter(), try! Uranus(julianDay: jd).polarSemiDiameter())
        XCTAssertEqual(try! Neptune(julianDay: jd).equatorialSemiDiameter(), try! Neptune(julianDay: jd).polarSemiDiameter())
    }

}
