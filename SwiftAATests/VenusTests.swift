//
//  VenusTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class VenusTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // See AA p.284
    func testAAIlluminationFraction() {
        // Months going from 0 to 11
        let date = KPCAADate(year: 1992, month: 12, day: 20, usingGregorianCalendar: true)
        let jd = date.Julian()
        // Both radius vector are correct. Not Delta! Check.
        let frac = Venus(julianDay: jd).illuminatedFraction()
        XCTAssertEqualWithAccuracy(frac, 0.647, accuracy: 0.005)
    }

}
