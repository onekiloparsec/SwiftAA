//
//  Constants.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

#if os(OSX)
    import AppKit
    public typealias Color=NSColor
#else
    import UIKit
    public typealias Color=UIColor
#endif

public typealias Degree=Double
public typealias Arcsecond=Double
public typealias AU=Double // Astronomical Unit
public typealias Meter=Double // meters
public typealias Parsec=Double // parsecs
public typealias Kilogram=Double
public typealias Day=Double
public typealias Magnitude=Double
public typealias Celsius=Double
public typealias Millibar=Double

public enum Equinox {
    case meanEquinoxOfTheDate
    case standardJ2000
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

public let ModifiedJulianDayZero = 2400000.5
public let JulianYear: Day = 365.25            // See p.133 of AA.
public let BesselianYear: Day = 365.2421988    // See p.133 of AA.
public let JulianDayB1950: JulianDay = 2433282.4235	// See p.133 of AA.

public let StandardEpoch_J2000_0 = 2451545.0 // See p.133 of AA.
public let StandardEpoch_B1950_0 = 2433282.4235 // See p.133 of AA.

public let UNDEFINED_SCIENTIFIC_VALUE = -999999999999.0


// Check nested types in https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Extensions.html

public extension Degree {
    var degree: Double { return self }
    var arcminute: Double { return self * 60.0 }
    var arcsecond: Arcsecond { return self * 3600.0 }
    var radian: Double { return self * 0.017453292519943295769236907684886 }
    var hour:   Double { return self / 15.0 }
    
    public func distance() -> Parsec {
        return KPCAAParallax_ParallaxToDistance(self.arcsecond)
    }
}

public extension AU {
    var AU: Double { return self }
    var pc: Parsec { return self / 206264.80624548031 } // tan(1./3600.0*M_PI/180.)
    var km: Double { return self / 149597870.7 }
    var m:  Meter  { return self / 149597870700.0 }
    var ly: Double { return self / 206264.8 }
    
    public func parallax() -> Arcsecond {
        return KPCAAParallax_DistanceToParallax(self.pc)
    }
}

public extension KPCAAPlanet {
    static func fromString(_ string: String) -> KPCAAPlanet {
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
    
    func toString() -> String {
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
}

#if os(OSX)
    extension NSColor {
        convenience init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
            self.init(calibratedRed: red, green: green, blue: blue, alpha: alpha)
        }
    }
#endif
