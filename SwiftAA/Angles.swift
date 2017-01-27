//
//  Angles.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/12/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Degree: NumericType, CustomStringConvertible {
    public let value: Double
    public init(_ value: Double) {
        self.value = value
    }
    
    public init(_ degrees: Double, _ arcminutes: Double, _ arcseconds: Double) {
        guard degrees.sign == arcminutes.sign && degrees.sign == arcseconds.sign else {
            fatalError("degrees/arcminutes/arcseconds must have the same sign")
        }
        self.init(degrees + arcminutes/60.0 + arcseconds/3600.0)
    }

    public init(_ sexagesimal: (Degree, ArcMinute, ArcSecond)) {
        self.init(sexagesimal.0.value + sexagesimal.1.value/60.0 + sexagesimal.2.value/3600.0)
    }

    public var inArcminutes: ArcMinute { return ArcMinute(value * 60.0) }
    public var inArcseconds: ArcSecond { return ArcSecond(value * 3600.0) }
    public var inRadians: Radian { return Radian(value * DEG2RAD) }
    public var inHours: Hour { return Hour(value / 15.0) }
    
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
        let (sign, deg, min, sec) = self.sexagesimalNotation()
        let signSymbol = (sign == true) ? "+" : "-"
        return signSymbol + String(format: "%+.0f°%02.0f'%04.1f\"", abs(deg.value), abs(min.value), abs(sec.value))
    }
    
    public func sexagesimalNotation() -> (Bool, Degree, ArcMinute, ArcSecond) {
        let deg = abs(value.rounded(.towardZero))
        let min = ((abs(value) - deg) * 60.0).rounded(.towardZero)
        let sec = ((abs(value) - deg) * 60.0 - min) * 60.0
        return (value > 0.0, Degree(deg), ArcMinute(min), ArcSecond(sec))
    }
    
    
}

// MARK: -

public struct ArcMinute: NumericType, CustomStringConvertible {
    public let value: Double
    public init(_ value: Double) {
        self.value = value
    }
    
    public var inDegrees: Degree { return Degree(value / 60.0) }
    public var inArcseconds: ArcSecond { return ArcSecond(value * 60.0) }
    public var inHours: Hour { return inDegrees.inHours }
    public var inRadians: Radian { return inDegrees.inRadians }
    
    public var description: String { return String(format: "%.2f arcmin", value) }
}

// MARK: -

public struct ArcSecond: NumericType, CustomStringConvertible {
    public let value: Double
    public init(_ value: Double) {
        self.value = value
    }
    
    public var inDegrees: Degree { return Degree(value / 3600.0) }
    public var inArcminutes: ArcMinute { return ArcMinute(value / 60.0) }
    public var inHours: Hour { return inDegrees.inHours }
    public var inRadians: Radian { return inDegrees.inRadians }

    public func distance() -> AU {
        return AU(KPCAAParallax_ParallaxToDistance(inDegrees.value))
    }
    public var description: String { return String(format: "%.2f arcsec", value) }
}

// MARK: -

public struct Radian: NumericType, CustomStringConvertible {
    public let value: Double
    public init(_ value: Double) {
        self.value = value
    }
    
    public var inDegrees: Degree { return Degree(value / DEG2RAD) }
    public var inHours: Hour { return self.inDegrees.inHours }
    
    /// Returns self reduced to 0..<2PI range
    public var reduced: Degree { return Degree(value.positiveTruncatingRemainder(dividingBy: 2*Double.pi)) }
    
    public var description: String { return String(format: "%.3f rad", value) }
}

