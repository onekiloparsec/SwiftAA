//
//  Times.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/12/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

// MARK: -

/// The Day is physical number representing an Earth day.
/// Day structs conform to SwiftAA Numeric type protocol.
public struct Day: NumericType, CustomStringConvertible {
    
    public static func *(lhs: Day, rhs: Day) -> Day {
        return Day(lhs.value * rhs.value)
    }
    
    public static func *=(lhs: inout Day, rhs: Day) {
        lhs.value = rhs.value * lhs.value
    }
    
    public static func +(lhs: Day, rhs: Day) -> Day {
        return Day(lhs.value + rhs.value)
    }
    
    public static func +=(lhs: inout Day, rhs: Day) {
        lhs.value = rhs.value + lhs.value
    }
    
    public static func -(lhs: Day, rhs: Day) -> Day {
        return Day(lhs.value - rhs.value)
    }
    
    public static func -=(lhs: inout Day, rhs: Day) {
        lhs.value = rhs.value - lhs.value
    }
    /// The Day value
    public var value: Double
    public var magnitude: Double

    /// Returns a Day struct initialized to contain the given value.
    ///
    /// - Parameter value: The value for the new Day.
    public init(_ value: Double) {
        self.value = value
        self.magnitude = value
    }
    
    /// Transform the current Day value into Hours.
    public var inHours: Hour { return Hour(value * 24.0) }
    /// Transform the current Day value into Minutes.
    public var inMinutes: Minute { return Minute(value * 24.0 * 60.0) }
    /// Transform the current Day value into Seconds.
    public var inSeconds: Second { return Second(value * 24.0 * 3600.0) }
    /// Transform the current Day value into Julian Days (convenient for easily making operations with Julian Day fractions).
    public var inJulianDays: JulianDay { return JulianDay(value) }
    
    /// The standard description of the Day
    public var description: String { return String(format: "%.2f d", value) }
}

/// The Hour is physical number representing an Earth hour.
/// Hour structs conform to SwiftAA Numeric type protocol.
public struct Hour: NumericType, CustomStringConvertible {

    public var magnitude: Double
    
    public static func -=(lhs: inout Hour, rhs: Hour) {
        lhs.value = lhs.value - rhs.value
    }
    
    public static func +=(lhs: inout Hour, rhs: Hour) {
        lhs.value = rhs.value + lhs.value
    }
    
    public static func *(lhs: Hour, rhs: Hour) -> Hour {
        return Hour(lhs.value * rhs.value)
    }
    
    public static func *=(lhs: inout Hour, rhs: Hour) {
        lhs.value = rhs.value * lhs.value
    }
    
    /// The Hour value
    public var value: Double
    
    /// Returns a Hour struct initialized to contain the given value.
    ///
    /// - Parameter value: The value for the new Hour.
    public init(_ value: Double) {
        self.value = value
        self.magnitude = value
    }
    
    /// Returns a Hour struct initialized from a sexagesimal representation of the hour.
    ///
    /// - Parameters:
    ///   - sign: The sign of the hour
    ///   - hours: The hour component of the sexagesimal representation. Sign is ignored.
    ///   - minutes: The minute component of the sexagesimal representation. Sign is ignored.
    ///   - seconds: The second component of the sexagesimal representation. Sign is ignored.
    public init(_ sign: FloatingPointSign = .plus, _ hours: Int, _ minutes: Int, _ seconds: Double) {
        let absHour = abs(Double(hours))
        let absMinutes = abs(Double(minutes))/60.0
        let absSeconds = abs(seconds)/3600.0
        self.init(Double(sign) * (absHour + absMinutes + absSeconds))
    }
    
    /// Transform the current Hour value into Days.
    public var inDays: Day { return Day(value / 24.0) }
    /// Transform the current Hour value into Minutes.
    public var inMinutes: Minute { return Minute(value * 60.0) }
    /// Transform the current Hour value into Seconds.
    public var inSeconds: Second { return Second(value * 3600.0) }
    /// Transform the current Hour value into Degrees.
    public var inDegrees: Degree { return Degree(value * 15.0) }
    /// Transform the current Hour value into Julian Days (convenient for easily making operations with Julian Day fractions).
    public var inJulianDays: JulianDay { return JulianDay(value / 24.0) }
    
    /// Returns a sexagesimal representation of the hour.
    public var sexagesimalNotation: SexagesimalNotation {
        get {
            let hrs = abs(value.rounded(.towardZero))
            let min = ((abs(value) - hrs) * 60.0).rounded(.towardZero)
            let sec = ((abs(value) - hrs) * 60.0 - min) * 60.0
            return (value > 0.0 ? .plus : .minus, Int(hrs), Int(min), Double(sec))
        }
    }

