//
//  Mars.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Mars: Planet {
    fileprivate var physicalDetails: KPCAAPhysicalMarsDetails
    
    public static var color: Color {
        get { return Color(red: 0.137, green:0.447, blue:0.208, alpha: 1.0) }
    }
    
    public fileprivate(set) var julianDay: JulianDay
    public fileprivate(set) var highPrecision: Bool
    
    public init(julianDay: JulianDay, highPrecision: Bool = true) {
        self.julianDay = julianDay
        self.highPrecision = highPrecision
        self.physicalDetails = KPCAAPhysicalMars_CalculateDetails(julianDay, highPrecision)
    }
        
    public var magnitude: Double { get { return KPCAAIlluminatedFraction_MarsMagnitudeAA(self.radiusVector, self.apparentGeocentricDistance, self.phaseAngle) } }
    
    /// The planetocentric declination of the Earth. When it is positive, the planet' northern pole is tilted towards the Earth
    public var planetocentricDeclinationEarth: Degrees {
        return self.physicalDetails.DE
    }

    /// The planetocentric declination of the Sun. When it is positive, the planet' northern pole is tilted towards the Sun
    public var planetocentricDeclinationSun: Degrees {
        return self.physicalDetails.DS
    }
}
