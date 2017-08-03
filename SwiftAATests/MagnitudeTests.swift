//
//  MagnitudeTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 27/02/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class MagnitudeTests: XCTestCase {

    func testMagnitudeCombination() {
        let m = SpaceMagnitude(1.0)
        let m1 = SpaceMagnitude(2.0)
        let m2 = SpaceMagnitude(0.0)
        let m3 = SpaceMagnitude(-2.0)
        AssertEqual(m.combine(with: m1),  0.636148, accuracy: 0.000001)
        AssertEqual(m.combine(with: m2), -0.363851, accuracy: 0.000001)
        AssertEqual(m.combine(with: m3), -2.066430, accuracy: 0.000001)
    }

    func testMagnitudeBrightnessRatio() {
        let m = SpaceMagnitude(1.0)
        let m1 = SpaceMagnitude(2.0)
        let m2 = SpaceMagnitude(0.0)
        let m3 = SpaceMagnitude(-2.0)
        XCTAssertEqual(m.brightnessRatio(with: m1), 2.511886, accuracy: 0.000001)
        XCTAssertEqual(m.brightnessRatio(with: m2), 0.398107, accuracy: 0.000001)
        XCTAssertEqual(m.brightnessRatio(with: m3), 0.063095, accuracy: 0.000001)
    }
    
    func testMagnitudeDistance() {
        let m = SpaceMagnitude(14.2)
        let M = SpaceMagnitude(-5.0)
        let Av = SpaceMagnitude(9.2)
        AssertEqual(m.distance(forAbsoluteMagnitude: M, visualAbsorption: Av), 1000.0, accuracy: 1.0) // hé hé hé ... https://arxiv.org/abs/0812.4232
    }
    
    func testMagnitudeDifference() {
        XCTAssertEqual(SpaceMagnitude.magnitudeDifference(forBrightnessRatio: 2.51188643150958),  1.0)
    }
}
