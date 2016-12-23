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
    
    public var arcminute: Double { return self.value * 60.0 }
    public var arcsecond: ArcSecond { return ArcSecond(self.value * 3600.0) }
    public var radian: Double { return self.value * 0.017453292519943295769236907684886 }
    public var hour: Hour { return Hour(self.value / 15.0) }
    
    public func distance() -> AU {
        return AU(KPCAAParallax_ParallaxToDistance(self.arcsecond.value))
    }
}

extension Degree: CustomStringConvertible {
    public var description: String {
        let deg = value.rounded(.towardZero)
        let min = ((value - deg) * 60.0).rounded(.towardZero)
        let sec = ((value - deg) * 60.0 - min) * 60.0
        return String(format: "%+.0f°%02.0f'%04.1f\"", deg, abs(min), abs(sec))
    }
}


// --

public struct ArcSecond: NumericType {
    public let value: Double
    public init(_ value: Double) {
        self.value = value
    }
    
    public var degree: Degree { return Degree(self.value / 3600.0) }
    public var arcminute: Double { return self.value / 60.0 }
    
    public func distance() -> AU {
        return AU(KPCAAParallax_ParallaxToDistance(self.degree.value))
    }
}


