//
//  SaturnTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 07/03/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class SaturnTests: XCTestCase {
    
    func testAverageColor() {
        XCTAssertNotEqual(Saturn.averageColor, Color.white)
    }

    func testMoonsPresence() {
        let jd = JulianDay(Date())
        XCTAssertEqual(Saturn(julianDay: jd).moons.count, 7)
        XCTAssertNotNil(Saturn(julianDay: jd).ringSystem)
    }
}
