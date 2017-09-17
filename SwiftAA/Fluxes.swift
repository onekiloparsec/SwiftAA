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
public struct Magnitude: NumericType {
    /// The Magnitude value
    public let value: Double
    
    /// Returns a new Magnitude object
    ///
    /// - Parameter value: The Magnitude value
    public init(_ value: Double) {
        self.value = value
    }
}
