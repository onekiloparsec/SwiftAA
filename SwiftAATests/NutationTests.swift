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
    
    func testObliquity() { // See AA p.148
        let jd = JulianDay(year: 1987, month: 4, day: 10, hour: 0, minute: 0, second: 0)
        let earth = Earth(julianDay: jd)
        let meanObliquity = earth.obliquityOfEcliptic(mean: true)
        AssertEqual(meanObliquity, Degree(23, 26, 27.407), accuracy: ArcSecond(0.01).inDegrees)
        let trueObliquity = earth.obliquityOfEcliptic(mean: false)
        AssertEqual(trueObliquity, Degree(23, 26, 36.850), accuracy: ArcSecond(0.01).inDegrees)
    }
    
}


