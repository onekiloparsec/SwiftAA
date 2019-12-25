//
//  AstronomicalCoordinatesTests.swift
//  SwiftAA
//
//  Created by Alexander Vasenin on 24/12/2016.
//  MIT Licence. See LICENCE file.
//

import XCTest
@testable import SwiftAA

class AstronomicalCoordinatesTests: XCTestCase {
    
    func testEquatorial2Ecliptic() { // p.95
        let equatorial = EquatorialCoordinates(alpha: Hour(.plus, 7, 45, 18.946), delta: Degree(.plus, 28, 1, 34.26))
        let ecliptic = equatorial.makeEclipticCoordinates()
        AssertEqual(ecliptic.lambda, Degree(113.215630), accuracy: ArcSecond(0.01).inDegrees)
        AssertEqual(ecliptic.beta, Degree(6.684170), accuracy: ArcSecond(0.01).inDegrees)
        let eqBack = ecliptic.makeEquatorialCoordinates()
        AssertEqual(eqBack.rightAscension, equatorial.rightAscension, accuracy: ArcSecond(0.01).inHours)
        AssertEqual(eqBack.declination, equatorial.declination, accuracy: ArcSecond(0.01).inDegrees)
    }
    
    func testEquatorial2Horizontal() { // p.95
        let jd = JulianDay(year: 1987, month: 4, day: 10, hour: 19, minute: 21, second: 0)
        let equatorial = EquatorialCoordinates(alpha: Hour(.plus, 23, 9, 16.641), delta: Degree(.minus, 6, 43, 11.61))
        let geographic = GeographicCoordinates(positivelyWestwardLongitude: Degree(.plus, 77, 3, 56.0), latitude: Degree(.plus, 38, 55, 17.0))
        let horizontal = equatorial.makeHorizontalCoordinates(for: geographic, at: jd)
        AssertEqual(horizontal.altitude, Degree(15.1249), accuracy: ArcSecond(5.0).inDegrees)
        AssertEqual(horizontal.azimuth, Degree(68.0337), accuracy: ArcSecond(5.0).inDegrees)
        let eqBack = horizontal.makeEquatorialCoordinates(julianDay: jd)
        AssertEqual(eqBack!.rightAscension, equatorial.rightAscension, accuracy: ArcSecond(0.01).inHours)
        AssertEqual(eqBack!.declination, equatorial.declination, accuracy: ArcSecond(0.01).inDegrees)
    }
    
    func testEquatorial2Galactic() { // p.95
        let equatorial = EquatorialCoordinates(alpha: Hour(.plus, 17, 48, 59.74), delta: Degree(.minus, 14, 43, 8.2), epoch: .B1950)
        let galactic = equatorial.makeGalacticCoordinates()
        AssertEqual(galactic.l, Degree(12.9593), accuracy: ArcSecond(1.0).inDegrees)
        AssertEqual(galactic.b, Degree(6.0463), accuracy: ArcSecond(1.0).inDegrees)
        let eqBack = galactic.makeEquatorialCoordinates()
        AssertEqual(eqBack.rightAscension, equatorial.rightAscension, accuracy: ArcSecond(0.01).inHours)
        AssertEqual(eqBack.declination, equatorial.declination, accuracy: ArcSecond(0.01).inDegrees)
    }
    
    func testHorizontalSeparation() {
        let coords = GeographicCoordinates(positivelyWestwardLongitude: Degree(.plus, 77, 3, 56.0), latitude: Degree(.plus, 38, 55, 17.0))
        let horizontal1 = HorizontalCoordinates(azimuth: 0, altitude: 0, geographicCoordinates: coords, julianDay: JulianDay(Date()))
        let horizontal2 = HorizontalCoordinates(azimuth: 0, altitude: 45, geographicCoordinates: coords, julianDay: JulianDay(Date()))
        let horizontal3 = HorizontalCoordinates(azimuth: 90, altitude: 45, geographicCoordinates: coords, julianDay: JulianDay(Date()))
        AssertEqual(horizontal1.angularSeparation(with: horizontal2), Degree(45), accuracy: ArcSecond(0.0001).inDegrees)
        AssertEqual(horizontal2.angularSeparation(with: horizontal3), Degree(60), accuracy: ArcSecond(0.0001).inDegrees)
        AssertEqual(horizontal3.angularSeparation(with: horizontal1), Degree(90), accuracy: ArcSecond(0.0001).inDegrees)
    }
    
