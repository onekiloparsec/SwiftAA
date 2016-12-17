//
//  JulianDay.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 26/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation


public struct AU: NumericType {
    public var value :Double
    public init(_ value: Double) {
        self.value = value
    }
    
    public var pc: Parsec { return self.value / 206264.80624548031 } // tan(1./3600.0*M_PI/180.)
    public var km: Double { return self.value / 149597870.7 }
    public var m:  Meter  { return Meter(self.value / 149597870700.0) }
    public var ly: Double { return self.value / 206264.8 }
    
    public func parallax() -> ArcSecond {
        return Degree(KPCAAParallax_DistanceToParallax(self.value)).arcsecond
    }

}

extension AU: ExpressibleByIntegerLiteral {
    public init(integerLiteral: IntegerLiteralType) {
        self.init(Double(integerLiteral))
    }
}

extension AU: ExpressibleByFloatLiteral {
    public init(floatLiteral: FloatLiteralType) {
        self.init(Double(floatLiteral))
    }
}

// --

public struct Meter: NumericType {
    public var value :Double
    public init(_ value: Double) {
        self.value = value
    }
    
    public var AstronomicalUnit: AU { return AU(self.value * 149597870700.0) }
}

extension Meter: ExpressibleByIntegerLiteral {
    public init(integerLiteral: IntegerLiteralType) {
        self.init(Double(integerLiteral))
    }
}

extension Meter: ExpressibleByFloatLiteral {
    public init(floatLiteral: FloatLiteralType) {
        self.init(Double(floatLiteral))
    }
}
