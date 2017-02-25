//
//  RefractionTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 25/02/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class RefractionTests: XCTestCase {

    // See AA. p 107
    func testRefractionFromApparentAltitude() {
        AssertEqual(refraction(fromApparentAltitude: 0.5.degrees), 28.754.arcminutes, accuracy: 0.01.arcminutes)
    }

    func testRefractionFromTrueAltitude() {
        AssertEqual(refraction(fromTrueAltitude: 0.5541.degrees), 24.618.arcminutes, accuracy: 0.01.arcminutes)
    }
}
