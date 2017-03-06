//
//  EllipticalDetails.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 20/09/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

/// The EllipticalPlanetaryDetails encompasses various elliptical details of solar-system planets.
public protocol EllipticalPlanetaryDetails: PlanetaryBase {
    /// The details of the planet configuration
    var planetaryDetails: KPCAAEllipticalPlanetaryDetails { get }
    
    var ellipticalObjectDetails: KPCAAEllipticalObjectDetails { get }
 
    /// The ApparentGeocentricDistance
    var apparentGeocentricDistance: AstronomicalUnit { get }
    
    /// The TrueGeocentricDistance
    var trueGeocentricDistance: AstronomicalUnit { get }
    
    /// The phase angle, that is the angle (Sun-planet-Earth).
    var phaseAngle: Degree { get }
}

public extension EllipticalPlanetaryDetails {
    
    var apparentGeocentricDistance: AstronomicalUnit {
        get { return AstronomicalUnit(self.planetaryDetails.ApparentGeocentricDistance) }
    }
    
    var trueGeocentricDistance: AstronomicalUnit {
        get { return AstronomicalUnit(self.ellipticalObjectDetails.TrueGeocentricDistance) }
    }
    
    var phaseAngle: Degree {
        get { return Degree(KPCAAIlluminatedFraction_PhaseAngle(self.radiusVector.value,
                                                                Earth(julianDay: self.julianDay).radiusVector.value,
                                                                self.apparentGeocentricDistance.value)) }
    }
}
