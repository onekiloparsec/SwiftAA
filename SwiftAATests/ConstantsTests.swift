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

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    /// That's the Geocentric to Topocentric parallax correction. See AA p280.
    func testParallaxToDistance() {
        let parallax1: ArcSecond = 23.592
        XCTAssertEqualWithAccuracy(parallax1.distance(), 0.37276, accuracy: 0.0005)
    }
    
    func testDistanceToParallax() {
        let distance1: AU = 0.37276
        XCTAssertEqualWithAccuracy(distance1.parallax().value, 23.592, accuracy: 0.0005)
    }
}
