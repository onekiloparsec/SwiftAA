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
    
    func testObliquity() { // p.148
        let date = Calendar.gregorianGMT.date(from: DateComponents(year: 1987, month: 04, day: 10, hour: 00, minute: 00, second: 00))!
        let meanObliquity = obliquityOfEcliptic(julianDay: date.julianDay(), mean: true)
        XCTAssertEqualWithAccuracy(meanObliquity.value, 23.0 + 26.0/60.0 + 27.407/3600.0, accuracy: 0.01/3600.0)
        let trueObliquity = obliquityOfEcliptic(julianDay: date.julianDay(), mean: false)
        XCTAssertEqualWithAccuracy(trueObliquity.value, 23.0 + 26.0/60.0 + 36.850/3600.0, accuracy: 0.01/3600.0)
    }
    
}


