//
//  AnglesTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 22/02/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class AnglesTests: XCTestCase {
    func testDegreeMinusSignConstructor() {
        XCTAssertEqual(Degree(.minus, 1, 7, 30.0).value, -1.125)
        XCTAssertEqual(Degree(.minus, -1, 7, 30.0).value, -1.125)
        XCTAssertEqual(Degree(.minus, 1, -7, 30.0).value, -1.125)
        XCTAssertEqual(Degree(.minus, 1, 7, -30.0).value, -1.125)
        XCTAssertEqual(Degree(.minus, -1, -7, 30.0).value, -1.125)
        XCTAssertEqual(Degree(.minus, 1, -7, -30.0).value, -1.125)
        XCTAssertEqual(Degree(.minus, -1, 7, -30.0).value, -1.125)
        XCTAssertEqual(Degree(.minus, -1, -7, -30.0).value, -1.125)
    }
    
    func testDegreePlusSignConstructor() {
        XCTAssertEqual(Degree(.plus, 1, 7, 30.0).value, 1.125)
        XCTAssertEqual(Degree(.plus, -1, 7, 30.0).value, 1.125)
        XCTAssertEqual(Degree(.plus, 1, -7, 30.0).value, 1.125)
        XCTAssertEqual(Degree(.plus, 1, 7, -30.0).value, 1.125)
        XCTAssertEqual(Degree(.plus, -1, -7, 30.0).value, 1.125)
        XCTAssertEqual(Degree(.plus, -1, -7, -30.0).value, 1.125)
        XCTAssertEqual(Degree(.plus, -1, 7, -30.0).value, 1.125)
        XCTAssertEqual(Degree(.plus, 1, -7, -30.0).value, 1.125)
    }
    
    func testDegreeMinusZeroSignConstructor() {
        XCTAssertEqual(Degree(.minus, 0, 7, 30.0).value, -0.125)
        XCTAssertEqual(Degree(.minus, 0, -7, 30.0).value, -0.125)
        XCTAssertEqual(Degree(.minus, 0, 7, -30.0).value, -0.125)
        XCTAssertEqual(Degree(.minus, 0, -7, -30.0).value, -0.125)
        XCTAssertEqual(Degree(.minus, 0, 0, 90.0).value, -0.025)
        XCTAssertEqual(Degree(.minus, 0, 0, -90.0).value, -0.025)
    }
    
    func testDegreePlusZeroSignConstructor() {
        XCTAssertEqual(Degree(.plus, 0, 7, 30.0).value, 0.125)
        XCTAssertEqual(Degree(.plus, 0, -7, 30.0).value, 0.125)
        XCTAssertEqual(Degree(.plus, 0, 7, -30.0).value, 0.125)
        XCTAssertEqual(Degree(.plus, 0, -7, -30.0).value, 0.125)
        XCTAssertEqual(Degree(.plus, 0, 0, 90.0).value, 0.025)
        XCTAssertEqual(Degree(.plus, 0, 0, -90.0).value, 0.025)
    }
    
    func testHourSexagesimalTransform() {
        let dplus = Degree(1.125)
        let dplussexagesimal: SexagesimalNotation = (.plus, 1, 7, 30.0)
        XCTAssertTrue(dplus.sexagesimalNotation == dplussexagesimal)
        
        let dminus = Degree(-1.125)
        let dminussexagesimal: SexagesimalNotation = (.minus, 1, 7, 30.0)
        XCTAssertTrue(dminus.sexagesimalNotation == dminussexagesimal)
    }
}
