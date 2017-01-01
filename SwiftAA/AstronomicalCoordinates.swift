//
//  Coordinates.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/07/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct EquatorialCoordinates: CustomStringConvertible {
    
    public let rightAscension: Hour
    public let declination: Degree
    public let epoch: JulianDay
    
    public var alpha: Hour { return rightAscension }
    public var delta: Degree { return declination }
    public var epsilon: JulianDay { return epoch }
    
    public init(rightAscension: Hour, declination: Degree, epoch: JulianDay = StandardEpoch_J2000_0) {
        self.rightAscension = rightAscension
        self.declination = declination
        self.epoch = epoch
    }
    
    public init(alpha: Hour, delta: Degree, epsilon: JulianDay = StandardEpoch_J2000_0) {
        self.init(rightAscension: alpha, declination: delta, epoch: epsilon)
    }
    
    public func toEclipticCoordinates() -> EclipticCoordinates {
        let eclipticObliquity = KPCAANutation_MeanObliquityOfEcliptic(epoch.value)
        let components = KPCAACoordinateTransformation_Equatorial2Ecliptic(self.rightAscension.value, self.declination.value, eclipticObliquity)
        return EclipticCoordinates(lambda: Degree(components.X), beta: Degree(components.Y), epsilon: self.epoch)
    }
    
    /**
     Transform the coordinates to galactic ones.
     
     The galactic coordinates system has been defined by the International Astronomical Union 
     in 1959. In the standard equatorial system of B1950.0, the galactic North Pole
     has the coordinates: alpha = 192.25 Degree, and delta = 27.4 Degree, and the origin
     of the galactic longitude is the point (in western Sagittarius) of the galactic equator 
     which is 33º distant from the ascending node (in western Aquila) of the galactic equator
     with the equator of B1950.0.
     These values have been fixed conventionally and therefore must be considered as exact for 
     the mentionned equinox of B1950.0
     
     - returns: The corresponding galactic coordinates.
     */
    public func toGalacticCoordinates() -> GalacticCoordinates {
        let precessedCoords = self.precessedCoordinates(to: StandardEpoch_B1950_0)
        let components = KPCAACoordinateTransformation_Equatorial2Galactic(precessedCoords.rightAscension.value, precessedCoords.declination.value)
        return GalacticCoordinates(l: Degree(components.X), b: Degree(components.Y))
    }
    
    public func toHorizontalCoordinates(forGeographicalCoordinates coords: GeographicCoordinates, julianDay: JulianDay) -> HorizontalCoordinates {
        let lha = (julianDay.meanLocalSiderealTime(forGeographicLongitude: coords.longitude.value) - rightAscension).reduced
        let components = KPCAACoordinateTransformation_Equatorial2Horizontal(lha.value, self.declination.value, coords.latitude.value)
        return HorizontalCoordinates(azimuth: Degree(components.X),
                                     altitude: Degree(components.Y),
                                     geographicCoordinates: coords,
                                     julianDay: julianDay,
                                     epoch: self.epoch)
    }
    
    public func precessedCoordinates(to newEpoch: JulianDay) -> EquatorialCoordinates {
        let components = KPCAAPrecession_PrecessEquatorial(self.rightAscension.value, self.declination.value, self.epoch.value, newEpoch.value)
        return EquatorialCoordinates(alpha: Hour(components.X), delta: Degree(components.Y), epsilon: newEpoch)
    }
    
    public func angularSeparation(from otherCoordinates: EquatorialCoordinates) -> Degree {
        return Degree(KPCAAAngularSeparation_Separation(self.alpha.value,
                                                        self.delta.value,
                                                        otherCoordinates.alpha.value,
                                                        otherCoordinates.delta.value))
    }
    
    public func positionAngle(with otherCoordinates: EquatorialCoordinates) -> Degree {
        return Degree(KPCAAAngularSeparation_PositionAngle(self.alpha.value,
                                                           self.delta.value,
                                                           otherCoordinates.alpha.value,
                                                           otherCoordinates.delta.value))
    }
    
    public var description: String { return String(format: "α=%@, δ=%@", alpha.description, delta.description) }
    
}

// MARK: -

public struct EclipticCoordinates: CustomStringConvertible {
    
    public let celestialLongitude: Degree
    public let celestialLatitude: Degree
    public let epoch: JulianDay
    
    public var lambda: Degree { return celestialLongitude }
    public var beta: Degree { return celestialLatitude }
    public var epsilon: JulianDay { return epoch }
    
    public init(celestialLongitude: Degree, celestialLatitude: Degree, epoch: JulianDay = StandardEpoch_J2000_0) {
        self.celestialLongitude = celestialLongitude
        self.celestialLatitude = celestialLatitude
        self.epoch = epoch
    }
    
