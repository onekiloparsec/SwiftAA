//
//  SaturnTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 07/03/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class SaturnTests: XCTestCase {
    
    func testAverageColor() {
        XCTAssertNotEqual(Saturn.averageColor, Color.white)
    }

    func testMoonsPresence() {
        let jd = JulianDay(Date())
        XCTAssertEqual(Saturn(julianDay: jd).moons.count, 8)
        XCTAssertNotNil(Saturn(julianDay: jd).ringSystem)
    }
    
    // Assuming AA+ Tests values are correct!
    func testSaturnMoonsDetailsMimas() {
        let jd = JulianDay(2451439.50074)
        let saturn = Saturn(julianDay: jd)
        
        // ------------ Mimas (I)
        
        XCTAssertEqual(saturn.Mimas.inTransit, false)
        XCTAssertEqual(saturn.Mimas.inOccultation, false)
        XCTAssertEqual(saturn.Mimas.inEclipse, false)
        XCTAssertEqual(saturn.Mimas.inShadowTransit, false)
        
        let mimasApparentCoords = saturn.Mimas.rectangularCoordinates()
        XCTAssertEqual(mimasApparentCoords.X, 3.1016926066713597)
        XCTAssertEqual(mimasApparentCoords.Y, -0.20395048965085766)
        XCTAssertEqual(mimasApparentCoords.Z, 0.29545514689493052)

        let mimasTrueCoords = saturn.Mimas.rectangularCoordinates(false)
        XCTAssertEqual(mimasTrueCoords.X, 3.1017342525489839)
        XCTAssertEqual(mimasTrueCoords.Y, -0.20395333469600962)
        XCTAssertEqual(mimasTrueCoords.Z, 0.29545514689493052)

        // ------------ Enceladus (II)
        
        XCTAssertEqual(saturn.Enceladus.inTransit, false)
        XCTAssertEqual(saturn.Enceladus.inTransit, false)
        XCTAssertEqual(saturn.Enceladus.inTransit, false)
        XCTAssertEqual(saturn.Enceladus.inTransit, false)
        
        let enceladusApparentCoords = saturn.Enceladus.rectangularCoordinates()
        XCTAssertEqual(enceladusApparentCoords.X, 3.8233720819374231)
        XCTAssertEqual(enceladusApparentCoords.Y, 0.3181181493094038)
        XCTAssertEqual(enceladusApparentCoords.Z,  -0.8325520387386528)
        
        let enceladusTrueCoords = saturn.Enceladus.rectangularCoordinates(false)
        XCTAssertEqual(enceladusTrueCoords.X, 3.8232138214693565)
        XCTAssertEqual(enceladusTrueCoords.Y, 0.3181056446263969)
        XCTAssertEqual(enceladusTrueCoords.Z, -0.8325520387386528)

        // ------------ Tethys (III)
        
        XCTAssertEqual(saturn.Tethys.inTransit, false)
        XCTAssertEqual(saturn.Tethys.inTransit, false)
        XCTAssertEqual(saturn.Tethys.inTransit, false)
        XCTAssertEqual(saturn.Tethys.inTransit, false)

        let tethysApparentCoords = saturn.Tethys.rectangularCoordinates()
        XCTAssertEqual(tethysApparentCoords.X, 4.0271372473723845)
        XCTAssertEqual(tethysApparentCoords.Y, -1.0612064201626388)
        XCTAssertEqual(tethysApparentCoords.Z, 2.5448808969764265)
        
        let tethysTrueCoords = saturn.Tethys.rectangularCoordinates(false)
        XCTAssertEqual(tethysTrueCoords.X, 4.0275666335179263)
        XCTAssertEqual(tethysTrueCoords.Y, -1.0613339289693595)
        XCTAssertEqual(tethysTrueCoords.Z, 2.5448808969764265)

        // ------------ Dione (IV)

        XCTAssertEqual(saturn.Dione.inTransit, false)
        XCTAssertEqual(saturn.Dione.inTransit, false)
        XCTAssertEqual(saturn.Dione.inTransit, false)
        XCTAssertEqual(saturn.Dione.inTransit, false)

        let dioneApparentCoords = saturn.Dione.rectangularCoordinates()
        XCTAssertEqual(dioneApparentCoords.X, -5.3651595734589526)
        XCTAssertEqual(dioneApparentCoords.Y, -1.1481746511166298)
        XCTAssertEqual(dioneApparentCoords.Z, 3.0044806721031114)
        
        let dioneTrueCoords = saturn.Dione.rectangularCoordinates(false)
        XCTAssertEqual(dioneTrueCoords.X, -5.3659723472927503)
        XCTAssertEqual(dioneTrueCoords.Y, -1.1483375245382277)
        XCTAssertEqual(dioneTrueCoords.Z, 3.0044806721031114)

        // ------------ Rhea (V)

        XCTAssertEqual(saturn.Rhea.inTransit, false)
        XCTAssertEqual(saturn.Rhea.inTransit, false)
        XCTAssertEqual(saturn.Rhea.inTransit, false)
        XCTAssertEqual(saturn.Rhea.inTransit, false)

        let rheaApparentCoords = saturn.Rhea.rectangularCoordinates()
        XCTAssertEqual(rheaApparentCoords.X, -0.97184697130855512)
        XCTAssertEqual(rheaApparentCoords.Y, -3.1360312952377654)
        XCTAssertEqual(rheaApparentCoords.Z, 8.0800626622957648)
        
        let rheaTrueCoords = saturn.Rhea.rectangularCoordinates(false)
        XCTAssertEqual(rheaTrueCoords.X, -0.97244511110908626)
        XCTAssertEqual(rheaTrueCoords.Y, -3.1372276719967886)
        XCTAssertEqual(rheaTrueCoords.Z, 8.0800626622957648)

        // ------------ Titan (VI)
        
        XCTAssertEqual(saturn.Titan.inTransit, false)
        XCTAssertEqual(saturn.Titan.inTransit, false)
        XCTAssertEqual(saturn.Titan.inTransit, false)
        XCTAssertEqual(saturn.Titan.inTransit, false)

        let titanApparentCoords = saturn.Titan.rectangularCoordinates()
        XCTAssertEqual(titanApparentCoords.X, 14.56773539040123)
        XCTAssertEqual(titanApparentCoords.Y, 4.7383746459364717)
        XCTAssertEqual(titanApparentCoords.Z, -12.754798683947845)
        
        let titanTrueCoords = saturn.Titan.rectangularCoordinates(false)
        XCTAssertEqual(titanTrueCoords.X, 14.558800712190623)
        XCTAssertEqual(titanTrueCoords.Y, 4.7355211592204158)
        XCTAssertEqual(titanTrueCoords.Z, -12.754798683947845)

        // ------------ Hyperion (VII)
        
        XCTAssertEqual(saturn.Hyperion.inTransit, false)
        XCTAssertEqual(saturn.Hyperion.inTransit, false)
        XCTAssertEqual(saturn.Hyperion.inTransit, false)
        XCTAssertEqual(saturn.Hyperion.inTransit, false)
        
        let hyperionApparentCoords = saturn.Hyperion.rectangularCoordinates()
        XCTAssertEqual(hyperionApparentCoords.X, -18.001151501311426)
        XCTAssertEqual(hyperionApparentCoords.Y, -5.3281808331284966)
        XCTAssertEqual(hyperionApparentCoords.Z, 15.120922945624717)
        
        let hyperionTrueCoords = saturn.Hyperion.rectangularCoordinates(false)
        XCTAssertEqual(hyperionTrueCoords.X, -18.014172683700167)
        XCTAssertEqual(hyperionTrueCoords.Y, -5.3319847420264441)
        XCTAssertEqual(hyperionTrueCoords.Z, 15.120922945624717)

        // ------------ Iapetus (VIII)
        
        XCTAssertEqual(saturn.Iapetus.inTransit, false)
        XCTAssertEqual(saturn.Iapetus.inTransit, false)
        XCTAssertEqual(saturn.Iapetus.inTransit, false)
        XCTAssertEqual(saturn.Iapetus.inTransit, false)
    
        let iapetusApparentCoords = saturn.Iapetus.rectangularCoordinates()
        XCTAssertEqual(iapetusApparentCoords.X, -48.760383752635377)
        XCTAssertEqual(iapetusApparentCoords.Y, 4.1371660689520686)
        XCTAssertEqual(iapetusApparentCoords.Z, 32.737852943980201)
        
        let iapetusTrueCoords = saturn.Iapetus.rectangularCoordinates(false)
        XCTAssertEqual(iapetusTrueCoords.X, -48.835951923571479)
        XCTAssertEqual(iapetusTrueCoords.Y, 4.1435608547046954)
        XCTAssertEqual(iapetusTrueCoords.Z, 32.737852943980201)
    }
    
    // See AA, p.320, Example 45.a
    func testRingsDetails() {
        let jd = JulianDay(2448972.5)
        let saturn = Saturn(julianDay: jd)
        AssertEqual(saturn.ringSystem.earthCoordinates.latitude, Degree(16.442), accuracy: Degree(0.001))  // B
        AssertEqual(saturn.ringSystem.earthCoordinates.longitude, Degree(149.0663), accuracy: Degree(0.001)) // U2
        AssertEqual(saturn.ringSystem.sunCoordinates.latitude, Degree(14.679), accuracy: Degree(0.001)) // Bdash
        AssertEqual(saturn.ringSystem.sunCoordinates.longitude, Degree(153.2645), accuracy: Degree(0.001)) // U1
        AssertEqual(saturn.ringSystem.saturnicentricSunEarthLongitudesDifference, Degree(4.198), accuracy: Degree(0.001))
        AssertEqual(saturn.ringSystem.northPolePositionAngle, Degree(6.741), accuracy: Degree(0.001))
        AssertEqual(saturn.ringSystem.majorAxis, ArcSecond(35.87), accuracy: ArcSecond(0.1))
        AssertEqual(saturn.ringSystem.minorAxis, ArcSecond(10.15), accuracy: ArcSecond(0.1))
    }
}

