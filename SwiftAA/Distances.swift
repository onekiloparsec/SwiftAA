//
//  Distances.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 26/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation


public struct AU: NumericType, CustomStringConvertible {
    public let value: Double
    public init(_ value: Double) {
        self.value = value
    }
    
    public var pc: Parsec { return Parsec(value / 206264.80624548031) } // tan(1./3600.0*M_PI/180.)
    public var km: Double { return value * 149597870.7 }
    public var m:  Meter  { return Meter(value * 149597870700.0) }
    public var ly: Double { return value / 206264.8 }
    
    public func parallax() -> ArcSecond {
        return Degree(KPCAAParallax_DistanceToParallax(value)).inArcseconds
    }

    public var description: String { return String(format: "%.2f AU", value) }
}

// MARK: -

public struct Parsec: NumericType, CustomStringConvertible {
    public let value: Double
    public init(_ value: Double) {
        self.value = value
    }
    
    public var AstronomicalUnit: AU { return AU(value * 206264.80624548031) }
    public var description: String { return String(format: "%.1f pc", value) }
}



// MARK: -

public struct Meter: NumericType, CustomStringConvertible {
    public let value: Double
    public init(_ value: Double) {
        self.value = value
    }
    
    public var mkm: Double { return value * 1e+6 }
    public var mm: Double { return value * 1e+3 }
    public var km: Double { return value * 1e-3 }
    public var AstronomicalUnit: AU { return AU(value / 149597870700.0) }
    public var description: String { return String(format: "%.1f meters", value) }
}


