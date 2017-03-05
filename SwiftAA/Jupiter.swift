//
//  Jupiter.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

/// The Jupiter planet.
public class Jupiter: Planet {
    public fileprivate(set) lazy var physicalDetails: KPCAAPhysicalJupiterDetails = {
        [unowned self] in
        return KPCAAPhysicalJupiter_CalculateDetails(self.julianDay.value, self.highPrecision)
        }()
    
    /// The average color of the planet.
    public class override var averageColor: Color {
        get { return Color(red: 0.647, green:0.608, blue:0.576, alpha: 1.0) }
    }
    
    public fileprivate(set) var Io: GalileanMoon
    public fileprivate(set) var Europa: GalileanMoon
    public fileprivate(set) var Ganymede: GalileanMoon
    public fileprivate(set) var Callisto: GalileanMoon
    
    public var moons: [GalileanMoon] {
        get { return [self.Io, self.Europa, self.Ganymede, self.Callisto] }
    }

    public required init(julianDay: JulianDay, highPrecision: Bool = true) {
        let details = KPCAAGalileanMoons_CalculateDetails(julianDay.value, highPrecision)
        self.Io = GalileanMoon(name: "Io", details: details.Satellite1)
        self.Europa = GalileanMoon(name: "Europa", details: details.Satellite2)
        self.Ganymede = GalileanMoon(name: "Ganymede", details: details.Satellite3)
        self.Callisto = GalileanMoon(name: "Callisto", details: details.Satellite4)
        
        super.init(julianDay: julianDay, highPrecision: highPrecision)
    }

    public var magnitude: Double {
        get { return KPCAAIlluminatedFraction_JupiterMagnitudeAA(self.radiusVector.value,
                                                                 self.apparentGeocentricDistance.value,
                                                                 self.phaseAngle.value) }
    }

    /// The planetocentric declination of the Earth. When it is positive, the planet' northern pole is tilted towards the Earth
    public var planetocentricDeclinationEarth: Degree {
        return Degree(self.physicalDetails.DE)
    }
    
    /// The planetocentric declination of the Sun. When it is positive, the planet' northern pole is tilted towards the Sun
    public var planetocentricDeclinationSun: Degree {
        return Degree(self.physicalDetails.DS)
    }

    /// See AA. ch 43, pp. 293-
    
    public var geometricCentralMeridianLongitudeSystemI: Degree {
        return Degree(self.physicalDetails.Geometricw1)
    }

    public var geometricCentralMeridianLongitudeSystemII: Degree {
        return Degree(self.physicalDetails.Geometricw2)
    }

    public var apparentCentralMeridianLongitudeSystemI: Degree {
        return Degree(self.physicalDetails.Apparentw1)
    }
    
    public var apparentCentralMeridianLongitudeSystemII: Degree {
        return Degree(self.physicalDetails.Apparentw2)
    }

    /// The position angle of the northern rotation pole of the planet
    public var positionAngleOfNorthernRotationPole: Degree {
        return Degree(self.physicalDetails.P)
    }
}
