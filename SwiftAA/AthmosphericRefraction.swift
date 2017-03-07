//
//  Refraction.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 02/10/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation


/// Compute the atmospheric refraction from the apparent altitude of a celestial body h0 that has been already measured,
/// and from which one must substract R to find the true altitude h.
///
/// - parameter h0:          The apparent altitude
/// - parameter pressure:    The atmospheric pressure at Earth's surface
/// - parameter temperature: The air temperature at Earth's surface
///
/// - returns: The refraction amplitude, in arcminutes.
public func refraction(fromApparentAltitude h0: Degree, pressure: Millibar = 1010, temperature: Celsius = 10) -> ArcMinute {
    // AA returns a value in Degrees
    return Degree(KPCAARefraction_RefractionFromApparentWithAltitude(h0.value, pressure, temperature)).inArcMinutes
}

/// Compute the atmospheric refraction from the true "airless" altitude of a celestial body h that has been already
/// calculated, and from which one must add R to find the apparent altitude h0.
///
/// - parameter h:           The true altitude
/// - parameter pressure:    The atmospheric pressure at Earth's surface
/// - parameter temperature: The air temperature at Earth's surface
///
/// - returns: The refraction amplitude, in arcminutes.
public func refraction(fromTrueAltitude h: Degree, pressure: Millibar = 1010, temperature: Celsius = 10) -> ArcMinute {
    // AA returns a value in Degrees
    return Degree(KPCAARefraction_RefractionFromTrueWithAltitude(h.value, pressure, temperature)).inArcMinutes
}
