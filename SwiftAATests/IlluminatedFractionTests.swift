//
//  IlluminatedFractionTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 16/02/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class IlluminatedFractionTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // See AA. p.284
    func testFractionVenus() {
        let jd = JulianDay(year: 1992, month: 12, day: 20)
        let venus = Venus(julianDay: jd)
        XCTAssertEqualWithAccuracy(venus.illuminatedFraction, 0.647, accuracy: 0.001)
    }
    
    // See AA. p.285
    func testMagnitudeMullerVenus() {
        let jd = JulianDay(year: 1992, month: 12, day: 20)
        let venus = Venus(julianDay: jd)
        XCTAssertEqualWithAccuracy(venus.magnitudeMuller.value, -3.8, accuracy: 0.05)
    }
    
    func testMagnitudeVenus() {
        let jd = JulianDay(year: 1992, month: 12, day: 20)
        let venus = Venus(julianDay: jd)
        XCTAssertEqualWithAccuracy(venus.magnitude.value, -4.2, accuracy: 0.05)
    }
    
    // See AA. p.286
    func testMagnitudeSaturn() {
        let jd = JulianDay(year: 1992, month: 12, day: 16)
        let saturn = Saturn(julianDay: jd)
        XCTAssertEqualWithAccuracy(saturn.magnitudeMuller.value, 0.9, accuracy: 0.05)
        // Magnitude (not Muller) is using Astronomical Almanacs algorithm.
        XCTAssertEqualWithAccuracy(saturn.magnitude.value, 0.75, accuracy: 0.05)
    }
}
