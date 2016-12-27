//
//  Angles.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/12/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Degree: NumericType {
    public let value: Double
    public init(_ value: Double) {
        self.value = value
    }
    public init(_ degrees: Double, _ arcminutes: Double, _ arcseconds: Double) {
        guard degrees.sign == arcminutes.sign && degrees.sign == arcseconds.sign else { fatalError("degrees/arcminutes/arcseconds must have the same sign") }
        self.init(degrees + arcminutes/60.0 + arcseconds/3600.0)
    }
    
    public var inArcminutes: ArcMinute { return ArcMinute(value * 60.0) }
    public var inArcseconds: ArcSecond { return ArcSecond(value * 3600.0) }
    public var inRadians: Double { return value * 0.017453292519943295769236907684886 }
    public var inHours: Hour { return Hour(value / 15.0) }
    
    /// Returns self reduced to 0..<360 range 
    public var reduced: Degree { return Degree(value.positiveTruncatingRemainder(dividingBy: 360.0)) }
}

extension Degree: CustomStringConvertible {
    public var description: String {
        let deg = value.rounded(.towardZero)
        let min = ((value - deg) * 60.0).rounded(.towardZero)
        let sec = ((value - deg) * 60.0 - min) * 60.0
        return String(format: "%+.0f°%02.0f'%04.1f\"", deg, abs(min), abs(sec))
    }
}

// MARK: -

public struct ArcMinute: NumericType {
    public let value: Double
    public init(_ value: Double) {
        self.value = value
    }
    
    public var inDegrees: Degree { return Degree(value / 60.0) }
    public var inArcseconds: ArcSecond { return ArcSecond(value * 60.0) }
    public var inHours: Hour { return inDegrees.inHours }
    public var inRadians: Double { return inDegrees.inRadians }
    
}

// MARK: -

public struct ArcSecond: NumericType {
    public let value: Double
    public init(_ value: Double) {
        self.value = value
    }
    
    public var inDegrees: Degree { return Degree(value / 3600.0) }
    public var inArcminutes: ArcMinute { return ArcMinute(value / 60.0) }
    public var inHours: Hour { return inDegrees.inHours }
    public var inRadians: Double { return inDegrees.inRadians }

    public func distance() -> AU {
        return AU(KPCAAParallax_ParallaxToDistance(inDegrees.value))
    }
}


