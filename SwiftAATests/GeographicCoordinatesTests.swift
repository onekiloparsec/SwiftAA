//
//  GeographicCoordinatesTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/02/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
import CoreLocation
@testable import SwiftAA

class GeographicCoordinatesTests: XCTestCase {
    func testConstructorFromCLLocation() {
        let location = CLLocation(latitude: 10.0, longitude: 20.0)
        let coords = GeographicCoordinates(location)
        XCTAssertEqual(location.coordinate.longitude, -1*coords.longitude.value)
        XCTAssertEqual(location.coordinate.latitude, coords.latitude.value)
    }
    
    func testCLLocationExporter() {
        let location = CLLocation(latitude: 10.0, longitude: 20.0)
        let coords = GeographicCoordinates(location)
        XCTAssertEqual(location.coordinate.longitude, coords.location.coordinate.longitude)
        XCTAssertEqual(location.coordinate.latitude, coords.location.coordinate.latitude)
    }


    // See AA p.84
    func testGlobeRadii() {
        // Roughly Chicago. AA simply uses latitude = 42º.0.
        let chicago = GeographicCoordinates(positivelyWestwardLongitude: Degree(-87.623177), latitude: Degree(42.0))
        XCTAssertEqual(chicago.globeRadiusOfCurvature.value, 6364033.0, accuracy: 10.0)
        XCTAssertEqual(chicago.globeRadiusOfParallelOfLatitude.value, 4747001.0, accuracy: 10.0)
    }

    // See AA p.85
    func testGlobeDistanceBetweenGeographicPoints() {
        let paris = GeographicCoordinates(positivelyWestwardLongitude: Degree(.minus, 2, 20, 14.0), latitude: Degree(.plus, 48, 50, 11.0))
        let washington = GeographicCoordinates(positivelyWestwardLongitude: Degree(.plus, 77, 03, 56), latitude: Degree(.plus, 38, 55, 17.0))
        XCTAssertEqual(paris.globeDistance(to: washington).value, 6181630.0, accuracy: 10.0)
    }
    
    // See AA p.82
    func testRelativeGlobeDistancesToEarthCenter() {
        let palomar = GeographicCoordinates(positivelyWestwardLongitude: Degree(.plus, 116, 51, 54.0), latitude: Degree(.plus, 33, 21, 22.0))
        XCTAssertEqual(palomar.rhoSinThetaPrime(forObserverHeight: 1706.0), 0.546861, accuracy: 0.000001)
        XCTAssertEqual(palomar.rhoCosThetaPrime(forObserverHeight: 1706.0), 0.836339, accuracy: 0.000001)
    }
}
