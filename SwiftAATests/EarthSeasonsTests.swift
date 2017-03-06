//
//  EarthSeasonsTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/03/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

// Based on AA+ "tests"
class EarthSeasonsTests: XCTestCase {

    func testLengthOfSeason2000() {
        let earth = Earth(julianDay: JulianDay(year: 2000, month: 2, day: 1))
        AssertEqual(earth.lengthOfSeason(.spring, northernHemisphere: true), 92.7586.days, accuracy: 0.0001.days)
        AssertEqual(earth.lengthOfSeason(.spring, northernHemisphere: false), 89.8402.days, accuracy: 0.0001.days)

        AssertEqual(earth.lengthOfSeason(.summer, northernHemisphere: true), 93.6526.days, accuracy: 0.0001.days)
        AssertEqual(earth.lengthOfSeason(.summer, northernHemisphere: false), 88.9953.days, accuracy: 0.0001.days)

        AssertEqual(earth.lengthOfSeason(.autumn, northernHemisphere: true), 89.8402.days, accuracy: 0.0001.days)
        AssertEqual(earth.lengthOfSeason(.autumn, northernHemisphere: false), 92.7586.days, accuracy: 0.0001.days)

        AssertEqual(earth.lengthOfSeason(.winter, northernHemisphere: true), 88.9953.days, accuracy: 0.0001.days)
        AssertEqual(earth.lengthOfSeason(.winter, northernHemisphere: false), 93.6526.days, accuracy: 0.0001.days)
    }
}

