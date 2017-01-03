//
//  NumericTypeTests.swift
//  SwiftAA
//
//  Created by Alexander Vasenin on 03/01/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class NumericTypeTests: XCTestCase {

    func testCircularInterval() {
        XCTAssertTrue(Degree(15).isWithinCircularInterval(from: 10, to: 20))
        XCTAssertFalse(Degree(55).isWithinCircularInterval(from: 10, to: 20))
        XCTAssertFalse(Degree(10).isWithinCircularInterval(from: 10, to: 20, isIntervalOpen: true))
        XCTAssertTrue(Degree(15).isWithinCircularInterval(from: 10, to: 20, isIntervalOpen: false))
        XCTAssertTrue(Degree(10).isWithinCircularInterval(from: 340, to: 20))
        XCTAssertTrue(Degree(350).isWithinCircularInterval(from: 340, to: 20))
        XCTAssertFalse(Degree(340).isWithinCircularInterval(from: 340, to: 20, isIntervalOpen: true))
        XCTAssertTrue(Degree(340).isWithinCircularInterval(from: 340, to: 20, isIntervalOpen: false))
    }
    
}


