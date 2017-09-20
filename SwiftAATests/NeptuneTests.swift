//
//  NeptuneTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 2017-09-20.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class NeptuneTests: XCTestCase {

    func testAverageColor() {
        XCTAssertNotEqual(Neptune.averageColor, Color.white)
    }
}
