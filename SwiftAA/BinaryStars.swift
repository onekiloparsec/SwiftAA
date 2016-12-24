//
//  BinaryStars.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/11/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public typealias MeanSolarYear = Double
public typealias DecimalYear = Double

public struct BinaryStarOrbitalElements {
    public private(set) var revolutionPeriod: MeanSolarYear
    public private(set) var timeOfPeriastron: DecimalYear
    public private(set) var eccentricity: Double
    public private(set) var inclination: Degree
    public private(set) var semiMajorAxis: Degree
    public private(set) var positionAngleOfAscendingNode: Degree
    public private(set) var longitudeOfPeriastron: Degree
    
    public var P: MeanSolarYear { get { return self.revolutionPeriod } }
    public var T: DecimalYear { get { return self.timeOfPeriastron } }
    public var e: Double { get { return self.eccentricity } }
    public var i: Degree { get { return self.inclination } }
    public var a: Degree { get { return self.semiMajorAxis } }
    public var Omega: Degree { get { return self.positionAngleOfAscendingNode } }
    public var w: Degree { get { return self.longitudeOfPeriastron } }
}

public struct BinaryStarDetails {
    public private(set) var radiusVector: Degree
    public private(set) var apparentPositionAngle: Degree
    public private(set) var angularDistance: Degree
    
    public var r: Degree { get { return self.radiusVector } }
    public var theta: Degree { get { return self.apparentPositionAngle } }
    public var rho: Degree { get { return self.angularDistance } }
}

public func binaryStarsApparentEccentricityDetails(time: Double, elements: BinaryStarOrbitalElements) -> BinaryStarDetails {
    // Note the semiMajorAxis in expressed in arcseconds.
    let details = KPCAABinaryStar_CalculateDetails(time,
                                                   elements.P,
                                                   elements.T,
                                                   elements.e,
                                                   elements.a.inArcseconds().value,
                                                   elements.i.value,
                                                   elements.Omega.value,
                                                   elements.w.value)
    
    return BinaryStarDetails(radiusVector: Degree(details.r),
                             apparentPositionAngle: Degree(details.Theta),
                             angularDistance: Degree(details.Rho))
}

/// Return the apparent eccentricity of the binary stars orbit.
///
/// - Parameters:
///   - eccentricity: The true orbital eccentricity
///   - inclination: The orbit inclination
///   - omega: The longitude of periastron
/// - Returns: The apparent eccentricity of the orbit, as seen on the sky.
public func binaryStarsApparentEccentricity(eccentricity: Double, inclination: Degree, omega: Degree) -> Double {
    return KPCAABinaryStar_ApparentEccentricity(eccentricity, inclination.value, omega.value)
}
