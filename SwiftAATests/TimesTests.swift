//
//  TimesTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 20/02/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class TimesTests: XCTestCase {
    // Still not sure on how to handle this sexagesimal input validation.
    func testHourMultipleSignConstructor() {
        XCTAssertEqual(Hour(-1.0, 6.0, 90.0).value, -0.875)
    }
}
