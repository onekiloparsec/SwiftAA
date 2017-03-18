//
//  Coordinates.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/07/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

/// The Equatorial coordinates are the coordinates of an object in the equatorial system (based on Earth equator).
public struct EquatorialCoordinates: CustomStringConvertible {
    
    /// The right ascension
    public let rightAscension: Hour
    /// The declination
    public let declination: Degree
    /// The epoch of the coordinates.
    public let epoch: JulianDay
    
    /// Convenience accessor for the right ascension
    public var alpha: Hour { return rightAscension }
    /// Convenience accessor of the declination
    public var delta: Degree { return declination }
    
    /// Returns an EquatorialCoordinates oject.
    ///
    /// - Parameters:
    ///   - rightAscension: The right ascension value
    ///   - declination: The declination value
    ///   - epoch: The optional epoch, default to J2000.0
    public init(rightAscension: Hour, declination: Degree, epoch: JulianDay = StandardEpoch_J2000_0) {
        self.rightAscension = rightAscension
        self.declination = declination
        self.epoch = epoch
    }
    
    /// Returns an EquatorialCoordinates oject.
    ///
    /// - Parameters:
    ///   - alpha: The alpha (R.A.) value
    ///   - delta: The delta (Dec.) value
    ///   - epoch: The optional epoch value, default to J2000.0. It is not called 'epsilon' to avoid confusion with equinox.
    public init(alpha: Hour, delta: Degree, epoch: JulianDay = StandardEpoch_J2000_0) {
        self.init(rightAscension: alpha, declination: delta, epoch: epoch)
    }
    
