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
        let meanObliquity = obliquityOfEcliptic(julianDay: jd, mean: true)
        AssertEqual(meanObliquity, Degree(23, 26, 27.407), accuracy: ArcSecond(0.01).inDegrees)
        let trueObliquity = obliquityOfEcliptic(julianDay: jd, mean: false)
        AssertEqual(trueObliquity, Degree(23, 26, 36.850), accuracy: ArcSecond(0.01).inDegrees)
    }
    
}


