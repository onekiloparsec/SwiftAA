//
//  EllipticalDetails.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 20/09/2016.
//  MIT Licence. See LICENCE file.
//

import Foundation
import ObjCAA

/// The EllipticalPlanetaryDetails encompasses various elliptical details of solar-system planets.
public protocol PlanetaryDetails: PlanetaryBase {
    /// The details of the planet configuration
    var allPlanetaryDetails: KPCAAEllipticalPlanetaryDetails { get }
    
    /// The details of the object configuration
    var allObjectDetails: KPCAAEllipticalObjectDetails { get }
    
    /// Useful named accessors:
 
    /// The apparent geocentric distance
    var apparentGeocentricDistance: AstronomicalUnit { get }
    
    /// The true geocentric distance of the planet
    var trueGeocentricDistance: AstronomicalUnit { get }
    
    /// The phase angle, that is the angle (Sun-planet-Earth).
    var phaseAngle: Degree { get }
    
    /// The apparent equatorial coordinates of the planet. That is, its apparent position on the celestial sphere, as
    /// it is actually seen from the center of the moving Earth, and referred to the instantaneous equator, ecliptic
    /// and equinox.
    /// It accounts for 1) the effect of light-time and 2) the effect of the Earth motion. See AA p224.
    var apparentGeocentricEquatorialCoordinates: EquatorialCoordinates { get }
    
    /// The planetocentric declination of the Earth. When it is positive, the planet' northern pole is tilted towards the Earth
    var planetocentricDeclinationOfTheEarth: Degree { get }
    
    /// The planetocentric declination of the Sun. When it is positive, the planet' northern pole is tilted towards the Sun
    var planetocentricDeclinationOfTheSun: Degree { get }
    
    /// The position angle of the northern rotation pole of the planet
    var positionAngleOfNorthernRotationPole: Degree { get }
}

public extension PlanetaryDetails {
    
    var apparentGeocentricDistance: AstronomicalUnit {
        get { return AstronomicalUnit(self.allPlanetaryDetails.ApparentGeocentricDistance) }
    }
    
    var trueGeocentricDistance: AstronomicalUnit {
        get { return AstronomicalUnit(self.allObjectDetails.TrueGeocentricDistance) }
    }
    
    /// The phase angle, that is the angle (Sun-planet-Earth).
    var phaseAngle: Degree {
        get { return Degree(KPCAAIlluminatedFraction_PhaseAngle(self.radiusVector.value,
                                                                Earth(julianDay: self.julianDay).radiusVector.value,
                                                                self.apparentGeocentricDistance.value)) }
    }
    
    /// The apparent equatorial coordinates of the planet. That is, its apparent position on the celestial sphere, as
    /// it is actually seen from the center of the moving Earth, and referred to the instantaneous equator, ecliptic
    /// and equinox.
    /// It accounts for 1) the effect of light-time and 2) the effect of the Earth motion. See AA p224.
    var apparentGeocentricEquatorialCoordinates: EquatorialCoordinates {
        get {
            let ra = Hour(self.allPlanetaryDetails.ApparentGeocentricRA)
            let dec = Degree(self.allPlanetaryDetails.ApparentGeocentricDeclination)
            return EquatorialCoordinates(alpha: ra,
                                         delta: dec,
                                         epoch: .epochOfTheDate(self.julianDay),
                                         equinox: .meanEquinoxOfTheDate(self.julianDay))
        }
    }
}
