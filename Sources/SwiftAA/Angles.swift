//
//  Angles.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/12/2016.
//  MIT Licence. See LICENCE file.
//

import Foundation
import ObjCAA

/// The Degree is a unit of angle.
public struct Degree: NumericType, CustomStringConvertible {
    /// The Degree value
    public let value: Double
    
    /// Returns a new Degree object.
    ///
    /// - Parameter value: The value of Degree.
    public init(_ value: Double) {
        self.value = value
    }
    
    /// Creates a new Degree instance, from sexagesimal components.
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

    /// Transform the current Degree in ArcMinutes
    public var inArcMinutes: ArcMinute { return ArcMinute(value * 60.0) }
    /// Transform the current Degree in ArcSeconds
    public var inArcSeconds: ArcSecond { return ArcSecond(value * 3600.0) }
    /// Transform the current Degree in Radians
    public var inRadians: Radian { return Radian(value * deg2rad) }
    /// Transform the current Degree in Hours
    public var inHours: Hour { return Hour(value / 15.0) }
    
    /// The sexagesimal notation of the Degree.
    public var sexagesimal: SexagesimalNotation {
        get {
            let deg = abs(value.rounded(.towardZero))
            let min = ((abs(value) - deg) * 60.0).rounded(.towardZero)
            let sec = ((abs(value) - deg) * 60.0 - min) * 60.0
            return (value > 0.0 ? .plus : .minus, Int(deg), Int(min), Double(sec))
        }
    }

    /// Returns `self` reduced to 0..<360 range
    public var reduced: Degree { return Degree(value.positiveTruncatingRemainder(dividingBy: 360.0)) }
    /// Returns `self` reduced to -180..<180 range (around 0)
    public var reduced0: Degree { return Degree(value.zeroCenteredTruncatingRemainder(dividingBy: 360.0)) }

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
        let (sign, deg, min, sec) = self.sexagesimal
        return sign.string + String(format: "%i°%i'%06.3f\"", deg, min, sec)
    }
}


// MARK: -

/// The ArcMinute is a unit of angle.
public struct ArcMinute: NumericType, CustomStringConvertible {
    /// The ArcMinute value
    public let value: Double

    /// Creates a new ArcMinute instance.
    ///
    /// - Parameter value: The value of ArcMinute.
    public init(_ value: Double) {
        self.value = value
    }
    
    /// Transform the current ArcMinute in Degree
    public var inDegrees: Degree { return Degree(value / 60.0) }
    /// Transform the current ArcMinute in ArcSeconds
    public var inArcSeconds: ArcSecond { return ArcSecond(value * 60.0) }
    /// Transform the current ArcMinute in Hours
    public var inHours: Hour { return inDegrees.inHours }
    
    public var description: String { return String(format: "%.2f arcmin", value) }
}

// MARK: -

/// The ArcSecond is a unit of angle.
public struct ArcSecond: NumericType, CustomStringConvertible {
    /// The ArcSecond value
    public let value: Double
    
    /// Creates a new ArcSecond instance.
    ///
    /// - Parameter value: The value of ArcSecond.
    public init(_ value: Double) {
        self.value = value
    }
    
    /// Transform the current ArcSecond in Degrees
    public var inDegrees: Degree { return Degree(value / 3600.0) }
    /// Transform the current ArcSecond in ArcMinutes
    public var inArcMinutes: ArcMinute { return ArcMinute(value / 60.0) }
    /// Transform the current ArcSecond in Hours
    public var inHours: Hour { return inDegrees.inHours }

    /// Returns a new distance in Astronomical Units, the arcsecond being understood as a 
    /// geometrical parallax.
    ///
    /// - Returns: The distance of the object.
    public func distance() -> Parsec {
        guard self.value > 0 else { fatalError("Value most be positive and above 0") }
        return Parsec(1.0/value)
    }
    
    /// Returns a new distance in Astronomical Units, the arcsecond being understood as a
    /// equatorial horizontal parallax, that is the difference between the topocentric and
    /// the geocentric coordinates of a solar system body (Sun, planet or comets).
    ///
    /// - Returns: The distance of the object.
    public func distanceFromEquatorialHorizontalParallax() -> AstronomicalUnit {
        return AstronomicalUnit(KPCAAParallax_ParallaxToDistance(inDegrees.value))
    }

    public var description: String { return String(format: "%.2f arcsec", value) }
}

// MARK: -

/// The Radian is a unit of angle.
public struct Radian: NumericType, CustomStringConvertible {
    /// The Radian value
    public let value: Double

    /// Creates a new Radian instance.
    ///
    /// - Parameter value: The value of Radian.
    public init(_ value: Double) {
        self.value = value
    }
    
    /// Transform the current Radian in Degrees
    public var inDegrees: Degree { return Degree(value * rad2deg) }
    /// Transform the current Radian in Hours
    public var inHours: Hour { return Hour(value * rad2hour) }
    
    /// Returns self reduced to 0..<2PI range
    public var reduced: Radian { return Radian(value.positiveTruncatingRemainder(dividingBy: 2*Double.pi)) }
    /// Returns self reduced to -pi..<pi range (around 0)
    public var reduced0: Radian { return Radian(value.zeroCenteredTruncatingRemainder(dividingBy: 2*Double.pi)) }
    
    public var description: String { return String(format: "%.3f rad", value) }
}

