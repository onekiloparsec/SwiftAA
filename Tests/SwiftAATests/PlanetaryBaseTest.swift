//
//  PlanetaryBaseTest.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/12/2016.
//  MIT Licence. See LICENCE file.
//

import XCTest
import AABridge
@testable import SwiftAA

class PlanetaryBaseTest: XCTestCase {
    var jd: JulianDay = 0.0

    func testPlanetBasic() {
        XCTAssertEqual(Planet.averageColor, CelestialColor.white)
    }
    
    func testMercuryTypes() {
        let mercury = Mercury(julianDay: self.jd)
        XCTAssertEqual(mercury.name, "Mercury")
        XCTAssertEqual(mercury.planet, KPCAAPlanetMercury)
        XCTAssertEqual(mercury.planetStrict, KPCAAPlanetStrictMercury)
        XCTAssertEqual(mercury.planetaryObject, KPCPlanetaryObjectMERCURY)
    }

    func testVenusTypes() {
        let venus = Venus(julianDay: self.jd)
        XCTAssertEqual(venus.name, "Venus")
        XCTAssertEqual(venus.planet, KPCAAPlanetVenus)
        XCTAssertEqual(venus.planetStrict, KPCAAPlanetStrictVenus)
        XCTAssertEqual(venus.planetaryObject, KPCPlanetaryObjectVENUS)
    }

    func testEarthTypes() {
        let earth = Earth(julianDay: self.jd)
        XCTAssertEqual(earth.name, "Earth")
        XCTAssertEqual(earth.planet, KPCAAPlanetEarth)
        XCTAssertEqual(earth.planetStrict, KPCAAPlanetStrictEarth)
        XCTAssertEqual(earth.planetaryObject, KPCPlanetaryObjectUNDEFINED) // <-- yes, UNDEFINED.
    }

    func testMarsTypes() {
        let mars = Mars(julianDay: self.jd)
        XCTAssertEqual(mars.name, "Mars")
        XCTAssertEqual(mars.planet, KPCAAPlanetMars)
        XCTAssertEqual(mars.planetStrict, KPCAAPlanetStrictMars)
        XCTAssertEqual(mars.planetaryObject, KPCPlanetaryObjectMARS)
    }

    func testJupiterTypes() {
        let jupiter = Jupiter(julianDay: self.jd)
        XCTAssertEqual(jupiter.name, "Jupiter")
        XCTAssertEqual(jupiter.planet, KPCAAPlanetJupiter)
        XCTAssertEqual(jupiter.planetStrict, KPCAAPlanetStrictJupiter)
        XCTAssertEqual(jupiter.planetaryObject, KPCPlanetaryObjectJUPITER)
    }

    func testSaturnTypes() {
        let saturn = Saturn(julianDay: self.jd)
        XCTAssertEqual(saturn.name, "Saturn")
        XCTAssertEqual(saturn.planet, KPCAAPlanetSaturn)
        XCTAssertEqual(saturn.planetStrict, KPCAAPlanetStrictSaturn)
        XCTAssertEqual(saturn.planetaryObject, KPCPlanetaryObjectSATURN)
    }

    func testUranusTypes() {
        let uranus = Uranus(julianDay: self.jd)
        XCTAssertEqual(uranus.name, "Uranus")
        XCTAssertEqual(uranus.planet, KPCAAPlanetUranus)
        XCTAssertEqual(uranus.planetStrict, KPCAAPlanetStrictUranus)
        XCTAssertEqual(uranus.planetaryObject, KPCPlanetaryObjectURANUS)
    }

    func testNeptuneTypes() {
        let neptune = Neptune(julianDay: self.jd)
        XCTAssertEqual(neptune.name, "Neptune")
        XCTAssertEqual(neptune.planet, KPCAAPlanetNeptune)
        XCTAssertEqual(neptune.planetStrict, KPCAAPlanetStrictNeptune)
        XCTAssertEqual(neptune.planetaryObject, KPCPlanetaryObjectNEPTUNE)
    }

    func testPlutoTypes() {
        let pluto = Pluto(julianDay: self.jd)
        XCTAssertEqual(pluto.name, "Pluto")
        XCTAssertEqual(pluto.planet, KPCAAPlanetPluto)
        XCTAssertEqual(pluto.planetStrict, KPCAAPlanetStrictUndefined) // <-- yes, undefined.
        XCTAssertEqual(pluto.planetaryObject, KPCPlanetaryObjectUNDEFINED) // <-- yes, UNDEFINED.
    }
    
    // See AA, p.270, Example 38.a
    func testPerihelionAphelion() {
        let venus = Venus(julianDay: JulianDay(year: 1978, month: 10, day: 15))
        AssertEqual(venus.perihelion, JulianDay(2443873.704), accuracy: JulianDay(0.001))
    }
    
    // See AA, p.270, Example 38.b
    func testAphelion() {
        let mars = Mars(julianDay: JulianDay(year: 2032, month: 1, day: 1))
        AssertEqual(mars.aphelion, JulianDay(2463530.456), accuracy: JulianDay(0.001))
    }

}
