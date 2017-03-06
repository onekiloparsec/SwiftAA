//
//  ConstantsTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/12/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class ConstantsTests: XCTestCase {
    
    /// That's the Geocentric to Topocentric parallax correction. See AA p280.
    func testParallaxToDistance() {
        let parallax1: ArcSecond = 23.592
        AssertEqual(parallax1.distance(), AstronomicalUnit(0.37276), accuracy: AstronomicalUnit(0.0005))
    }
    
    func testDistanceToParallax() {
        let distance1: AstronomicalUnit = 0.37276
        AssertEqual(distance1.parallax(), ArcSecond(23.592), accuracy: ArcSecond(0.0005))
    }
    
}
