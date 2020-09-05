//
//  AstronomicalObjectTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 2017-09-24.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class AstronomicalObjectTests: XCTestCase {

    func testDummyRadiusVector() {
        let coords = EquatorialCoordinates(alpha: Hour(.plus, 16, 54, 00.14), delta: Degree(.minus, 39, 50, 44.9))
        AssertEqual(AstronomicalObject(name: "GRO J1655-40", coordinates: coords, julianDay: JulianDay(Date())).radiusVector, AstronomicalUnit(-1))
    }

    func testInitFatalError() {
        assertFatalError(expectedMessage: "init(julianDay:highPrecision:) cannot be implemented.") {
            _ = AstronomicalObject(julianDay: JulianDay(Date()), highPrecision: true)
        }
    }
}
