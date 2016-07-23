//
//  IlluminatedFraction.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 26/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public protocol IlluminatedFraction: PlanetaryBase {
    // The details of the planet configuration
    var planetaryDetails: KPCAAEllipticalPlanetaryDetails { get }

    /// The ApparentGeocentricDistance
    var apparentGeocentricDistance: Double { get }

    /// The angle (Sun-planet-Earth).
    var phaseAngle: Double { get }
    
    // The illuminated fraction of the planet as seen from the Earth. Between 0 and 1
    var illuminatedFraction: Double { get }
    
    /// The magnitude of the planet, which depends on the planet's distance to the Earth,
    /// its distance to the Sun and the phase angle i (Sun-planet-Earth).
    /// Implementation should return the modern American Astronomical Almanac value instead of Mueller's 
    var magnitude: Double { get }
}

public extension IlluminatedFraction {
    
    // extremely innefficient. but it works
    var planetaryDetails: KPCAAEllipticalPlanetaryDetails {
        get { return KPCAAElliptical_CalculatePlanetaryDetails(self.julianDay, self.planetaryObject, self.highPrecision) }
    }
    
    var apparentGeocentricDistance: Double {
        get { return self.planetaryDetails.ApparentGeocentricDistance }
    }

    var phaseAngle: Double {
        get { return KPCAAIlluminatedFraction_PhaseAngle(self.radiusVector, Earth(julianDay: self.julianDay).radiusVector, self.apparentGeocentricDistance) }
    }
    
    var illuminatedFraction: Double {
        get { return KPCAAIlluminatedFraction_IlluminatedFraction(self.phaseAngle) }
    }
}