    /// Returns the coordinates transformed into the ecliptic (celestial) system.
    ///
    /// - Returns: A new EclipticCoordinates object.
    public func makeEclipticCoordinates() -> EclipticCoordinates {
        let eclipticObliquity = KPCAANutation_MeanObliquityOfEcliptic(epoch.value)
        let components = KPCAACoordinateTransformation_Equatorial2Ecliptic(self.rightAscension.value, self.declination.value, eclipticObliquity)
        return EclipticCoordinates(lambda: Degree(components.X), beta: Degree(components.Y), epoch: self.epoch)
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
    public func makeGalacticCoordinates() -> GalacticCoordinates {
        let precessedCoords = self.precessedCoordinates(to: StandardEpoch_B1950_0)
        let components = KPCAACoordinateTransformation_Equatorial2Galactic(precessedCoords.rightAscension.value, precessedCoords.declination.value)
        return GalacticCoordinates(l: Degree(components.X), b: Degree(components.Y))
    }
    
    public func makeHorizontalCoordinates(with coords: GeographicCoordinates, julianDay: JulianDay) -> HorizontalCoordinates {
        let lha = (julianDay.meanLocalSiderealTime(longitude: coords.longitude) - rightAscension).reduced
        let components = KPCAACoordinateTransformation_Equatorial2Horizontal(lha.value, self.declination.value, coords.latitude.value)
        return HorizontalCoordinates(azimuth: Degree(components.X),
                                     altitude: Degree(components.Y),
                                     geographicCoordinates: coords)
    }
    
    /// Returns new EquatorialCoordinates precessed to a new given epoch.
    ///
    /// - Parameter newEpoch: The new epoch to precess to.
    /// - Returns: A new EquatorialCoordinates object
    public func precessedCoordinates(to newEpoch: JulianDay) -> EquatorialCoordinates {
        let components = KPCAAPrecession_PrecessEquatorial(self.rightAscension.value, self.declination.value, self.epoch.value, newEpoch.value)
        return EquatorialCoordinates(alpha: Hour(components.X), delta: Degree(components.Y), epoch: newEpoch)
    }
    
    /// Returns the angular separation between two equatorial coordinates.
    ///
    /// - Parameter otherCoordinates: The other coordinates to consider.
    /// - Returns: A angle value, between the two coordinates.
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

/// The Equatorial coordinates are the coordinates of an object in the ecliptic (a.k.a. celestial) system
/// (based on Earth orbital plane).
public struct EclipticCoordinates: CustomStringConvertible {
    
    /// The celestial longitude
    public let celestialLongitude: Degree
    /// The celestial latitude
    public let celestialLatitude: Degree
    /// The epoch of the coordinates.
    public let epoch: JulianDay
    
    /// A convenience accessor for the celestial longitude
    public var lambda: Degree { return celestialLongitude }
    /// A convenience accessor for the celestial latitude
    public var beta: Degree { return celestialLatitude }
    
    /// Returns a new EclipticCoordinates object.
    ///
    /// - Parameters:
    ///   - celestialLongitude: The celestial longitude value
    ///   - celestialLatitude: The celestial latitude value
    ///   - epoch: The optional epoch value, default to J2000.0
    public init(celestialLongitude: Degree, celestialLatitude: Degree, epoch: JulianDay = StandardEpoch_J2000_0) {
        self.celestialLongitude = celestialLongitude
        self.celestialLatitude = celestialLatitude
        self.epoch = epoch
    }
    
    /// Returns a new EclipticCoordinates object.
    ///
    /// - Parameters:
    ///   - lambda: The longitude value.
    ///   - beta: The latitude value
    ///   - epoch: The optional epoch value, default to J2000.0. It is not called 'epsilon' to avoid confusion with equinox.
    public init(lambda: Degree, beta: Degree, epoch: JulianDay = StandardEpoch_J2000_0) {
        self.init(celestialLongitude: lambda, celestialLatitude: beta, epoch: epoch)
    }
    
    /// Returns the equatorial coordinates corresponding to the current ecliptic ones.
    ///
    /// - Returns: A new equatorial coordinates object
    public func makeEquatorialCoordinates() -> EquatorialCoordinates {
        let eclipticObliquity = KPCAANutation_MeanObliquityOfEcliptic(self.epoch.value)
        let components = KPCAACoordinateTransformation_Ecliptic2Equatorial(self.celestialLongitude.value, self.celestialLatitude.value, eclipticObliquity)
        return EquatorialCoordinates(alpha: Hour(components.X), delta: Degree(components.Y), epoch: self.epoch)
    }

    /// Returns the apparent equatorial coordinates corresponding to the current ecliptic ones.
    ///
    /// - Returns: A new equatorial coordinates object
    public func makeApparentEquatorialCoordinates() -> EquatorialCoordinates {
        let eclipticObliquity = KPCAANutation_TrueObliquityOfEcliptic(self.epoch.value)
        let components = KPCAACoordinateTransformation_Ecliptic2Equatorial(self.celestialLongitude.value, self.celestialLatitude.value, eclipticObliquity)
        return EquatorialCoordinates(alpha: Hour(components.X), delta: Degree(components.Y), epoch: self.epoch)
    }

    /// Returns new EclipticCoordinates precessed to a new given epoch.
    ///
    /// - Parameter newEpoch: The new epoch to precess to.
    /// - Returns: A new EclipticCoordinates object
    public func precessedCoordinates(to newEpoch: JulianDay) -> EclipticCoordinates {
        let components = KPCAAPrecession_PrecessEcliptic(self.celestialLongitude.value, self.celestialLatitude.value, self.epoch.value, newEpoch.value)
        return EclipticCoordinates(lambda: Degree(components.X), beta: Degree(components.Y), epoch: newEpoch)
    }
    
    public var description: String {
        return String(format: "λ=%@, β=%@ (epoch %@)", lambda.description, beta.description, epoch.description)
    }
    
}

// MARK: -

/// The Galactic coordinates are the coordinates of an object in the Milky Way galactic system.
public struct GalacticCoordinates: CustomStringConvertible {
    
    /// The galactic longitude
    public let galacticLongitude: Degree
    /// The galactic latitude
    public let galacticLatitude: Degree
    /// The epoch of the coordinates
    public let epoch: JulianDay

    /// A convenience accessor for the galactic longitude
    public var l: Degree { return galacticLongitude }
    /// A convenience accessor for the galactic latitude
    public var b: Degree { return galacticLatitude }
    
    /// Returns a new GalacticCoordinates object
    ///
    /// - Parameters:
    ///   - galacticLongitude: The galactic longitude
    ///   - galacticLatitude: The galactic latitude
    ///   - epoch: The epoch of coordinates. Default is B1950.0
    public init(galacticLongitude: Degree, galacticLatitude: Degree, epoch: JulianDay = StandardEpoch_B1950_0) {
        self.galacticLongitude = galacticLongitude
        self.galacticLatitude = galacticLatitude
        self.epoch = epoch
    }
    
    /// Returns a new GalacticCoordinates object
    ///
    /// - Parameters:
    ///   - l: The galactic longitude
    ///   - b: The galactic latitude
    ///   - epoch: The epoch of coordinates. Default is B1950.0
    public init(l: Degree, b: Degree, epoch: JulianDay = StandardEpoch_B1950_0) {
        self.init(galacticLongitude: l, galacticLatitude: b, epoch: epoch)
    }
    
    /// Returns the equatorial coordinates corresponding to the current galactic one.
    /// Careful: the epoch should necessarily be that of the galactic coordinates which is always B1950.0.
    ///
    /// - Returns: A new EquatorialCoordinates object.
    public func makeEquatorialCoordinates() -> EquatorialCoordinates {
        let components = KPCAACoordinateTransformation_Galactic2Equatorial(self.galacticLongitude.value, self.galacticLatitude.value)
        return EquatorialCoordinates(alpha: Hour(components.X), delta: Degree(components.Y), epoch: self.epoch)
    }
    
    public var description: String { return String(format: "l=%@, b=%@ (epoch %@)", l.description, b.description, epoch.description) }
    
}

// MARK: -

/// The HorizontalCoordinates are the coordinates of an object as seen from a location on Earth.
public struct HorizontalCoordinates: CustomStringConvertible {
    /// The azimuth, westward from the South see AA. p91
    public let azimuth: Degree
    /// The altitude
    public let altitude: Degree
    /// The location on Earth
    public let geographicCoordinates: GeographicCoordinates?
    
    /// The azimuth angle, starting from the North.
    public var northBasedAzimuth: Degree { return (azimuth + 180).reduced }
    
    /// Returns a new HorizontalCoordinates object
    ///
    /// - Parameters:
    ///   - azimuth: The azimuth value.
    ///   - altitude: The altitude value
    ///   - geographicCoordinates: The location on Earth.
    public init(azimuth: Degree, altitude: Degree, geographicCoordinates: GeographicCoordinates? = nil) {
        self.azimuth = azimuth
        self.altitude = altitude
        self.geographicCoordinates = geographicCoordinates
    }
    
    /// Returns the equivalent Equatorial coordinates for the given Julian Day.
    ///
    /// - Parameters:
    ///   - julianDay: The julian day at which the coordinates are returned.
    ///   - epoch: The optional epoch value, default to J2000.0
    /// - Returns: A new EquatorialCoordinates object.
    public func makeEquatorialCoordinates(julianDay: JulianDay, epoch: JulianDay = StandardEpoch_J2000_0) -> EquatorialCoordinates? {
        let components = KPCAACoordinateTransformation_Horizontal2Equatorial(self.azimuth.value,
                                                                             self.altitude.value,
                                                                             self.geographicCoordinates!.latitude.value)
        let lst = julianDay.meanLocalSiderealTime(longitude: geographicCoordinates!.longitude)
        return EquatorialCoordinates(alpha: Hour(lst.value - components.X).reduced, delta: Degree(components.Y), epoch: epoch)
    }
    
    /// Returns the angular separation between two horizontal coordinates.
    ///
    /// - Parameter otherCoordinates: The other coordinates to consider.
    /// - Returns: A angle value, between the two coordinates.
    public func angularSeparation(with otherCoordinates: HorizontalCoordinates) -> Degree {
        // note: we actually use AA method for *equatorial* coordinates separation (works fine for horizontal coordinates)
        return Degree(KPCAAAngularSeparation_Separation(self.azimuth.inHours.value, self.altitude.value, otherCoordinates.azimuth.inHours.value, otherCoordinates.altitude.value))
    }
    
    public var description: String { return String(format: "A=%@, h=%@", azimuth.description, altitude.description) }
    
}


