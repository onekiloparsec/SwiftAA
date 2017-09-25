//
//  Fluxes.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 27/02/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import Foundation

/// The Magnitude is a unit of flux.
public struct Magnitude: NumericType {
    /// The Magnitude value
    public let value: Double
    
    /// Creates a new Magnitude instance.
    ///
    /// - Parameter value: The Magnitude value
    public init(_ value: Double) {
        self.value = value
    }
}
