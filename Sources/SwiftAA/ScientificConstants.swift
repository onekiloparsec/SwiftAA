//
//  ScientificConstants.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/12/2016.
//  MIT Licence. See LICENCE file.
//

import Foundation
import ObjCAA

/// Constant value substracted from Julian Day to create so-called modified julian days.
public let ModifiedJulianDayZero: Double = 2400000.5

/// The length of Julian Years, in days.
public let JulianYear: Day = 365.25            // See p.133 of AA.
/// The length of Besselian Years, in days.
public let BesselianYear: Day = 365.2421988    // See p.133 of AA.

/// The new standard epoch, as decided by the IAU in 1984.
public let StandardEpoch_J2000_0: JulianDay = 2451545.0 // See p.133 of AA.
public let StandardEpoch_B1950_0: JulianDay = 2433282.4235 // See p.133 of AA.

/// Mean value of the lunar equator inclination, relative to the ecliptic.
public let MeanLunarEquatorInclination: Degree = 1.54242 // Relative, to Ecliptic. See p. 372 of AA.

public typealias Kilogram=Double
public typealias Celsius=Double
public typealias Millibar=Double

/// Conversion factor from radians to degrees.
public let rad2deg = 180.0/Double.pi
/// Conversion factor from degrees to radians.
public let deg2rad = Double.pi/180.0

/// Conversion factor from radians to hours.
public let rad2hour = 3.8197186342054880584532103209403
/// Conversion factor from hours to radians.
public let hour2rad = 0.26179938779914943653855361527329

/// Conversion factor from Astronomical Unit to parsecs.
public let AU2pc: Double = tan(1.0/3600.0/deg2rad)
/// Conversion factor from Astronomical Unit to meters.
public let AU2m: Double = 149597870700.0 // Wikipedia
/// Conversion factor from Astronomical Unit to light-years.
public let AU2ly: Double = 1.0/206264.8


/// Standard eqpoch values. Note: equinoxes are directions, epochs are point in time.
public enum Epoch: CustomStringConvertible {
    
    /// The mean epoch of the date.
    case epochOfTheDate(JulianDay)
    
    /// The standard 2000 epoch: January 1st, 2000, in the Julian calendar (1 year = 365.25 days).
    case J2000
    
    /// The standard 1950 epoch: January 1st, 1950, in the Besselian calendar
    /// (1 year = 365.2421988 days in AD1900, that is, the length of the tropical year).
    case B1950
    
    /// The value of the epoch, in Julian Days.
    var julianDay: JulianDay {
        switch self {
        case .epochOfTheDate(let julianDay):
            return julianDay
        case .J2000:
            return StandardEpoch_J2000_0
        case .B1950:
            return StandardEpoch_B1950_0
        }
    }
    
    public var description: String {
        switch self {
        case .epochOfTheDate(let julianDay):
            return julianDay.description
        case .J2000:
            return "J2000.0"
        case .B1950:
            return "B1950.0"
        }
    }
}

/// Standard equinox values. Note: equinoxes are directions, epochs are point in time.
/// The vernal equinox, which is the zero point of both right ascension and celestial longitude, is defined
/// to be in the direction of the ascending node of the ecliptic on the equator.
/// Of course, at the standard epoch of J2000 corresponds to a specific (and thus standard) equinox.
public enum Equinox: CustomStringConvertible {
    
    /// The mean equinox of the date is the intersection of the ecliptic of the date with the mean equator of the date.
    case meanEquinoxOfTheDate(JulianDay)
    
    /// The standard 2000 equinox: January 1st, 2000, in the Julian calendar (1 year = 365.25 days).
    case standardJ2000
    
    /// The standard 1950 equinox: January 1st, 1950, in the Besselian calendar 
    /// (1 year = 365.2421988 days in AD1900, that is, the length of the tropical year).
    case standardB1950
    
    /// The Julian Day of the given equinox.
    var julianDay: JulianDay {
        switch self {
        case .meanEquinoxOfTheDate(let julianDay):
            return julianDay
        case .standardJ2000:
            return StandardEpoch_J2000_0
        case .standardB1950:
            return StandardEpoch_B1950_0
        }
    }
    
    public var description: String { return self.julianDay.description }
}


/// Earth seasons
///
/// - spring: Spring
/// - summer: Summer
/// - autumn: Autumn
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
    case newMoon
    case firstQuarter
    case fullMoon
    case lastQuarter
}

/// Error used when computing Rise Transit and Set times (see Earth twilights and planetary rise, transit and set times).
///
/// - alwaysBelowAltitude: The object is always below the given altitude.
/// - alwaysAboveAltitude: The object is always above the given altitude.
public enum CelestialBodyTransitError: Error {
    case alwaysBelowAltitude
    case alwaysAboveAltitude
    case undefinedPlanetaryObject
}

// Check nested types in https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Extensions.html


/// KPCAAPlanet is an enum for all historical 9 planets, that is, including Pluto.
extension KPCAAPlanet: CustomStringConvertible {
    
    /// Return the KPCAAPlanet enum value from a planet name string.
    ///
    /// - Parameter string: The planet name.
    /// - Returns: The KPCAAPlanet enum value
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
    
    /// Return the planet name according to the enum value.
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
        @unknown default:
            return ""
        }
    }
}

// Tricky Swiftness tricks to use the 3 partly-overlapping enums with as few
// code lines as possible. There must be some other way round to force correct
// planet enum parameters in Obj-C functions. The code here is the consequence of
// choosing to make switch statments inside Obj-C layer, rather than in Swift one.

/// KPCAAPlanetStrict is an enum for all true planets, that is, excluding the now official
/// Dwarf Planet category, that is, Pluto.
public extension KPCAAPlanetStrict {
    
    /// Return the equivalent KPCAAPlanetStrict enum value from the KPCAAPlanet enum.
    ///
    /// - Parameter planet: The KPCAAPlanet enum value
    /// - Returns: The equivalent KPCAAPlanetStrict enum value
    static func fromPlanet(_ planet: KPCAAPlanet) -> KPCAAPlanetStrict {
        switch planet {
        case .Pluto:
            return .undefined
        default:
            return KPCAAPlanetStrict(rawValue: planet.rawValue)!
        }
    }
}

/// KPCPlanetaryObject is an enum for all planets, exlcuding Earth and Pluto.
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
    var objectType: Planet.Type? {
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
        @unknown default:
            return nil
        }
    }
}


/// KPCAAEllipticalObject is an enum for the Sun, all planets, exlcuding Earth but including Pluto.
public extension KPCAAEllipticalObject {
    
    /// Returns the elliptical object index from a given planet index.
    ///
    /// - Parameter planet: The planet index.
    /// - Returns: The corresponding elliptical object index. The Sun must be handled individually.
    static func fromPlanet(_ planet: KPCAAPlanet) -> KPCAAEllipticalObject {
        switch planet {
        case .Mercury:
            return .MERCURY_elliptical
        case .Venus:
            return .VENUS_elliptical
        case .Mars:
            return .MARS_elliptical
        case .Jupiter:
            return .JUPITER_elliptical
        case .Saturn:
            return .SATURN_elliptical
        case .Uranus:
            return .URANUS_elliptical
        case .Neptune:
            return .NEPTUNE_elliptical
        case .Pluto:
            return .PLUTO_elliptical
        default:
            return .UNDEFINED_elliptical
        }
    }
}
