//
//  JupiterMoonsTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 2017-09-20.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class JupiterMoonsTests: XCTestCase {

    // See AA p.303 Example 44.a and p.314 Example 44.b
    func testExample() {
        let jupiter = Jupiter(julianDay: JulianDay(2448972.50068))
        
        let ioCoords = jupiter.Io.rectangularCoordinates(true)
        XCTAssertEqualWithAccuracy(ioCoords.X, -3.4502, accuracy: 0.0001)
        XCTAssertEqualWithAccuracy(ioCoords.Y, 0.2137, accuracy: 0.0001)

        let europaCoords = jupiter.Europa.rectangularCoordinates(true)
        XCTAssertEqualWithAccuracy(europaCoords.X, 7.4418, accuracy: 0.0001)
        XCTAssertEqualWithAccuracy(europaCoords.Y, 0.2753, accuracy: 0.0001)

        let ganymedeCoords = jupiter.Ganymede.rectangularCoordinates(true)
        XCTAssertEqualWithAccuracy(ganymedeCoords.X, 1.2011, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(ganymedeCoords.Y, 0.5900, accuracy: 0.0001)

        let callistoCoords = jupiter.Callisto.rectangularCoordinates(true)
        XCTAssertEqualWithAccuracy(callistoCoords.X, 7.0720, accuracy: 0.0001)
        XCTAssertEqualWithAccuracy(callistoCoords.Y, 1.0291, accuracy: 0.001)
    }

}
