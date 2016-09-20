//
//  EllipticalDetails.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 20/09/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public protocol EllipticalPlanetaryDetails: PlanetaryBase {
    // The details of the planet configuration
    var planetaryDetails: KPCAAEllipticalPlanetaryDetails { get }
    
    var ellipticalObjectDetails: KPCAAEllipticalObjectDetails { get }
 
    /// The ApparentGeocentricDistance
    var apparentGeocentricDistance: AU { get }
    
    /// The TrueGeocentricDistance
    var trueGeocentricDistance: AU { get }
    
    /// The angle (Sun-planet-Earth).
    var phaseAngle: Degrees { get }
}

public extension EllipticalPlanetaryDetails {
    
    var apparentGeocentricDistance: AU {
        get { return self.planetaryDetails.ApparentGeocentricDistance }
    }
    
    var trueGeocentricDistance: AU {
        get { return self.ellipticalObjectDetails.TrueGeocentricDistance }
    }
    
    var phaseAngle: Degrees {
        get { return KPCAAIlluminatedFraction_PhaseAngle(self.radiusVector,
                                                         Earth(julianDay: self.julianDay).radiusVector,
                                                         self.apparentGeocentricDistance) }
    }
}
