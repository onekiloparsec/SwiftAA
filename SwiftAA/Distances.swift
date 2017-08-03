//
//  Distances.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 26/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation


/// The AstronomicalUnit is a unit of distance.
/// AstronomicalUnit structs conform to SwiftAA Numeric type protocol.
public struct AstronomicalUnit: NumericType, CustomStringConvertible {
    
    public var magnitude: Double
    
    public static func -=(lhs: inout AstronomicalUnit, rhs: AstronomicalUnit) {
        lhs.value = lhs.value - rhs.value
    }
    
    public static func +=(lhs: inout AstronomicalUnit, rhs: AstronomicalUnit) {
        lhs.value = rhs.value + lhs.value
    }
    
    public static func *(lhs: AstronomicalUnit, rhs: AstronomicalUnit) -> AstronomicalUnit {
        return AstronomicalUnit(lhs.value * rhs.value)
    }
    
    public static func *=(lhs: inout AstronomicalUnit, rhs: AstronomicalUnit) {
        lhs.value = rhs.value * lhs.value
    }
    
    /// The AstronomicalUnit value
    public var value: Double
    
    /// Returns a new AstronomicalUnit object.
    ///
    /// - Parameter value: The value of AstronomicalUnit.
    public init(_ value: Double) {
        self.value = value
        self.magnitude = value
    }
    
    /// Transform the current AstronomicalUnit in Parsecs
    public var pc: Parsec { return Parsec(value / 206264.80624548031) } // tan(1./3600.0*M_PI/180.)
    /// Transform the current AstronomicalUnit in kilometers
    public var km: Double { return value * 149597870.7 }
    /// Transform the current AstronomicalUnit in Meters
    public var m:  Meter  { return Meter(value * 149597870700.0) }
    /// Transform the current AstronomicalUnit in light-years
    public var ly: Double { return value / 206264.8 }
    
    /// Returns the parallax value corresponding to the current distance.
    ///
    /// - Returns: The parallax value.
    public func parallax() -> ArcSecond {
        return Degree(KPCAAParallax_DistanceToParallax(value)).inArcSeconds
    }

    public var description: String { return String(format: "%.2f AU", value) }
}

// MARK: -

/// The Parsec is a unit of distance.
/// Parsec structs conform to SwiftAA Numeric type protocol.
public struct Parsec: NumericType, CustomStringConvertible {
    public static func -=(lhs: inout Parsec, rhs: Parsec) {
        lhs.value = lhs.value - rhs.value
    }
    
    public static func +=(lhs: inout Parsec, rhs: Parsec) {
        lhs.value = lhs.value + rhs.value
    }
    
    public init?<T>(exactly source: T) where T : BinaryInteger {
        self.init(1.0)
    }
    
    public var magnitude: Double
    
    public static func *(lhs: Parsec, rhs: Parsec) -> Parsec {
        return Parsec(lhs.value * rhs.value)
    }
    
    public static func *=(lhs: inout Parsec, rhs: Parsec) {
        lhs.value = lhs.value * rhs.value
    }
    
//    public typealias Magnitude = Double
    
    /// The Parsec value
    public var value: Double
    
    /// Returns a new Parsec object.
    ///
    /// - Parameter value: The value of Parsec.
    public init(_ value: Double) {
        self.value = value
        self.magnitude = value
    }
    
    /// Transform the current Parsec in AstronomicalUnits
    public var AU: AstronomicalUnit { return AstronomicalUnit(value * 206264.80624548031) }
    public var description: String { return String(format: "%.1f pc", value) }
}



// MARK: -

/// The Meter is a unit of angle.
/// Meter structs conform to SwiftAA Numeric type protocol.
public struct Meter: NumericType, CustomStringConvertible {
    
    public var magnitude: Double
    
    public static func -=(lhs: inout Meter, rhs: Meter) {
        lhs.value = lhs.value - rhs.value
    }
    
    public static func +=(lhs: inout Meter, rhs: Meter) {
        lhs.value = rhs.value + lhs.value
    }
    
    public static func *(lhs: Meter, rhs: Meter) -> Meter {
        return Meter(lhs.value * rhs.value)
    }
    
    public static func *=(lhs: inout Meter, rhs: Meter) {
        lhs.value = rhs.value * lhs.value
    }
    
    /// The Meter value
    public var value: Double
    
    /// Returns a new Meter object.
    ///
    /// - Parameter value: The value of Meter.
    public init(_ value: Double) {
        self.value = value
        self.magnitude = value
    }
    
    /// Transform the current Meter in Microns
    public var µm: Double { return value * 1e+6 }
    /// Transform the current Meter in milimeters
    public var mm: Double { return value * 1e+3 }
    /// Transform the current Meter in kilometers
    public var km: Double { return value * 1e-3 }
    /// Transform the current Meter in AstronomicalUnit.
    public var AU: AstronomicalUnit { return AstronomicalUnit(value / 149597870700.0) }

    public var description: String { return String(format: "%.1f meters", value) }
}


