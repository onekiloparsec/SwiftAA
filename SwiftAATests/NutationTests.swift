//
//  NutationTests.swift
//  SwiftAA
//
//  Created by Alexander Vasenin on 24/12/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class NutationTests: XCTestCase {
    
    func testMeanObliquity() { // See AA p.148
        let jd = JulianDay(year: 1987, month: 4, day: 10, hour: 0, minute: 0, second: 0)
        let earth = Earth(julianDay: jd)
        let meanObliquity = earth.obliquityOfEcliptic(mean: true)
        AssertEqual(meanObliquity, Degree(.plus, 23, 26, 27.407), accuracy: ArcSecond(0.01).inDegrees)
    }

    func testTrueObliquity() { // See AA p.148
        let jd = JulianDay(year: 1987, month: 4, day: 10, hour: 0, minute: 0, second: 0)
        let earth = Earth(julianDay: jd)
        let trueObliquity = earth.obliquityOfEcliptic(mean: false)
        AssertEqual(trueObliquity, Degree(.plus, 23, 26, 36.850), accuracy: ArcSecond(0.01).inDegrees)
    }

    func testNutationInLongitude() { // See AA p.148
        let jd = JulianDay(year: 1987, month: 4, day: 10, hour: 0, minute: 0, second: 0)
        let earth = Earth(julianDay: jd)
        AssertEqual(earth.nutationInLongitude, ArcMinute(-3.788), accuracy: ArcMinute(0.0001))
    }

    func testNutationInObliquity() { // See AA p.148
        let jd = JulianDay(year: 1987, month: 4, day: 10, hour: 0, minute: 0, second: 0)
        let earth = Earth(julianDay: jd)
        AssertEqual(earth.nutationInObliquity, ArcMinute(9.44252), accuracy: ArcMinute(0.0001))
    }
}


