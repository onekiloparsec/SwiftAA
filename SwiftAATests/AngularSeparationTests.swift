//
//  AngularSeparationTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 25/02/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class AngularSeparationTests: XCTestCase {

    // See AA. p110
    func testAngularSeparation1() {
        let alphaBoo = EquatorialCoordinates(rightAscension: Hour(.plus, 14, 15, 39.7), declination: Degree(.plus, 19, 10, 57.0))
        let alphaVir = EquatorialCoordinates(rightAscension: Hour(.plus, 13, 25, 11.6), declination: Degree(.minus, 11, 09, 41.0))
        
        AssertEqual(alphaBoo.angularSeparation(from: alphaVir), 32.7930.degrees, accuracy: 0.0001.degrees)
    }
}
