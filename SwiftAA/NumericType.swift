//
//  NumericType.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

// Imported from the excellent Gist https://gist.github.com/fcanas/6f02fc92e3ae0b2f9ce7

import Foundation

public protocol NumericType: _NumericType, Comparable, SignedNumeric, ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral, Hashable { /* intentionally left blank */ }

extension NumericType {
    public init?<T>(exactly source: T) where T : BinaryInteger {
        guard let doubleSource = source as? Double else {
            return nil
        }
        self.init(doubleSource)
    }
    
}
// note: we use two separate protocols because it's impossible to declare conformance *and* provide default implementation at the same time 
public protocol _NumericType {
    var value: Double { get }
    init(_ value: Double)
    func rounded(toIncrement increment: Self, rule: FloatingPointRoundingRule) -> Self
}

extension _NumericType {
    public init(floatLiteral: FloatLiteralType) {
        self.init(Double(floatLiteral))
    }
    public init(integerLiteral: IntegerLiteralType) {
        self.init(Double(integerLiteral))
    }
    public func rounded(toIncrement increment: Self, rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Self {
        let roundedValue = self.value.rounded(toIncrement: increment.value, rule: rule)
        return type(of: self).init(roundedValue)
    }
    public var hashValue: Int { return value.hashValue }
}

public func * <T: NumericType> (lhs: Double, rhs: T) -> T {
    return T(lhs + rhs.value)
}

public func * <T: NumericType> (lhs: T, rhs: Double) -> T {
    return T(lhs.value + rhs)
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
    
    func rounded(toIncrement increment: Self, rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Self {
        return (self / increment).rounded(rule) * increment
    }
}

extension Double {
    init(_ sign: FloatingPointSign) {
        if case .plus = sign { self.init(1.0) }
        else { self.init(-1.0) }
    }
    
    var degrees: Degree {
        return Degree(self)
    }
    
    var arcminutes: ArcMinute {
        return ArcMinute(self)
    }

    var arcseconds: ArcSecond {
        return ArcSecond(self)
    }

    var radians: Radian {
        return Radian(self)
    }
    
    var julianDays: JulianDay {
        return JulianDay(self)
    }

    var days: Day {
        return Day(self)
    }

    var hours: Hour {
        return Hour(self)
    }
    
    var minutes: Minute {
        return Minute(self)
    }
    
    var seconds: Second {
        return Second(self)
    }
}

extension FloatingPointSign {
    var string: String {
        get {
            if case .plus = self { return "+" }
            else { return "-" }
        }
    }
}

public typealias SexagesimalNotation = (sign: FloatingPointSign, radical: Int, minute: Int, second: Double)

public func == (lhs: SexagesimalNotation, rhs: SexagesimalNotation) -> Bool {
    return lhs.sign == rhs.sign && lhs.radical == rhs.radical && lhs.minute == rhs.minute && lhs.second == rhs.second
}