    public init(lambda: Degree, beta: Degree, epsilon: JulianDay = StandardEpoch_J2000_0) {
        self.init(celestialLongitude: lambda, celestialLatitude: beta, epoch: epsilon)
    }
    
    public func toEquatorialCoordinates() -> EquatorialCoordinates {
        let eclipticObliquity = KPCAANutation_MeanObliquityOfEcliptic(StandardEpoch_J2000_0.value)
        let components = KPCAACoordinateTransformation_Ecliptic2Equatorial(self.celestialLongitude.value, self.celestialLatitude.value, eclipticObliquity)
        return EquatorialCoordinates(alpha: Hour(components.X), delta: Degree(components.Y), epsilon: self.epoch)
    }

    public func toApparentEquatorialCoordinates() -> EquatorialCoordinates {
        let eclipticObliquity = KPCAANutation_TrueObliquityOfEcliptic(epoch.value)
        let components = KPCAACoordinateTransformation_Ecliptic2Equatorial(self.celestialLongitude.value, self.celestialLatitude.value, eclipticObliquity)
        return EquatorialCoordinates(alpha: Hour(components.X), delta: Degree(components.Y), epsilon: self.epoch)
    }

    public func precessedCoordinates(to newEpoch: JulianDay) -> EclipticCoordinates {
        let components = KPCAAPrecession_PrecessEcliptic(self.celestialLongitude.value, self.celestialLatitude.value, self.epoch.value, newEpoch.value)
        return EclipticCoordinates(lambda: Degree(components.X), beta: Degree(components.Y), epsilon: newEpoch)
    }
    
    public var description: String { return String(format: "λ=%@, β=%@", lambda.description, beta.description) }
    
}

// MARK: -

public struct GalacticCoordinates: CustomStringConvertible {
    
    public let galacticLongitude: Degree
    public let galacticLatitude: Degree
    public let epoch: JulianDay

    public var l: Degree { return galacticLongitude }
    public var b: Degree { return galacticLatitude }
    public var epsilon: JulianDay { return epoch }
    
    public init(galacticLongitude: Degree, galacticLatitude: Degree, epoch: JulianDay = StandardEpoch_B1950_0) {
        self.galacticLongitude = galacticLongitude
        self.galacticLatitude = galacticLatitude
        self.epoch = epoch
    }
    
    public init(l: Degree, b: Degree, epsilon: JulianDay = StandardEpoch_B1950_0) {
        self.init(galacticLongitude: l, galacticLatitude: b, epoch: epsilon)
    }
    
    /**
     Transform the coordinates to equatorial ones.
     Careful: the epoch is necessarily that of the galactic coordinates which is always B1950.0.
     
     - returns: The corresponding equatorial coordinates.
     */
    public func toEquatorialCoordinates() -> EquatorialCoordinates {
        let components = KPCAACoordinateTransformation_Galactic2Equatorial(self.galacticLongitude.value, self.galacticLatitude.value)
        return EquatorialCoordinates(alpha: Hour(components.X), delta: Degree(components.Y), epsilon: self.epoch)
    }
    
    public var description: String { return String(format: "l=%@, b=%@", l.description, b.description) }
    
}

// MARK: -

public struct HorizontalCoordinates: CustomStringConvertible {
    public let azimuth: Degree // westward from the South see AA. p91
    public let altitude: Degree
    public let geographicCoordinates: GeographicCoordinates
    public let julianDay: JulianDay
    public let epoch: JulianDay
    
    public var northBasedAzimuth: Degree { return (azimuth + 180).reduced }
    
    public init(azimuth: Degree, altitude: Degree, geographicCoordinates: GeographicCoordinates, julianDay: JulianDay, epoch: JulianDay = StandardEpoch_J2000_0) {
        self.azimuth = azimuth
        self.altitude = altitude
        self.geographicCoordinates = geographicCoordinates
        self.julianDay = julianDay
        self.epoch = epoch
    }
    
    public func toEquatorialCoordinates() -> EquatorialCoordinates {
        let components = KPCAACoordinateTransformation_Horizontal2Equatorial(self.azimuth.value,
                                                                             self.altitude.value,
                                                                             self.geographicCoordinates.latitude.value)
        let lst = julianDay.meanLocalSiderealTime(forGeographicLongitude: geographicCoordinates.longitude.value)
        return EquatorialCoordinates(alpha: Hour(lst.value - components.X).reduced, delta: Degree(components.Y), epsilon: self.epoch)
    }
    
    public var description: String { return String(format: "A=%@, h=%@", azimuth.description, altitude.description) }
    
}


