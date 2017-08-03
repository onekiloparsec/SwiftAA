//
//  Fluxes.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 27/02/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import Foundation

/// The Magnitude is a unit of flux.
/// Magnitude structs conform to SwiftAA Numeric type protocol.
public struct SpaceMagnitude: NumericType {
    public static func -=(lhs: inout SpaceMagnitude, rhs: SpaceMagnitude) {
        lhs.value = rhs.value - lhs.value
    }
    
    public static func +=(lhs: inout SpaceMagnitude, rhs: SpaceMagnitude) {
        lhs.value = rhs.value + lhs.value
    }
    
    public static func *(lhs: SpaceMagnitude, rhs: SpaceMagnitude) -> SpaceMagnitude {
        let value = lhs.value * rhs.value
        return SpaceMagnitude(value)
    }
    
    public static func *=(lhs: inout SpaceMagnitude, rhs: SpaceMagnitude) {
        lhs.value = rhs.value * lhs.value
    }
    
    public init?<T>(exactly source: T) where T : BinaryInteger {
        self.init(1.0)
    }
    
    public var magnitude: Double

    /// The SpaceMagnitude value
    public var value: Double
    
    /// Returns a new SpaceMagnitude object
    ///
    /// - Parameter value: The SpaceMagnitude value
    public init(_ value: Double) {
        self.value = value
        self.magnitude = value
    }
}
