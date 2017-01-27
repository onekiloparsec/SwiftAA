//
//  Times.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/12/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Hour: NumericType, CustomStringConvertible {
    public let value: Double
    public init(_ value: Double) {
        self.value = value
    }
    public init(_ hours: Double, _ minutes: Double, _ seconds: Double) {
        guard hours.sign == minutes.sign && hours.sign == seconds.sign else {
            fatalError("hours/minutes/seconds must have the same sign")
        }
        self.init(hours + minutes/60.0 + seconds/3600.0)
    }
    
    public var inMinutes: Minute { return Minute(value * 60.0) }
    public var inSeconds: Second { return Second(value * 3600.0) }
    public var inDegrees: Degree { return Degree(value * 15.0) }
    public var inDays: JulianDay { return JulianDay(value / 24.0) }
    
    /// Returns self reduced to 0..<24 range
    public var reduced: Hour { return Hour(value.positiveTruncatingRemainder(dividingBy: 24.0)) }
    
    public var description: String {
        let (sign, hrs, min, sec) = self.sexagesimalNotation()
        let signSymbol = (sign == true) ? "+" : "-"
        return String(format: "%s%.0fh%02.0fm%04.1fs", signSymbol, abs(hrs.value), abs(min.value), abs(sec.value))
    }
    
    public func sexagesimalNotation() -> (Bool, Hour, Minute, Second) {
        let hrs = abs(value.rounded(.towardZero))
        let min = ((abs(value) - hrs) * 60.0).rounded(.towardZero)
        let sec = ((abs(value) - hrs) * 60.0 - min) * 60.0
        return (value > 0.0, Hour(hrs), Minute(min), Second(sec))
    }
}

// MARK: -

public struct Minute: NumericType, CustomStringConvertible {
    public let value: Double
    public init(_ value: Double) {
        self.value = value
    }
    
    public var inHours: Hour { return Hour(value / 60.0) }
    public var inSeconds: Second { return Second(value * 60.0) }
    public var inDegrees: Degree { return Degree(value / 60.0 * 15.0) }
    public var inDays: JulianDay { return JulianDay(value / 1440.0) }
    
    /// Returns self reduced to 0..<60 range
    public var reduced: Minute { return Minute(value.positiveTruncatingRemainder(dividingBy: 60.0)) }
    
    public var description: String { return String(format: "%.2f min", value) }
}

// MARK: -

public struct Second: NumericType, CustomStringConvertible {
    public let value: Double
    public init(_ value: Double) {
        self.value = value
    }
    
    public var inHours: Hour { return Hour(value / 3600.0) }
    public var inMinutes: Minute { return Minute(value / 60.0) }
    public var inDegrees: Degree { return Degree(value / 3600.0 * 15.0) }
    public var inDays: JulianDay { return JulianDay(value / 86400.0) }
    
    /// Returns self reduced to 0..<60 range
    public var reduced: Second { return Second(value.positiveTruncatingRemainder(dividingBy: 60.0)) }
    
    public var description: String { return String(format: "%.2f sec", value) }
}

