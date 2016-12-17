//
//  Angles.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/12/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Degree: NumericType {
    public var value: Double
    public init(_ value: Double) {
        self.value = value
    }
    
    public var arcminute: Double { return self.value * 60.0 }
    public var arcsecond: ArcSecond { return ArcSecond(self.value * 3600.0) }
    public var radian: Double { return self.value * 0.017453292519943295769236907684886 }
    public var hour: Hour { return Hour(self.value / 15.0) }
    
    public func distance() -> AU {
        return KPCAAParallax_ParallaxToDistance(self.arcsecond.value)
    }
}

extension Degree: ExpressibleByIntegerLiteral {
    public init(integerLiteral: IntegerLiteralType) {
        self.init(Double(integerLiteral))
    }
}

extension Degree: ExpressibleByFloatLiteral {
    public init(floatLiteral: FloatLiteralType) {
        self.init(Double(floatLiteral))
    }
}


// --

public struct ArcSecond: NumericType {
    public var value: Double
    public init(_ value: Double) {
        self.value = value
    }
    
    public var degree: Degree { return Degree(self.value / 3600.0) }
    public var arcminute: Double { return self.value / 60.0 }
    
    public func distance() -> AU {
        return KPCAAParallax_ParallaxToDistance(self.degree.value)
    }
}

extension ArcSecond: ExpressibleByIntegerLiteral {
    public init(integerLiteral: IntegerLiteralType) {
        self.init(Double(integerLiteral))
    }
}

extension ArcSecond: ExpressibleByFloatLiteral {
    public init(floatLiteral: FloatLiteralType) {
        self.init(Double(floatLiteral))
    }
}

