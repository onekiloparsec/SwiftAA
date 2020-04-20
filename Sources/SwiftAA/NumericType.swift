//
//  NumericType.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  MIT Licence. See LICENCE file.
//

// Imported from the excellent Gist https://gist.github.com/fcanas/6f02fc92e3ae0b2f9ce7

import Foundation


/// Base protocol for all numeric types of SwiftAA
public protocol NumericType: _NumericType, SignedNumeric, Comparable, ExpressibleByFloatLiteral, Hashable { /* intentionally left blank */ }

// note: we use two separate protocols because it's impossible to declare conformance *and* provide default implementation at the same time 
public protocol _NumericType: AdditiveArithmetic {
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
    
    #if swift(>=3.2)
    public init?<T>(exactly source: T) where T : BinaryInteger {
        guard let value = Double(exactly: source) else { return nil }
        self.init(value)
    }
    #endif
    
    public func rounded(toIncrement increment: Self, rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Self {
        let roundedValue = self.value.rounded(toIncrement: increment.value, rule: rule)
        return type(of: self).init(roundedValue)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool { return lhs.value == rhs.value }
    public static func < (lhs: Self, rhs: Self) -> Bool { return lhs.value < rhs.value }
    
    public static func + (lhs: Self, rhs: Self) -> Self { return Self(lhs.value + rhs.value) }
    public static func - (lhs: Self, rhs: Self) -> Self { return Self(lhs.value - rhs.value) }
    public static func * (lhs: Self, rhs: Self) -> Self { return Self(lhs.value * rhs.value) }
    public static func / (lhs: Self, rhs: Self) -> Self { return Self(lhs.value / rhs.value) }
    
    public static func += (lhs: inout Self, rhs: Self) { lhs = Self(lhs.value + rhs.value) }
    public static func -= (lhs: inout Self, rhs: Self) { lhs = Self(lhs.value - rhs.value) }
    public static func *= (lhs: inout Self, rhs: Self) { lhs = Self(lhs.value * rhs.value) }
    
    public var magnitude: Self { return Self(abs(value)) }

    // This is compatible with Xcode 9 equivalent of `#if compiler(>=4.2)` (see https://github.com/apple/swift-evolution/blob/master/proposals/0212-compiler-version-directive.md)
    #if swift(>=4.1.50) || (swift(>=3.4) && !swift(>=4.0))
    public func hash(into hasher: inout Hasher) { hasher.combine(value) }
    #else
    public var hashValue: Int { return value.hashValue }
    #endif
    
}


public extension FloatingPoint {
    func positiveTruncatingRemainder(dividingBy other: Self) -> Self {
        let truncated = truncatingRemainder(dividingBy: other)
        let positive = truncated.sign == .minus ? truncated + other : truncated
        return positive
    }
    
    /// Returns self reduced to range -other/2 <.. +other/2
    func zeroCenteredTruncatingRemainder(dividingBy other: Self) -> Self {
        guard other > Self(0) else { fatalError("Divisor must be positive") }
        let positive = positiveTruncatingRemainder(dividingBy: other)
        let centered = positive > other / Self(2) ? positive - other : positive
        return centered
    }
    
    func rounded(toIncrement increment: Self, rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Self {
        return (self / increment).rounded(rule) * increment
    }
}

public extension Double {
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
    
    var sexagesimal: SexagesimalNotation {
        let deg = abs(self.rounded(.towardZero))
        let min = ((abs(self) - deg) * 60.0).rounded(.towardZero)
        let sec = ((abs(self) - deg) * 60.0 - min) * 60.0
        return (self > 0.0 ? .plus : .minus, Int(deg), Int(min), Double(sec))
    }

    var sexagesimalShortString: String {
        let sexa = self.sexagesimal
        return sexa.sign.string
            + String(format: "%02d", sexa.radical) + ":"
            + String(format: "%02d", sexa.minute) + ":"
            + String(format: "%04.1f", sexa.second)
        
    }
}

public extension FloatingPointSign {
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

