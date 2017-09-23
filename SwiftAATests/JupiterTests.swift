//
//  JupiterTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 07/03/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class JupiterTests: XCTestCase {
    
    func testAverageColor() {
        XCTAssertNotEqual(Jupiter.averageColor, Color.white)
    }
    
    func testMoonsPresence() {
        let jd = JulianDay(Date())
        XCTAssertEqual(Jupiter(julianDay: jd).moons.count, 4)
    }
}
