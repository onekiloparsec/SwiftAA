//
//  MarsTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 07/03/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class MarsTests: XCTestCase {
    func testAverageColorPresence() {
        XCTAssertNotNil(Mars.averageColor)
    }
}
