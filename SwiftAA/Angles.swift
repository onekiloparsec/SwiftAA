//
//  Angles.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/12/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

/// The Degree is a unit of angle.
/// Degree structs conform to SwiftAA Numeric type protocol.
public struct Degree: NumericType, CustomStringConvertible {
    
    public var magnitude: Double
    
    public static func -=(lhs: inout Degree, rhs: Degree) {
        lhs.value = lhs.value - rhs.value
    }
    
    public static func +=(lhs: inout Degree, rhs: Degree) {
        lhs.value = rhs.value + lhs.value
    }
    
    public static func *(lhs: Degree, rhs: Degree) -> Degree {
        return Degree(lhs.value * rhs.value)
    }
    
    public static func *=(lhs: inout Degree, rhs: Degree) {
        lhs.value = rhs.value * lhs.value
    }
    
    /// The Degree value
    public var value: Double

    /// Returns a new Degree object.
    ///
    /// - Parameter value: The value of Degree.
    public init(_ value: Double) {
        self.value = value
        self.magnitude = value
    }
    
    /// Returns a new Degree object, from sexagesimal components.
    ///
    /// - Parameters:
    ///   - sign: The sign of the final value.
    ///   - degrees: The integral degree component of the value. Sign is ignored.
    ///   - arcminutes: The integral arcminute component of the value. Sign is ignored.
    ///   - arcseconds: The fractional arcsecond component of the value. Sign is ignored.
    public init(_ sign: FloatingPointSign = .plus, _ degrees: Int, _ arcminutes: Int, _ arcseconds: Double) {
        let absDegree = abs(Double(degrees))
        let absMinutes = abs(Double(arcminutes))/60.0
        let absSeconds = abs(arcseconds)/3600.0
        self.init(Double(sign) * (absDegree + absMinutes + absSeconds))
    }

    /// Returns a new Degree object, from a sexagesimal tuple.
    ///
    /// - Parameter sexagesimal: The sexagesimal tuple
    public init(_ sexagesimal: (Degree, ArcMinute, ArcSecond)) {
        self.init(sexagesimal.0.value + sexagesimal.1.value/60.0 + sexagesimal.2.value/3600.0)
    }

    /// Transform the current Degree in ArcMinutes
    public var inArcMinutes: ArcMinute { return ArcMinute(value * 60.0) }
    /// Transform the current Degree in ArcSeconds
    public var inArcSeconds: ArcSecond { return ArcSecond(value * 3600.0) }
    /// Transform the current Degree in Radians
    public var inRadians: Radian { return Radian(value * 0.017453292519943295769236907684886) }
    /// Transform the current Degree in Hours
    public var inHours: Hour { return Hour(value / 15.0) }
    
    /// The sexagesimal notation of the Degree.
    public var sexagesimalNotation: SexagesimalNotation {
        get {
            let deg = abs(value.rounded(.towardZero))
            let min = ((abs(value) - deg) * 60.0).rounded(.towardZero)
            let sec = ((abs(value) - deg) * 60.0 - min) * 60.0
            return (value > 0.0 ? .plus : .minus, Int(deg), Int(min), Double(sec))
        }
    }

    /// Returns self reduced to 0..<360 range
    public var reduced: Degree { return Degree(value.positiveTruncatingRemainder(dividingBy: 360.0)) }
    /// Returns self reduced to -180..<180 range (around 0)
    public var reduced0: Degree { return Degree(value.positiveTruncatingRemainder(dividingBy: 360.0)-180.0) }

    /// Returns true if self is within circular [from,to] interval. Interval is opened by default. All values reduced to 0..<360 range.
    public func isWithinCircularInterval(from: Degree, to: Degree, isIntervalOpen: Bool = true) -> Bool {
        let isIntervalIntersectsZero = from.reduced < to.reduced
        let isFromLessThenSelf = isIntervalOpen ? from.reduced < self.reduced : from.reduced <= self.reduced
        let isSelfLessThenTo = isIntervalOpen ? self.reduced < to.reduced : self.reduced <= to.reduced
        
        switch (isIntervalIntersectsZero,  isFromLessThenSelf, isSelfLessThenTo) {
        case (true, true, true):
            return true
        case (false, true, false), (false, false, true):
            return true
        default:
            return false
        }
    }
    
    public var description: String {
        let (sign, deg, min, sec) = self.sexagesimalNotation
        return sign.string + String(format: "%i°%i'%06.3f\"", deg, min, sec)
    }
}


// MARK: -

/// The ArcMinute is a unit of angle.
/// ArcMinute structs conform to SwiftAA Numeric type protocol.
public struct ArcMinute: NumericType, CustomStringConvertible {
    
    public var magnitude: Double

    public static func -=(lhs: inout ArcMinute, rhs: ArcMinute) {
        lhs.value = lhs.value - rhs.value
    }
    
