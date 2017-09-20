//
//  BinaryStarsTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 2017-09-17.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class BinaryStarsTests: XCTestCase {
    
    var CoronoaeBorealisOrbitalElements: BinaryStarOrbitalElements?
    
    override func setUp() {
        self.CoronoaeBorealisOrbitalElements = BinaryStarOrbitalElements(revolutionPeriod: 41.623,
                                                        timeOfPeriastron: 1934.008,
                                                        eccentricity: 0.2763,
                                                        inclination: 59.025,
                                                        semiMajorAxis: ArcSecond(0.907).inDegrees,
                                                        positionAngleOfAscendingNode: Degree(23.717),
                                                        longitudeOfPeriastron: Degree(219.907))

    }

    func testBinaryStarOrbitalElementsShortGetters() {
        // non=numeri types
        XCTAssertEqual(self.CoronoaeBorealisOrbitalElements!.revolutionPeriod, self.CoronoaeBorealisOrbitalElements!.P)
        XCTAssertEqual(self.CoronoaeBorealisOrbitalElements!.timeOfPeriastron, self.CoronoaeBorealisOrbitalElements!.T)
        XCTAssertEqual(self.CoronoaeBorealisOrbitalElements!.eccentricity, self.CoronoaeBorealisOrbitalElements!.e)
        
        // numeric types
        AssertEqual(self.CoronoaeBorealisOrbitalElements!.inclination, self.CoronoaeBorealisOrbitalElements!.i)
        AssertEqual(self.CoronoaeBorealisOrbitalElements!.semiMajorAxis, self.CoronoaeBorealisOrbitalElements!.a)
        AssertEqual(self.CoronoaeBorealisOrbitalElements!.positionAngleOfAscendingNode, self.CoronoaeBorealisOrbitalElements!.Omega)
        AssertEqual(self.CoronoaeBorealisOrbitalElements!.longitudeOfPeriastron, self.CoronoaeBorealisOrbitalElements!.w)
    }
    
    func testBinaryStarDetails() {
        
        let details = binaryStarDetails(time: 1980.0, elements: self.CoronoaeBorealisOrbitalElements!)
        AssertEqual(details.radiusVector, ArcSecond(0.74557), accuracy: ArcSecond(0.0005))
        AssertEqual(details.apparentPositionAngle, Degree(318.4), accuracy: Degree(0.05))
        AssertEqual(details.angularDistance, ArcSecond(0.411), accuracy: ArcSecond(0.0005))
        
        AssertEqual(details.radiusVector, details.r)
        AssertEqual(details.apparentPositionAngle, details.theta)
        AssertEqual(details.angularDistance, details.rho)
    }
    
    func testCoronoaeBorealisApparentEccentricity() {
        let eccPrime = binaryStarApparentEccentricity(eccentricity: self.CoronoaeBorealisOrbitalElements!.e,
                                                      inclination: self.CoronoaeBorealisOrbitalElements!.i,
                                                      omega: self.CoronoaeBorealisOrbitalElements!.Omega)
        
        XCTAssertEqualWithAccuracy(eccPrime, 0.86, accuracy: 0.01)
    }
}
