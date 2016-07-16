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
    
    // The illuminated fraction of the planet as seen from the Earth. Between 0 and 1
    var illuminatedFraction: Double { get }
}

public extension IlluminatedFraction {
    
    // extremely innefficient. but it works
    var planetaryDetails: KPCAAEllipticalPlanetaryDetails {
        get { return KPCAAElliptical_CalculatePlanetaryDetails(self.julianDay, self.planetaryObject, self.highPrecision) }
    }

    var illuminatedFraction: Double {
        get {
            // Delta = ApparentGeocentricDistance = distance earth-planet
            let Delta = self.planetaryDetails.ApparentGeocentricDistance
            let earth = Earth(julianDay: self.julianDay)
            let phaseAngle = KPCAAIlluminatedFraction_PhaseAngle(self.radiusVector, earth.radiusVector, Delta)
            return KPCAAIlluminatedFraction_IlluminatedFraction(phaseAngle)
        }
    }
}