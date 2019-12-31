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
public protocol EllipticalPlanetaryDetails: PlanetaryBase {
    /// The details of the planet configuration
    var planetaryDetails: KPCAAEllipticalPlanetaryDetails { get }
    
    /// The details of the object configuration
    var ellipticalObjectDetails: KPCAAEllipticalObjectDetails { get }
 
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
}

public extension EllipticalPlanetaryDetails {
    
    var apparentGeocentricDistance: AstronomicalUnit {
        get { return AstronomicalUnit(self.planetaryDetails.ApparentGeocentricDistance) }
    }
    
    var trueGeocentricDistance: AstronomicalUnit {
        get { return AstronomicalUnit(self.ellipticalObjectDetails.TrueGeocentricDistance) }
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
            let ra = Hour(self.planetaryDetails.ApparentGeocentricRA)
            let dec = Degree(self.planetaryDetails.ApparentGeocentricDeclination)
            return EquatorialCoordinates(alpha: ra,
                                         delta: dec,
                                         epoch: .epochOfTheDate(self.julianDay),
                                         equinox: .meanEquinoxOfTheDate(self.julianDay))
        }
    }
}
