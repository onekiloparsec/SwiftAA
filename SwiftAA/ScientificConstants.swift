//
//  ScientificConstants.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/12/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public let ModifiedJulianDayZero: Double = 2400000.5

public let JulianYear: Double = 365.25            // See p.133 of AA.
public let BesselianYear: Double = 365.2421988    // See p.133 of AA.

public let JulianDayB1950: JulianDay = 2433282.4235	// See p.133 of AA.

public let StandardEpoch_J2000_0: JulianDay = 2451545.0 // See p.133 of AA.
public let StandardEpoch_B1950_0: JulianDay = 2433282.4235 // See p.133 of AA.

public let UNDEFINED_SCIENTIFIC_VALUE = -999999999999.0
public let DEG2RAD = 0.017453292519943295769236907684886

public typealias Kilogram=Double
public typealias Celsius=Double
public typealias Millibar=Double

public enum Equinox {
    case meanEquinoxOfTheDate
    case standardJ2000
    
    var julianDay: JulianDay {
        switch self {
        case .meanEquinoxOfTheDate:
            return 0
        case .standardJ2000:
            return StandardEpoch_J2000_0
        }
    }
}

public enum Season {
    case spring
    case summer
    case autumn
    case winter
}

public enum MoonPhase {
    case new
    case firstQuarter
    case full
    case lastQuarter
}

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
    
    public var objectType: Planet.Type? {
        switch self {
        case .MERCURY:
            return SwiftAA.Mercury
        case .VENUS:
            return SwiftAA.Venus
        case .MARS:
            return SwiftAA.Mars
        case .JUPITER:
            return SwiftAA.Jupiter
        case .SATURN:
            return SwiftAA.Saturn
        case .URANUS:
            return SwiftAA.Uranus
        case .NEPTUNE:
            return SwiftAA.Neptune
        case .UNDEFINED:
            return nil
        }
    }
}
