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

// Check nested types in https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Extensions.html

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
