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

/// The BinaryStarOrbitalElements struct encompasses all orbital elements of a binary star.
public struct BinaryStarOrbitalElements {
    /// The revolution (orbital) period
    public private(set) var revolutionPeriod: MeanSolarYear
    /// The time of periastron
    public private(set) var timeOfPeriastron: DecimalYear
    /// The eccentricity of the orbit
    public private(set) var eccentricity: Double
    /// The inclination of the orbit relative to the line of sight.
    public private(set) var inclination: Degree
    /// The semi-major axis of the orbit
    public private(set) var semiMajorAxis: Degree
    /// The position angle of the ascending node
    public private(set) var positionAngleOfAscendingNode: Degree
    /// The longitude of the periastron.
    public private(set) var longitudeOfPeriastron: Degree
    
    /// Convenience accessor for the orbital period.
    public var P: MeanSolarYear { get { return self.revolutionPeriod } }
    /// Convenience accessor for the time of periastron
    public var T: DecimalYear { get { return self.timeOfPeriastron } }
    /// Convenience accessor for the eccentricity
    public var e: Double { get { return self.eccentricity } }
    /// Convenience accessor for the inclination
    public var i: Degree { get { return self.inclination } }
    /// Convenience accessor for the semi-major axis
    public var a: Degree { get { return self.semiMajorAxis } }
    /// Convenience accessor for the position angle of the ascending node
    public var Omega: Degree { get { return self.positionAngleOfAscendingNode } }
    /// Convenience accessor for the longitude of periastron
    public var w: Degree { get { return self.longitudeOfPeriastron } }
}

/// The BinaryStarDetails struct encompasses elements of a binary star.
public struct BinaryStarDetails {
    /// The radius vector
    public private(set) var radiusVector: Degree
    /// The apparent position angle
    public private(set) var apparentPositionAngle: Degree
    /// The angular distance
    public private(set) var angularDistance: Degree
    
    /// Convenience accessor for the radius vector
    public var r: Degree { get { return self.radiusVector } }
    /// Convenience accessor for the apparent position angle
    public var theta: Degree { get { return self.apparentPositionAngle } }
    /// Convenience accessor for the angular distance
    public var rho: Degree { get { return self.angularDistance } }
}

/// Returns the details of a binary star.
///
/// - Parameters:
///   - time: The time at which the details must be computed.
///   - elements: the binary star orbital elements
/// - Returns: The details of a binary star.
public func binaryStarsApparentEccentricityDetails(time: Double, elements: BinaryStarOrbitalElements) -> BinaryStarDetails {
    // Note the semiMajorAxis in expressed in arcseconds.
    let details = KPCAABinaryStar_CalculateDetails(time,
                                                   elements.P,
                                                   elements.T,
                                                   elements.e,
                                                   elements.a.inArcSeconds.value,
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
