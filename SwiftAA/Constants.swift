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

public typealias JulianDay=Double
public typealias Degrees=Double
public typealias AU=Double // Astronomical Unit

// Check nested types in https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Extensions.html

public extension Degrees {
    var Degrees: Double { return self }
    var Minutes: Double { return self * 60.0 }
    var Seconds: Double { return self * 3600.0 }
    var Radians: Double { return self * 0.017453292519943295769236907684886 }
    var Hours:   Double { return self / 15.0 }
}

public extension AU {
    var AU: Double { return self }
    var pc: Double { return self / 206264.80624548031 } // tan(1./3600.0*M_PI/180.)
    var km: Double { return self / 149597870.7 }
    var m:  Double { return self / 149597870700.0 }
}

public extension KPCEclipticObject {
    func toString() -> String {
        switch self {
        case Mercury:
            return "Mercury"
        case Venus:
            return "Venus"
        case Earth:
            return "Earth"
        case Mars:
            return "Mars"
        case Jupiter:
            return "Jupiter"
        case Saturn:
            return "Saturn"
        case Uranus:
            return "Uranus"
        case Neptune:
            return "Neptune"
        case Pluto:
            return "Pluto"
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