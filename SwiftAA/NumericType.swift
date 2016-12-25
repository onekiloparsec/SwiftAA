//
//  NumericType.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

// Imported from the excellent Gist https://gist.github.com/fcanas/6f02fc92e3ae0b2f9ce7

import Foundation


public protocol NumericType: _NumericType, Comparable, SignedNumber, ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral { /* intentionally left blank */ }

// note: we use two separate protocols because it's impossible to declare conformance *and* provide default implementation at the same time 
public protocol _NumericType {
    var value: Double { get }
    init(_ value: Double)
}

extension _NumericType {
    public init(floatLiteral: FloatLiteralType) {
        self.init(Double(floatLiteral))
    }
    public init(integerLiteral: IntegerLiteralType) {
        self.init(Double(integerLiteral))
    }
}

public func + <T: NumericType> (lhs: T, rhs: T) -> T {
    return T(lhs.value + rhs.value)
}

public func - <T: NumericType> (lhs: T, rhs: T) -> T {
    return T(lhs.value - rhs.value)
}

public func < <T: NumericType> (lhs: T, rhs: T) -> Bool {
    return lhs.value < rhs.value
}

public func == <T: NumericType> (lhs: T, rhs: T) -> Bool {
    return lhs.value == rhs.value
}

public prefix func - <T: NumericType> (number: T) -> T {
    return T(-number.value)
}


extension FloatingPoint {
    
    func positiveTruncatingRemainder(dividingBy other: Self) -> Self {
        let truncated = truncatingRemainder(dividingBy: other)
        let positive = truncated.sign == .minus ? truncated + other : truncated
        return positive
    }
    
}