    func testEquatorialCoordinatesDescription() {
        let equatorial = EquatorialCoordinates(alpha: Hour(.plus, 7, 45, 18.946), delta: Degree(.minus, 28, 1, 34.26))
        XCTAssertEqual(String(describing: equatorial), "α=+7h45m18.946s, δ=-28°1'34.260\" (epoch J2000.0, equinox J2000.0)")
    }
    
    func testGalacticCoordinatesDescription() {
        let galactic = GalacticCoordinates(l: Degree(.plus, 7, 45, 18.946), b: Degree(.minus, 28, 1, 34.26))
        XCTAssertEqual(String(describing: galactic), "l=+7°45'18.946\", b=-28°1'34.260\" (epoch J2000.0, equinox J2000.0)")
    }

    func testEclipticCoordinatesDescription() {
        let ecliptic = EclipticCoordinates(lambda: Degree(.plus, 7, 45, 18.946), beta: Degree(.minus, 28, 1, 34.26))
        XCTAssertEqual(String(describing: ecliptic), "λ=+7°45'18.946\", β=-28°1'34.260\" (epoch J2000.0, equinox J2000.0)")
    }

    func testHorizontalCoordinatesDescription() {
        let coords = GeographicCoordinates(positivelyWestwardLongitude: Degree(.plus, 77, 3, 56.0), latitude: Degree(.plus, 38, 55, 17.0))
        let horizontal = HorizontalCoordinates(azimuth: -10.567, altitude: 87.654, geographicCoordinates: coords, julianDay: JulianDay(Date()))
        XCTAssertEqual(String(describing: horizontal), "A=-10°34'01.200\", h=+87°39'14.400\"")
    }

    func testNothBasedAzimuth() {
        let coords = GeographicCoordinates(positivelyWestwardLongitude: Degree(.plus, 77, 3, 56.0), latitude: Degree(.plus, 38, 55, 17.0))
        let horizontal = HorizontalCoordinates(azimuth: -10.567, altitude: 87.654, geographicCoordinates: coords, julianDay: JulianDay(Date()))
        AssertEqual(horizontal.northBasedAzimuth, horizontal.azimuth + 180.0)
    }
    
    // See AA, p.135, Example 21.b
    func testProperMotionAndPrecession() {
        // Default to Epoch J2000.0 and Equinox J2000.0
        let coords0 = EquatorialCoordinates(alpha: Hour(.plus, 2, 44, 11.986), delta: Degree(.plus, 49, 13, 42.48))
        let properMotion = ProperMotion(deltaRightAscension: 0.03425, deltaDeclination: -0.0895)
        
        let newEpochJD = JulianDay(year: 2028, month: 11, day: 13, hour: 4, minute: 33, second: 36.0)
        AssertEqual(newEpochJD, JulianDay(2462088.69))
        
        let coords1 = coords0.shiftedCoordinates(to: .epochOfTheDate(newEpochJD), with: properMotion)
        AssertEqual(coords1.alpha, Hour(.plus, 2, 44, 12.975), accuracy: Second(0.001).inHours)
        AssertEqual(coords1.delta, Degree(.plus, 49, 13, 39.90), accuracy: ArcSecond(0.01).inDegrees)
        AssertEqual(coords1.equinox.julianDay, coords0.equinox.julianDay)
        AssertEqual(coords1.epoch.julianDay, newEpochJD)
        
        let coords2 = coords1.precessedCoordinates(to: .meanEquinoxOfTheDate(newEpochJD))
        AssertEqual(coords2.alpha, Hour(.plus, 2, 46, 11.331), accuracy: Second(0.001).inHours)
        AssertEqual(coords2.delta, Degree(.plus, 49, 20, 54.54), accuracy: ArcSecond(0.01).inDegrees)
        AssertEqual(coords2.equinox.julianDay, newEpochJD)
        AssertEqual(coords2.epoch.julianDay, newEpochJD)
    }
}


