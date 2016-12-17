//
//  IlluminatedFraction.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 26/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public protocol IlluminatedFraction: EllipticalPlanetaryDetails {
    
    // The illuminated fraction of the planet as seen from the Earth. Between 0 and 1
    var illuminatedFraction: Double { get }
    
    /// The magnitude of the planet, which depends on the planet's distance to the Earth,
    /// its distance to the Sun and the phase angle i (Sun-planet-Earth).
    /// Implementation should return the modern American Astronomical Almanac value instead of Mueller's 
    var magnitude: Double { get }
}

public extension IlluminatedFraction {
    var illuminatedFraction: Double {
        get { return KPCAAIlluminatedFraction_IlluminatedFraction(self.phaseAngle.value) }
    }
    
    var magnitude: Double {
        get { return KPCAAIlluminatedFraction_MagnitudeAA(self.planetaryObject,
                                                          self.radiusVector.value,
                                                          self.trueGeocentricDistance.value,
                                                          self.phaseAngle.value) }
    }
}
