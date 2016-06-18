//
//  KPCAA3DCoordinateTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class KPCAA3DCoordinateTests: XCTestCase {

    func test3DCoordinatesMaker() {
        let coords = KPCAA3DCoordinateComponentsMake(1.0, 2.0, 3.0)
        XCTAssertTrue(coords.X == 1.0)
        XCTAssertTrue(coords.Y == 2.0)
        XCTAssertTrue(coords.Z == 3.0)
    }
    
    func test3DCoordinatesInitialisation() {
        let coords = KPCAA3DCoordinateComponents()
        XCTAssertTrue(coords.X == 0.0)
        XCTAssertTrue(coords.Y == 0.0)
        XCTAssertTrue(coords.Z == 0.0)
    }

}
