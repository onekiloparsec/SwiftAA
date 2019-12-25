//
//  Distances.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 26/06/16.
//  MIT Licence. See LICENCE file.
//

import Foundation
import ObjCAA

/// The AstronomicalUnit is a unit of distance.
public struct AstronomicalUnit: NumericType, CustomStringConvertible {
    /// The AstronomicalUnit value
    public let value: Double
    
    /// Creates a new AstronomicalUnit instance.
    ///
    /// - Parameter value: The value of AstronomicalUnit.
    public init(_ value: Double) {
        self.value = value
    }
    
    /// Transform the current AstronomicalUnit in Parsecs
    public var inParsecs: Parsec { return Parsec(value * AU2pc) }
    /// Transform the current AstronomicalUnit in kilometers
    public var inKilometers: Kilometer { return self.inMeters.inKilometers }
    /// Transform the current AstronomicalUnit in Meters
    public var inMeters:  Meter  { return Meter(value * AU2m) }
    /// Transform the current AstronomicalUnit in light-years
    public var inLightYears: Double { return value * AU2ly }
    
    /// Returns the equatorial horizontal parallax value corresponding to the current distance
    /// of a solar system body, used in the difference between the toppocentric (as seen from 
    /// the observer's place) and geocentric coordinates (as seen from the Earth center).
    ///
    /// - Returns: The parallax value.
    public func equatorialHorizontalParallax() -> ArcSecond {
        return Degree(KPCAAParallax_DistanceToParallax(value)).inArcSeconds
    }

    public var description: String { return String(format: "%.2f AU", value) }
}

// MARK: -

/// The Parsec is a unit of distance.
public struct Parsec: NumericType, CustomStringConvertible {
    /// The Parsec value
    public let value: Double
    
    /// Creates a new Parsec instance.
    ///
    /// - Parameter value: The value of Parsec.
    public init(_ value: Double) {
        self.value = value
    }
    
    /// Transform the current Parsec in AstronomicalUnits
    public var inAstronomicalUnits: AstronomicalUnit { return AstronomicalUnit(value / AU2pc) }
    public var description: String { return String(format: "%.1f pc", value) }

    /// Returns the parallax value corresponding to the current distance.
    ///
    /// - Returns: The parallax value.
    public func parallax() -> ArcSecond {
        guard self.value > 0 else { fatalError("Value must be positive and above 0") }
        return ArcSecond(1.0/value)
    }
}



// MARK: -

/// The Meter is a unit of distance.
public struct Meter: NumericType, CustomStringConvertible {
    /// The Meter value
    public let value: Double
    
    /// Creates a new Meter instance.
    ///
    /// - Parameter value: The value of Meter.
    public init(_ value: Double) {
        self.value = value
    }
    
    /// Transform the current Meter in kilometers
    public var inKilometers: Kilometer { return Kilometer(value / 1000.0) }
    /// Transform the current Meter in AstronomicalUnit.
    public var inAstronomicalUnits: AstronomicalUnit { return AstronomicalUnit(value / AU2m) }

    public var description: String { return String(format: "%.1f m", value) }
}

/// The Kilometer is a unit of distance.
public struct Kilometer: NumericType, CustomStringConvertible {
    /// The Meter value
    public let value: Double
    
    /// Creates a new Kilometer instance.
    ///
    /// - Parameter value: The value of Kilometer.
    public init(_ value: Double) {
        self.value = value
    }
    
    /// Transform the current Kilometer in Meter
    public var inMeters: Meter { return Meter(value * 1000.0) }
    public var description: String { return String(format: "%.1f km", value) }
}


