//
//  DistancesTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 2017-09-23.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class DistancesTests: XCTestCase {

    func testBasicConversions() {
        AssertEqual(Kilometer(12345.6789).inMeters, Meter(12345678.9))
        
        AssertEqual(AstronomicalUnit(2.0).inParsecs, Parsec(2.0*AU2pc))
        AssertEqual(AstronomicalUnit(3.0).inMeters, Meter(3.0*AU2m))
        XCTAssertEqual(AstronomicalUnit(4.0).inLightYears, 4.0*AU2ly)
        
        AssertEqual(Meter(2.0).inAstronomicalUnits, AstronomicalUnit(2.0/AU2m))
        AssertEqual(Parsec(3.0).inAstronomicalUnits, AstronomicalUnit(3.0/AU2pc))
    }

}
