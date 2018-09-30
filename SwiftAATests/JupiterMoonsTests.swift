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
    func testJupiterMoonsPositions() {
        let jupiter = Jupiter(julianDay: JulianDay(2448972.50068))
        
        let ioCoords = jupiter.Io.rectangularCoordinates(true)
        XCTAssertEqual(ioCoords.X, -3.4502, accuracy: 0.0001)
        XCTAssertEqual(ioCoords.Y, 0.2137, accuracy: 0.0001)

        let europaCoords = jupiter.Europa.rectangularCoordinates(true)
        XCTAssertEqual(europaCoords.X, 7.4418, accuracy: 0.0001)
        XCTAssertEqual(europaCoords.Y, 0.2753, accuracy: 0.0001)

        let ganymedeCoords = jupiter.Ganymede.rectangularCoordinates(true)
        XCTAssertEqual(ganymedeCoords.X, 1.2011, accuracy: 0.001)
        XCTAssertEqual(ganymedeCoords.Y, 0.5900, accuracy: 0.0001)

        let callistoCoords = jupiter.Callisto.rectangularCoordinates(true)
        XCTAssertEqual(callistoCoords.X, 7.0720, accuracy: 0.0001)
        XCTAssertEqual(callistoCoords.Y, 1.0291, accuracy: 0.001)
    }

    
    // Using AA p.303 Example 44.a for the Date, and values to compare with from AA+ Tests values.
    func testJupiterMoonsDetails() {
        let jupiter = Jupiter(julianDay: JulianDay(2448972.50068))

        XCTAssertEqual(jupiter.Io.MeanLongitude.value, 335.60628391383216)
        XCTAssertEqual(jupiter.Io.TrueLongitude.value, 335.59975218493491)
        XCTAssertEqual(jupiter.Io.TropicalLongitude.value, 336.19977479955691)
        XCTAssertEqual(jupiter.Io.EquatorialLatitude.value, 0.043408227331144397)
        XCTAssertEqual(jupiter.Io.radiusVector.value, 5.929892774580698)
        XCTAssertEqual(jupiter.Io.inTransit, false)
        XCTAssertEqual(jupiter.Io.inOccultation, false)
        XCTAssertEqual(jupiter.Io.inEclipse, false)
        XCTAssertEqual(jupiter.Io.inShadowTransit, false)
        
        XCTAssertEqual(jupiter.Europa.MeanLongitude.value, 62.342123420559801)
        XCTAssertEqual(jupiter.Europa.TrueLongitude.value, 63.442232881905511)
        XCTAssertEqual(jupiter.Europa.TropicalLongitude.value, 64.042255496527517)
        XCTAssertEqual(jupiter.Europa.EquatorialLatitude.value, 0.15654036649066402)
        XCTAssertEqual(jupiter.Europa.radiusVector.value, 9.4037353592618888)
        XCTAssertEqual(jupiter.Europa.inTransit, false)
        XCTAssertEqual(jupiter.Europa.inOccultation, false)
        XCTAssertEqual(jupiter.Europa.inEclipse, false)
        XCTAssertEqual(jupiter.Europa.inShadowTransit, false)

        XCTAssertEqual(jupiter.Ganymede.MeanLongitude.value, 15.710050187888555)
        XCTAssertEqual(jupiter.Ganymede.TrueLongitude.value, 15.750439234543592)
        XCTAssertEqual(jupiter.Ganymede.TropicalLongitude.value, 16.350461849165601)
        XCTAssertEqual(jupiter.Ganymede.EquatorialLatitude.value, -0.22552636666623282)
        XCTAssertEqual(jupiter.Ganymede.radiusVector.value, 15.000197430193158)
        XCTAssertEqual(jupiter.Ganymede.inTransit, false)
        XCTAssertEqual(jupiter.Ganymede.inOccultation, false)
        XCTAssertEqual(jupiter.Ganymede.inEclipse, false)
        XCTAssertEqual(jupiter.Ganymede.inShadowTransit, false)

        XCTAssertEqual(jupiter.Callisto.MeanLongitude.value, 26.191041584184859)
        XCTAssertEqual(jupiter.Callisto.TrueLongitude.value, 26.78207991279487)
        XCTAssertEqual(jupiter.Callisto.TropicalLongitude.value, 27.38210252741688)
        XCTAssertEqual(jupiter.Callisto.EquatorialLatitude.value, -0.14812913785252982)
        XCTAssertEqual(jupiter.Callisto.radiusVector.value, 26.21292147756688)
        XCTAssertEqual(jupiter.Callisto.inTransit, false)
        XCTAssertEqual(jupiter.Callisto.inOccultation, false)
        XCTAssertEqual(jupiter.Callisto.inEclipse, false)
        XCTAssertEqual(jupiter.Callisto.inShadowTransit, false)

    }
}
