//
//  ConstantsTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/12/2016.
//  MIT Licence. See LICENCE file.
//

import XCTest
import ObjCAA
@testable import SwiftAA

class ConstantsTests: XCTestCase {
    
    /// That's the Geocentric to Topocentric parallax correction. See AA p280.
    func testParallaxToDistance() {
        let parallax1: ArcSecond = 23.592
        AssertEqual(parallax1.distanceFromEquatorialHorizontalParallax(), AstronomicalUnit(0.37276), accuracy: AstronomicalUnit(0.0005))
    }
    
    func testDistanceToEquatorialHorizontalParallax() {
        let distance1: AstronomicalUnit = 0.37276
        AssertEqual(distance1.equatorialHorizontalParallax(), ArcSecond(23.592), accuracy: ArcSecond(0.0005))
    }
    
    func testEquinox() {
        let date = Date()
        XCTAssertEqual(Equinox.meanEquinoxOfTheDate(date.julianDay).julianDay, date.julianDay)
        XCTAssertEqual(Equinox.standardJ2000.julianDay, StandardEpoch_J2000_0)
        XCTAssertEqual(Equinox.standardB1950.julianDay, StandardEpoch_B1950_0)
        XCTAssertNotNil(String(describing: Equinox.meanEquinoxOfTheDate(date.julianDay)))
    }

    func testEpoch() {
        let date = Date()
        XCTAssertEqual(Epoch.epochOfTheDate(date.julianDay).julianDay, date.julianDay)
        XCTAssertEqual(Epoch.J2000.julianDay, StandardEpoch_J2000_0)
        XCTAssertEqual(Epoch.B1950.julianDay, StandardEpoch_B1950_0)
        XCTAssertNotNil(String(describing: Epoch.epochOfTheDate(date.julianDay)))
    }

    func testPlanet2PlanetaryObject() {
        XCTAssertEqual(KPCPlanetaryObject.fromPlanet(.Mercury), KPCPlanetaryObject.MERCURY)
        XCTAssertEqual(KPCPlanetaryObject.fromPlanet(.Venus), KPCPlanetaryObject.VENUS)
        XCTAssertEqual(KPCPlanetaryObject.fromPlanet(.Earth), KPCPlanetaryObject.UNDEFINED)
        XCTAssertEqual(KPCPlanetaryObject.fromPlanet(.Mars), KPCPlanetaryObject.MARS)
        XCTAssertEqual(KPCPlanetaryObject.fromPlanet(.Jupiter), KPCPlanetaryObject.JUPITER)
        XCTAssertEqual(KPCPlanetaryObject.fromPlanet(.Saturn), KPCPlanetaryObject.SATURN)
        XCTAssertEqual(KPCPlanetaryObject.fromPlanet(.Neptune), KPCPlanetaryObject.NEPTUNE)
        XCTAssertEqual(KPCPlanetaryObject.fromPlanet(.Uranus), KPCPlanetaryObject.URANUS)
        XCTAssertEqual(KPCPlanetaryObject.fromPlanet(.Pluto), KPCPlanetaryObject.UNDEFINED)
    }
    
    func testPlanet2PlanetaryObjectType() {
        XCTAssertTrue(KPCPlanetaryObject.fromPlanet(.Mercury).objectType! is SwiftAA.Mercury.Type)
        XCTAssertTrue(KPCPlanetaryObject.fromPlanet(.Venus).objectType! is SwiftAA.Venus.Type)
        XCTAssertTrue(KPCPlanetaryObject.fromPlanet(.Earth).objectType == nil)
        XCTAssertTrue(KPCPlanetaryObject.fromPlanet(.Mars).objectType! is SwiftAA.Mars.Type)
        XCTAssertTrue(KPCPlanetaryObject.fromPlanet(.Jupiter).objectType! is SwiftAA.Jupiter.Type)
        XCTAssertTrue(KPCPlanetaryObject.fromPlanet(.Saturn).objectType! is SwiftAA.Saturn.Type)
        XCTAssertTrue(KPCPlanetaryObject.fromPlanet(.Neptune).objectType! is SwiftAA.Neptune.Type)
        XCTAssertTrue(KPCPlanetaryObject.fromPlanet(.Uranus).objectType! is SwiftAA.Uranus.Type)
        XCTAssertTrue(KPCPlanetaryObject.fromPlanet(.Pluto).objectType == nil)
    }
    
    func testPlanet2PlanetStrict() {
        XCTAssertEqual(KPCAAPlanetStrict.fromPlanet(.Mercury), KPCAAPlanetStrict.mercury)
        XCTAssertEqual(KPCAAPlanetStrict.fromPlanet(.Venus), KPCAAPlanetStrict.venus)
        XCTAssertEqual(KPCAAPlanetStrict.fromPlanet(.Earth), KPCAAPlanetStrict.earth)
        XCTAssertEqual(KPCAAPlanetStrict.fromPlanet(.Mars), KPCAAPlanetStrict.mars)
        XCTAssertEqual(KPCAAPlanetStrict.fromPlanet(.Jupiter), KPCAAPlanetStrict.jupiter)
        XCTAssertEqual(KPCAAPlanetStrict.fromPlanet(.Saturn), KPCAAPlanetStrict.saturn)
        XCTAssertEqual(KPCAAPlanetStrict.fromPlanet(.Neptune), KPCAAPlanetStrict.neptune)
        XCTAssertEqual(KPCAAPlanetStrict.fromPlanet(.Uranus), KPCAAPlanetStrict.uranus)
        XCTAssertEqual(KPCAAPlanetStrict.fromPlanet(.Pluto), KPCAAPlanetStrict.undefined)
    }

    func testPlanetDescriptions() {
        XCTAssertEqual(String(describing: KPCAAPlanet.Mercury), "Mercury")
        XCTAssertEqual(String(describing: KPCAAPlanet.Venus), "Venus")
        XCTAssertEqual(String(describing: KPCAAPlanet.Earth), "Earth")
        XCTAssertEqual(String(describing: KPCAAPlanet.Mars), "Mars")
        XCTAssertEqual(String(describing: KPCAAPlanet.Jupiter), "Jupiter")
        XCTAssertEqual(String(describing: KPCAAPlanet.Saturn), "Saturn")
        XCTAssertEqual(String(describing: KPCAAPlanet.Neptune), "Neptune")
        XCTAssertEqual(String(describing: KPCAAPlanet.Uranus), "Uranus")
        XCTAssertEqual(String(describing: KPCAAPlanet.Pluto), "Pluto")
        XCTAssertEqual(String(describing: KPCAAPlanet.Undefined), "")
    }
    
    func testPlanetFromString() {
        XCTAssertEqual(KPCAAPlanet.fromString("Mercury"), .Mercury)
        XCTAssertEqual(KPCAAPlanet.fromString("Venus"), .Venus)
        XCTAssertEqual(KPCAAPlanet.fromString("Earth"), .Earth)
        XCTAssertEqual(KPCAAPlanet.fromString("Mars"), .Mars)
        XCTAssertEqual(KPCAAPlanet.fromString("Jupiter"), .Jupiter)
        XCTAssertEqual(KPCAAPlanet.fromString("Saturn"), .Saturn)
        XCTAssertEqual(KPCAAPlanet.fromString("Neptune"), .Neptune)
        XCTAssertEqual(KPCAAPlanet.fromString("Uranus"), .Uranus)
        XCTAssertEqual(KPCAAPlanet.fromString("Pluto"), .Pluto)
        XCTAssertEqual(KPCAAPlanet.fromString(""), .Undefined)
        XCTAssertEqual(KPCAAPlanet.fromString(">??"), .Undefined)
    }
}
