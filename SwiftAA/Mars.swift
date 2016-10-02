//
//  Mars.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public class Mars: Planet {
    fileprivate var physicalDetails: KPCAAPhysicalMarsDetails

    public class override var averageColor: Color {
        get { return Color(red: 0.137, green:0.447, blue:0.208, alpha: 1.0) }
    }

    public var magnitude: Double {
        get { return KPCAAIlluminatedFraction_MarsMagnitudeAA(self.radiusVector, self.apparentGeocentricDistance, self.phaseAngle) }
    }

    public required init(julianDay: JulianDay, highPrecision: Bool = true) {
        self.physicalDetails = KPCAAPhysicalMars_CalculateDetails(julianDay, highPrecision)
        super.init(julianDay: julianDay, highPrecision: highPrecision)
    }
    
    /// The planetocentric declination of the Earth. When it is positive, the planet' northern pole is tilted towards the Earth
    public var planetocentricDeclinationEarth: Degree {
        return self.physicalDetails.DE
    }

    /// The planetocentric declination of the Sun. When it is positive, the planet' northern pole is tilted towards the Sun
    public var planetocentricDeclinationSun: Degree {
        return self.physicalDetails.DS
    }
}
