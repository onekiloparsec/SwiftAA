//
//  Times.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/12/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Hour: NumericType {
    public let value: Double
    public init(_ value: Double) {
        self.value = value
    }
    
    public func inMinutes() -> Minute { return Minute(self.value * 60.0) }
    public func inSeconds() -> Second { return Second(self.value * 3600.0) }
    public func inDegrees() -> Degree { return Degree(self.value * 15.0) }
    
    /// Returns self reduced to 0..<24 range
    public var reduced: Hour { return Hour(value.positiveTruncatingRemainder(dividingBy: 24.0)) }
    
}

extension Hour: CustomStringConvertible {
    public var description: String {
        let hrs = value.rounded(.towardZero)
        let min = ((value - hrs) * 60.0).rounded(.towardZero)
        let sec = ((value - hrs) * 60.0 - min) * 60.0
        return String(format: "%.0fh%02.0fm%04.1fs", hrs, abs(min), abs(sec))
    }
}

//--

public struct Minute: NumericType {
    public let value: Double
    public init(_ value: Double) {
        self.value = value
    }
    
    public func inHours() -> Hour { return Hour(self.value / 60.0) }
    public func inSeconds() -> Second { return Second(self.value * 60.0) }
    public func inDegrees() -> Degree { return Degree(self.value / 60.0 * 15.0) }
    
    /// Returns self reduced to 0..<60 range
    public var reduced: Minute { return Minute(value.positiveTruncatingRemainder(dividingBy: 60.0)) }
    
}

//-- 

public struct Second: NumericType {
    public let value: Double
    public init(_ value: Double) {
        self.value = value
    }
    
    public func inHours() -> Hour { return Hour(self.value / 3600.0) }
    public func inMinutes() -> Minute { return Minute(self.value / 60.0) }
    public func inDegrees() -> Degree { return Degree(self.value / 3600.0 * 15.0) }
    
    /// Returns self reduced to 0..<60 range
    public var reduced: Second { return Second(value.positiveTruncatingRemainder(dividingBy: 60.0)) }
    
}

