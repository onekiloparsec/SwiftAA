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
        XCTAssertEqual(KPCPlanetaryObject.fromPlanet(KPCAAPlanetMercury), KPCPlanetaryObjectMERCURY)
        XCTAssertEqual(KPCPlanetaryObject.fromPlanet(KPCAAPlanetVenus), KPCPlanetaryObjectVENUS)
        XCTAssertEqual(KPCPlanetaryObject.fromPlanet(KPCAAPlanetEarth), KPCPlanetaryObjectUNDEFINED)
        XCTAssertEqual(KPCPlanetaryObject.fromPlanet(KPCAAPlanetMars), KPCPlanetaryObjectMARS)
        XCTAssertEqual(KPCPlanetaryObject.fromPlanet(KPCAAPlanetJupiter), KPCPlanetaryObjectJUPITER)
        XCTAssertEqual(KPCPlanetaryObject.fromPlanet(KPCAAPlanetSaturn), KPCPlanetaryObjectSATURN)
        XCTAssertEqual(KPCPlanetaryObject.fromPlanet(KPCAAPlanetNeptune), KPCPlanetaryObjectNEPTUNE)
        XCTAssertEqual(KPCPlanetaryObject.fromPlanet(KPCAAPlanetUranus), KPCPlanetaryObjectURANUS)
        XCTAssertEqual(KPCPlanetaryObject.fromPlanet(KPCAAPlanetPluto), KPCPlanetaryObjectUNDEFINED)
    }
    
    func testPlanet2PlanetaryObjectType() {
        XCTAssertTrue(KPCPlanetaryObject.fromPlanet(KPCAAPlanetMercury).objectType! is SwiftAA.Mercury.Type)
        XCTAssertTrue(KPCPlanetaryObject.fromPlanet(KPCAAPlanetVenus).objectType! is SwiftAA.Venus.Type)
        XCTAssertTrue(KPCPlanetaryObject.fromPlanet(KPCAAPlanetEarth).objectType == nil)
        XCTAssertTrue(KPCPlanetaryObject.fromPlanet(KPCAAPlanetMars).objectType! is SwiftAA.Mars.Type)
        XCTAssertTrue(KPCPlanetaryObject.fromPlanet(KPCAAPlanetJupiter).objectType! is SwiftAA.Jupiter.Type)
        XCTAssertTrue(KPCPlanetaryObject.fromPlanet(KPCAAPlanetSaturn).objectType! is SwiftAA.Saturn.Type)
        XCTAssertTrue(KPCPlanetaryObject.fromPlanet(KPCAAPlanetNeptune).objectType! is SwiftAA.Neptune.Type)
        XCTAssertTrue(KPCPlanetaryObject.fromPlanet(KPCAAPlanetUranus).objectType! is SwiftAA.Uranus.Type)
        XCTAssertTrue(KPCPlanetaryObject.fromPlanet(KPCAAPlanetPluto).objectType == nil)
    }
    
    func testPlanet2PlanetStrict() {
        XCTAssertEqual(KPCAAPlanetStrict.fromPlanet(KPCAAPlanetMercury), KPCAAPlanetStrictMercury)
        XCTAssertEqual(KPCAAPlanetStrict.fromPlanet(KPCAAPlanetVenus), KPCAAPlanetStrictVenus)
        XCTAssertEqual(KPCAAPlanetStrict.fromPlanet(KPCAAPlanetEarth), KPCAAPlanetStrictEarth)
        XCTAssertEqual(KPCAAPlanetStrict.fromPlanet(KPCAAPlanetMars), KPCAAPlanetStrictMars)
        XCTAssertEqual(KPCAAPlanetStrict.fromPlanet(KPCAAPlanetJupiter), KPCAAPlanetStrictJupiter)
        XCTAssertEqual(KPCAAPlanetStrict.fromPlanet(KPCAAPlanetSaturn), KPCAAPlanetStrictSaturn)
        XCTAssertEqual(KPCAAPlanetStrict.fromPlanet(KPCAAPlanetNeptune), KPCAAPlanetStrictNeptune)
        XCTAssertEqual(KPCAAPlanetStrict.fromPlanet(KPCAAPlanetUranus), KPCAAPlanetStrictUranus)
        XCTAssertEqual(KPCAAPlanetStrict.fromPlanet(KPCAAPlanetPluto), KPCAAPlanetStrictUndefined)
    }

    func testPlanetDescriptions() {
        XCTAssertEqual(String(describing: KPCAAPlanetMercury), "Mercury")
        XCTAssertEqual(String(describing: KPCAAPlanetVenus), "Venus")
        XCTAssertEqual(String(describing: KPCAAPlanetEarth), "Earth")
        XCTAssertEqual(String(describing: KPCAAPlanetMars), "Mars")
        XCTAssertEqual(String(describing: KPCAAPlanetJupiter), "Jupiter")
        XCTAssertEqual(String(describing: KPCAAPlanetSaturn), "Saturn")
        XCTAssertEqual(String(describing: KPCAAPlanetNeptune), "Neptune")
        XCTAssertEqual(String(describing: KPCAAPlanetUranus), "Uranus")
        XCTAssertEqual(String(describing: KPCAAPlanetPluto), "Pluto")
        XCTAssertEqual(String(describing: KPCAAPlanetUndefined), "")
    }
    
    func testPlanetFromString() {
        XCTAssertEqual(KPCAAPlanet.fromString("Mercury"), KPCAAPlanetMercury)
        XCTAssertEqual(KPCAAPlanet.fromString("Venus"), KPCAAPlanetVenus)
        XCTAssertEqual(KPCAAPlanet.fromString("Earth"), KPCAAPlanetEarth)
        XCTAssertEqual(KPCAAPlanet.fromString("Mars"), KPCAAPlanetMars)
        XCTAssertEqual(KPCAAPlanet.fromString("Jupiter"), KPCAAPlanetJupiter)
        XCTAssertEqual(KPCAAPlanet.fromString("Saturn"), KPCAAPlanetSaturn)
        XCTAssertEqual(KPCAAPlanet.fromString("Neptune"), KPCAAPlanetNeptune)
        XCTAssertEqual(KPCAAPlanet.fromString("Uranus"), KPCAAPlanetUranus)
        XCTAssertEqual(KPCAAPlanet.fromString("Pluto"), KPCAAPlanetPluto)
        XCTAssertEqual(KPCAAPlanet.fromString(""), KPCAAPlanetUndefined)
        XCTAssertEqual(KPCAAPlanet.fromString(">??"), KPCAAPlanetUndefined)
    }
}
