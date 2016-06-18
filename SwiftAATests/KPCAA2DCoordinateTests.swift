//
//  SwiftAATests.swift
//  SwiftAATests
//
//  Created by Cédric Foellmi on 18/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class SwiftAATests: XCTestCase {
    
    func test2DCoordinatesMaker() {
        let coords = KPCAA2DCoordinateComponentsMake(1.0, 2.0)
        XCTAssertTrue(coords.X == 1.0)
        XCTAssertTrue(coords.Y == 2.0)
    }

    func test2DCoordinatesInitialisation() {
        let coords = KPCAA2DCoordinateComponents()
        XCTAssertTrue(coords.X == 0.0)
        XCTAssertTrue(coords.Y == 0.0)
    }

}
