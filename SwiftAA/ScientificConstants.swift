//
//  ScientificConstants.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/12/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

/// Constant value substracted from Julian Day to create so-called modified julian days.
public let ModifiedJulianDayZero: Double = 2400000.5

/// The length of Julian Years, in days.
public let JulianYear: Day = 365.25            // See p.133 of AA.
/// The length of Besselian Years, in days.
public let BesselianYear: Day = 365.2421988    // See p.133 of AA.

/// The new standard epoch, as decided by the IAU in 1984.
public let StandardEpoch_J2000_0: JulianDay = 2451545.0 // See p.133 of AA.
public let StandardEpoch_B1950_0: JulianDay = 2433282.4235 // See p.133 of AA.

public typealias Kilogram=Double
public typealias Celsius=Double
public typealias Millibar=Double

/// Standard equinox values. Note: equinoxes are directions, epochs are point in time.
/// The vernal equinox, which is the zero point of both right ascension and celestial longitude, is defined
/// to be in the direction of the ascending node of the ecliptic on the equator.
/// Of course, at the standard epoch of J2000 corresponds to a specific (and thus standard) equinox.
public enum Equinox {
    
    /// The mean equinox of the date is the intersection of the ecliptic of the date with the mean equator of the date.
    case meanEquinoxOfTheDate(Date)
    case standardJ2000
    
    /// The Julian Day of the given equinox.
    var epoch: JulianDay {
        switch self {
        case .meanEquinoxOfTheDate(let date):
            return date.julianDay
        case .standardJ2000:
            return StandardEpoch_J2000_0
        }
    }
}


/// Earth seasons
///
/// - spring: Sprint
/// - summer: Summer
/// - autumn: Authumn
/// - winter: Winter
public enum Season {
    case spring
    case summer
    case autumn
    case winter
}


/// Moon phases
///
/// - new: New Moon
/// - firstQuarter: First Quarter
/// - full: Full Moon
/// - lastQuarter: Last Quarter
public enum MoonPhase {
    case new
    case firstQuarter
    case full
    case lastQuarter
}

/// Error used when computing Rise Transit and Set times (see Earth twilights and planetary rise, transit and set times).
///
/// - alwaysBelowAltitude: The object for which times are computed is always below the given altitude.
/// - alwaysAboveAltitude: The object for which times are computed is always above the given altitude.
public enum CelestialBodyTransitError: Error {
    case alwaysBelowAltitude
    case alwaysAboveAltitude
}

// Check nested types in https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Extensions.html


extension KPCAAPlanet: CustomStringConvertible {
    public static func fromString(_ string: String) -> KPCAAPlanet {
        if string == "Mercury" {
            return .Mercury
        }
        else if string == "Venus" {
            return .Venus
        }
        else if string == "Earth" {
            return .Earth
        }
        else if string == "Mars" {
            return .Mars
        }
        else if string == "Jupiter" {
            return .Jupiter
        }
        else if string == "Saturn" {
            return .Saturn
        }
        else if string == "Uranus" {
            return .Uranus
        }
        else if string == "Neptune" {
            return .Neptune
        }
        else if string == "Pluto" {
            return .Pluto
        }
        else {
            return .Undefined
        }
    }
    
    public var description: String {
        switch self {
        case .Mercury:
            return "Mercury"
        case .Venus:
            return "Venus"
        case .Earth:
            return "Earth"
        case .Mars:
            return "Mars"
        case .Jupiter:
            return "Jupiter"
        case .Saturn:
            return "Saturn"
        case .Uranus:
            return "Uranus"
        case .Neptune:
            return "Neptune"
        case .Pluto:
            return "Pluto"
        case .Undefined:
            return ""
        }
    }
}

// Tricky Swiftness tricks to use the 3 partly-overlapping enums with as few
// code lines as possible. There must be some other way round to force correct
// planet enum parameters in Obj-C functions. The code here is the consequence of
// choosing to make switch statments inside Obj-C layer, rather than in Swift one.

public extension KPCAAPlanetStrict {
    static func fromPlanet(_ planet: KPCAAPlanet) -> KPCAAPlanetStrict {
        switch planet {
        case .Pluto:
            return .undefined
        default:
            return KPCAAPlanetStrict(rawValue: planet.rawValue)!
        }
    }
}

public extension KPCPlanetaryObject {
    /// Returns the planetary object index from a given planet index.
    ///
    /// - Parameter planet: The planet index.
    /// - Returns: The corresponding planetary object index.
    static func fromPlanet(_ planet: KPCAAPlanet) -> KPCPlanetaryObject {
        switch planet {
        case .Mercury:
            return .MERCURY
        case .Venus:
            return .VENUS
        case .Mars:
            return .MARS
        case .Jupiter:
            return .JUPITER
        case .Saturn:
            return .SATURN
        case .Uranus:
            return .URANUS
        case .Neptune:
            return .NEPTUNE
        default:
            return .UNDEFINED
        }
    }
    
    /// Returns the SwiftAA Class type for the given planetary object.
    public var objectType: Planet.Type? {
        switch self {
        case .MERCURY:
            return SwiftAA.Mercury.self
        case .VENUS:
            return SwiftAA.Venus.self
        case .MARS:
            return SwiftAA.Mars.self
        case .JUPITER:
            return SwiftAA.Jupiter.self
        case .SATURN:
            return SwiftAA.Saturn.self
        case .URANUS:
            return SwiftAA.Uranus.self
        case .NEPTUNE:
            return SwiftAA.Neptune.self
        case .UNDEFINED:
            return nil
        }
    }
}
