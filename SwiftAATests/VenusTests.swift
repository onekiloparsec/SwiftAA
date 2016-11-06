//
//  VenusTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation
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

    // See AA p.225
    func testApparentGeocentricCoordinates() {
        // Months going from 1 to 12
        var components = DateComponents()
        components.year = 1992
        components.month = 12
        components.day = 20
        let date = Calendar(identifier: .gregorian).date(from: components)!
        let venus = Venus(julianDay: date.julianDay())
        
        XCTAssertEqualWithAccuracy(venus.planetaryDetails.ApparentGeocentricRA, 21.078181, accuracy: 0.000001)
        XCTAssertEqualWithAccuracy(venus.planetaryDetails.ApparentGeocentricDeclination, -18.88801, accuracy: 0.000001)
    }
    
    
    // See AA p.284
    func testIlluminationFraction() {
        // Months going from 1 to 12
        var components = DateComponents()
        components.year = 1992
        components.month = 12
        components.day = 20
        let date = Calendar(identifier: .gregorian).date(from: components)!
        // Both radius vector are correct. Not Delta! Check.
        let frac = Venus(julianDay: date.julianDay()).illuminatedFraction
        XCTAssertEqualWithAccuracy(frac, 0.647, accuracy: 0.005)
    }

}