    /// Returns a Hour whose value is reduced to the 0..<24 range.
    public var reduced: Hour { return Hour(value.positiveTruncatingRemainder(dividingBy: 24.0)) }
    
    /// Returns a Hour whose value is reduced to the -12..<12 range (that is, around 0, hence the name).
    public var reduced0: Hour { return Hour(value.positiveTruncatingRemainder(dividingBy: 24.0)-12.0) }
    
    /// A standard sexagesimal description of the Hour value.
    public var description: String {
        let (sign, hrs, min, sec) = self.sexagesimalNotation
        return sign.string + String(format: "%ih%im%06.3fs", hrs, min, sec)
    }
}

// MARK: -

/// The Minute is physical number representing an Earth minute.
/// Minute structs conform to SwiftAA Numeric type protocol.
public struct Minute: NumericType, CustomStringConvertible {
    
    public var magnitude: Double
    
    public static func -=(lhs: inout Minute, rhs: Minute) {
        lhs.value = lhs.value - rhs.value
    }
    
    public static func +=(lhs: inout Minute, rhs: Minute) {
        lhs.value = rhs.value + lhs.value
    }
    
    public static func *(lhs: Minute, rhs: Minute) -> Minute {
        return Minute(lhs.value * rhs.value)
    }
    
    public static func *=(lhs: inout Minute, rhs: Minute) {
        lhs.value = rhs.value * lhs.value
    }
    
    /// The Minute value
    public var value: Double
    
    /// Returns a Minute struct initialized to contain the given value.
    ///
    /// - Parameter value: The value for the new Minute.
    public init(_ value: Double) {
        self.value = value
        self.magnitude = value
    }
    
    /// Transform the current Minute value into Days.
    public var inDays: Day { return Day(value / (24.0 * 60.0)) }
    /// Transform the current Minute value into Hours.
    public var inHours: Hour { return Hour(value / 60.0) }
    /// Transform the current Minute value into Seconds.
    public var inSeconds: Second { return Second(value * 60.0) }
    /// Transform the current Minute value into Degrees.
    public var inDegrees: Degree { return Degree(value / 60.0 * 15.0) }
    /// Transform the current Minute value into Julian Days (convenient for easily making operations with Julian Day fractions).
    public var inJulianDays: JulianDay { return JulianDay(value / 1440.0) }
    
    /// Returns a Minute whose value is reduced to the 0..<60 range.
    public var reduced: Minute { return Minute(value.positiveTruncatingRemainder(dividingBy: 60.0)) }
    
    /// The standard description of the Hour
    public var description: String { return String(format: "%.2f min", value) }
}

// MARK: -

/// The Second is physical number representing an Earth second.
/// Second structs conform to SwiftAA Numeric type protocol.
public struct Second: NumericType, CustomStringConvertible {
    
    public var magnitude: Double
    
    public static func -=(lhs: inout Second, rhs: Second) {
        lhs.value = lhs.value - rhs.value
    }
    
    public static func +=(lhs: inout Second, rhs: Second) {
        lhs.value = rhs.value + lhs.value
    }
    
    public static func *(lhs: Second, rhs: Second) -> Second {
        return Second(lhs.value * rhs.value)
    }
    
    public static func *=(lhs: inout Second, rhs: Second) {
        lhs.value = rhs.value * lhs.value
    }
    
    /// The Second value
    public var value: Double
    
    /// Returns a Second struct initialized to contain the given value.
    ///
    /// - Parameter value: The value for the new Second.
    public init(_ value: Double) {
        self.value = value
        self.magnitude = value
    }
    
    /// Transform the current Second value into Days.
    public var inDays: Day { return Day(value / (24.0 * 3600.0)) }
    /// Transform the current Second value into Hour.
    public var inHours: Hour { return Hour(value / 3600.0) }
    /// Transform the current Second value into Minute.
    public var inMinutes: Minute { return Minute(value / 60.0) }
    /// Transform the current Second value into Degrees.
    public var inDegrees: Degree { return Degree(value / 3600.0 * 15.0) }
    /// Transform the current Second value into Julian Days (convenient for easily making operations with Julian Day fractions).
    public var inJulianDays: JulianDay { return JulianDay(value / 86400.0) }
    
    /// Returns a Second whose value is reduced to the 0..<60 range.
    public var reduced: Second { return Second(value.positiveTruncatingRemainder(dividingBy: 60.0)) }
    
    /// The standard description of the Second
    public var description: String { return String(format: "%.2f sec", value) }
}

