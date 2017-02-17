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
        let jd = JulianDay(year: 1992, month: 10, day: 1)
        let mercury = Mercury(julianDay: jd)
        XCTAssertEqualWithAccuracy(mercury.inferiorConjunction(true).value, 2449297.644, accuracy: 0.001)
    }
}