    public static func +=(lhs: inout ArcMinute, rhs: ArcMinute) {
        lhs.value = rhs.value + lhs.value
    }
    
    public static func *(lhs: ArcMinute, rhs: ArcMinute) -> ArcMinute {
        return ArcMinute(lhs.value * rhs.value)
    }
    
    public static func *=(lhs: inout ArcMinute, rhs: ArcMinute) {
        lhs.value = rhs.value * lhs.value
    }
    
//    public typealias Magnitude = Double
    
    /// The ArcMinute value
    public var value: Double

    /// Returns a new ArcMinute object.
    ///
    /// - Parameter value: The value of ArcMinute.
    public init(_ value: Double) {
        self.value = value
        self.magnitude = value
    }
    
    /// Transform the current ArcMinute in Degree
    public var inDegrees: Degree { return Degree(value / 60.0) }
    /// Transform the current ArcMinute in ArcSeconds
    public var inArcseconds: ArcSecond { return ArcSecond(value * 60.0) }
    /// Transform the current ArcMinute in Hours
    public var inHours: Hour { return inDegrees.inHours }
    /// Transform the current ArcMinute in Radians
    public var inRadians: Radian { return inDegrees.inRadians }
    
    public var description: String { return String(format: "%.2f arcmin", value) }
}

// MARK: -

/// The ArcSecond is a unit of angle.
/// ArcSecond structs conform to SwiftAA Numeric type protocol.
public struct ArcSecond: NumericType, CustomStringConvertible {

    public var magnitude: Double
    
    public static func -=(lhs: inout ArcSecond, rhs: ArcSecond) {
        lhs.value = lhs.value - rhs.value
    }
    
    public static func +=(lhs: inout ArcSecond, rhs: ArcSecond) {
        lhs.value = rhs.value + lhs.value
    }
    
    public static func *(lhs: ArcSecond, rhs: ArcSecond) -> ArcSecond {
        return ArcSecond(lhs.value * rhs.value)
    }
    
    public static func *=(lhs: inout ArcSecond, rhs: ArcSecond) {
        lhs.value = rhs.value * lhs.value
    }
    
    /// The ArcSecond value
    public var value: Double
    
    /// Returns a new ArcSecond object.
    ///
    /// - Parameter value: The value of ArcSecond.
    public init(_ value: Double) {
        self.value = value
        self.magnitude = value
    }
    
    /// Transform the current ArcSecond in Degrees
    public var inDegrees: Degree { return Degree(value / 3600.0) }
    /// Transform the current ArcSecond in ArcMinutes
    public var inArcminutes: ArcMinute { return ArcMinute(value / 60.0) }
    /// Transform the current ArcSecond in Hours
    public var inHours: Hour { return inDegrees.inHours }
    /// Transform the current ArcSecond in Radians
    public var inRadians: Radian { return inDegrees.inRadians }

    /// Returns a new distance in Astronomical Units, the arcsecond being understood as a parallax.
    ///
    /// - Returns: The AU object.
    public func distance() -> AstronomicalUnit {
        return AstronomicalUnit(KPCAAParallax_ParallaxToDistance(inDegrees.value))
    }
    
    public var description: String { return String(format: "%.2f arcsec", value) }
}

// MARK: -

/// The Radian is a unit of angle.
/// Radian structs conform to SwiftAA Numeric type protocol.
public struct Radian: NumericType, CustomStringConvertible {

    public var magnitude: Double
    
    public static func -=(lhs: inout Radian, rhs: Radian) {
        lhs.value = lhs.value - rhs.value
    }
    
    public static func +=(lhs: inout Radian, rhs: Radian) {
        lhs.value = rhs.value + lhs.value
    }
    
    public static func *(lhs: Radian, rhs: Radian) -> Radian {
        return Radian(lhs.value * rhs.value)
    }
    
    public static func *=(lhs: inout Radian, rhs: Radian) {
        lhs.value = rhs.value * lhs.value
    }
    
//    public typealias Magnitude = Double
    
    
    /// The Radian value
    public var value: Double

    /// Returns a new Radian object.
    ///
    /// - Parameter value: The value of Radian.
    public init(_ value: Double) {
        self.value = value
        self.magnitude = value
    }
    
    /// Transform the current Radian in Degrees
    public var inDegrees: Degree { return Degree(value / 0.017453292519943295769236907684886) }
    /// Transform the current Radian in Hours
    public var inHours: Hour { return self.inDegrees.inHours }
    
    /// Returns self reduced to 0..<2PI range
    public var reduced: Degree { return Degree(value.positiveTruncatingRemainder(dividingBy: 2*Double.pi)) }
    
    public var description: String { return String(format: "%.3f rad", value) }
}

