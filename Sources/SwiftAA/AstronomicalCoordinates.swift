//
//  Coordinates.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/07/16.
//  MIT Licence. See LICENCE file.
//

import Foundation
import ObjCAA

/// Struct to encapsulate amount of proper motion in equatorial reference.
public struct ProperMotion {
    /// The annual delta in right ascension
    public let deltaRightAscension: Second
    /// The annual delta in declination
    public let deltaDeclination: ArcSecond
}

/// The coordinates of an object in the equatorial system, based on Earth equator.
public struct EquatorialCoordinates: CustomStringConvertible {
    
    /// The right ascension
    public let rightAscension: Hour
    /// The declination
    public let declination: Degree
    /// The epoch of the coordinates.
    public let epoch: Epoch
    /// The reference equinox.
    public let equinox: Equinox
    
    /// Convenience accessor for the right ascension
    public var alpha: Hour { return rightAscension }
    /// Convenience accessor of the declination
    public var delta: Degree { return declination }
    
    /// Creates an EquatorialCoordinates instance.
    ///
    /// - Parameters:
    ///   - rightAscension: The right ascension value
    ///   - declination: The declination value
    ///   - epoch: The optional epoch, default to J2000.0.
    ///   - equinox: The optional equinox, default to standard equinox J2000.0.
    public init(rightAscension: Hour, declination: Degree, epoch: Epoch = .J2000, equinox: Equinox = .standardJ2000) {
        self.rightAscension = rightAscension
        self.declination = declination
        self.epoch = epoch
        self.equinox = equinox
    }
    
    /// Creates an EquatorialCoordinates instance.
    ///
    /// - Parameters:
    ///   - alpha: The alpha (R.A.) value
    ///   - delta: The delta (Dec.) value
    ///   - epoch: The optional epoch value, default to J2000.0. It is not called 'epsilon' to avoid confusion with equinox.
    ///   - equinox: The optional equinox, default to standard equinox J2000.0.
    public init(alpha: Hour, delta: Degree, epoch: Epoch = .J2000, equinox: Equinox = .standardJ2000) {
        self.init(rightAscension: alpha, declination: delta, epoch: epoch, equinox: equinox)
    }
    
    /// Transform the coordinates to the ecliptic (celestial) system, at same epoch and for the same equinox.
    ///
    /// During the transformation, the mean obliquity of the ecliptic of the date (epoch) is used. Recall that the
    /// obliquity of the ecliptic is the inclination of Earth's rotation axis, or the angle between equator and
    /// the ecliptic, that is, the Earth orbital plane. 'Mean' here means that nutation is not taken into account.
    ///
    /// - Returns: A new EclipticCoordinates object.
    public func makeEclipticCoordinates() -> EclipticCoordinates {
        let eclipticObliquity = KPCAANutation_MeanObliquityOfEcliptic(self.epoch.julianDay.value)
        let components = KPCAACoordinateTransformation_Equatorial2Ecliptic(self.rightAscension.value, self.declination.value, eclipticObliquity)
        return EclipticCoordinates(lambda: Degree(components.X), beta: Degree(components.Y), epoch: self.epoch, equinox: self.equinox)
    }

    /// The galactic (Milky Way) North Pole equatorial coordinates.
    /// 
    /// These coordinates have been fixed conventionally and must be considered as expect for the equinox B1950.
    /// They have been defined by the International Astronomical Union in 1959. The origin
    /// of the galactic longitude is the point (in western Sagittarius) of the galactic equator
    /// which is 33º distant from the ascending node (in western Aquila) of the galactic equator
    /// with the equator of B1950.0. See AA p.94.
    ///
    /// - Returns: A new EquatorialCoordinates instance.
    public static func adoptedGalacticNorthPole() -> EquatorialCoordinates {
        return EquatorialCoordinates(alpha: Hour(.plus, 12, 49, 0.0), delta: Degree(27.4), epoch: .B1950, equinox: .standardB1950)
    }

    /// Transform the coordinates to the galactic system, at same epoch and for the same equinox.
    ///
    /// - Returns: A new galactic coordinates instance.
    public func makeGalacticCoordinates() -> GalacticCoordinates {
        let components = KPCAACoordinateTransformation_Equatorial2Galactic(self.rightAscension.value, self.declination.value)
        return GalacticCoordinates(l: Degree(components.X), b: Degree(components.Y), epoch: self.epoch, equinox: self.equinox)
    }
    
    /// Transforms the coordinates into horizontal (local) ones for a given observer location.
    ///
    /// - Parameters:
    ///   - location: The geographic location of the observer.
    ///   - julianDay: The julian day of observation.
    /// - Returns: A new horizontal coordinates instance.
    public func makeHorizontalCoordinates(for location: GeographicCoordinates, at julianDay: JulianDay) -> HorizontalCoordinates {
        let lha = (julianDay.meanLocalSiderealTime(longitude: location.longitude) - rightAscension).reduced
        let components = KPCAACoordinateTransformation_Equatorial2Horizontal(lha.value, self.declination.value, location.latitude.value)
        return HorizontalCoordinates(azimuth: Degree(components.X),
                                     altitude: Degree(components.Y),
                                     geographicCoordinates: location,
                                     julianDay: julianDay)
    }
    
    /// Returns new EquatorialCoordinates precessed to the given epoch.
    ///
    /// - Parameter newEquinox: The new equinox to precess to.
    /// - Returns: A new EquatorialCoordinates instance.
    public func precessedCoordinates(to newEquinox: Equinox) -> EquatorialCoordinates {
        let components = KPCAAPrecession_PrecessEquatorial(self.rightAscension.value,
                                                           self.declination.value,
                                                           self.equinox.julianDay.value,
                                                           newEquinox.julianDay.value)
        
        return EquatorialCoordinates(alpha: Hour(components.X),
                                     delta: Degree(components.Y),
                                     epoch: self.epoch,
                                     equinox: newEquinox)
    }
    
    /// Returns new EquatorialCoordinates shifted to the new epoch by the given proper motion.
    ///
    /// - Parameters:
    ///   - newEpoch: The new epoch of coordinates.
    ///   - properMotion: The amount of proper motion
    /// - Returns: A new EquatorialCoordinates instance.
    public func shiftedCoordinates(to newEpoch: Epoch, with properMotion: ProperMotion) -> EquatorialCoordinates {
        let deltaJDinJulianYears = (newEpoch.julianDay.value - self.epoch.julianDay.value) / JulianYear.value

        let shiftAlpha = Second(properMotion.deltaRightAscension.value * deltaJDinJulianYears)
        let shiftDelta = ArcSecond(properMotion.deltaDeclination.value * deltaJDinJulianYears)

        return EquatorialCoordinates(alpha: self.alpha + shiftAlpha.inHours,
                                     delta: self.delta + shiftDelta.inDegrees,
                                     epoch: newEpoch,
                                     equinox: self.equinox)
    }
    
    /// Returns the angular separation between two equatorial coordinates.
    ///
    /// - Parameter otherCoordinates: The other coordinates to consider.
    /// - Returns: A angle value, between the two coordinates.
    public func angularSeparation(with otherCoordinates: EquatorialCoordinates) -> Degree {
        return Degree(KPCAAAngularSeparation_Separation(self.alpha.value,
                                                        self.delta.value,
                                                        otherCoordinates.alpha.value,
                                                        otherCoordinates.delta.value))
    }
    
    /// Returns the position angle relative to other coordinates.
    ///
    /// - Parameter otherCoordinates: The other coordinates.
    /// - Returns: The position angle between the two coordinates.
    public func positionAngle(relativeTo otherCoordinates: EquatorialCoordinates) -> Degree {
        return Degree(KPCAAAngularSeparation_PositionAngle(self.alpha.value,
                                                           self.delta.value,
                                                           otherCoordinates.alpha.value,
                                                           otherCoordinates.delta.value))
    }
    
    /// Return new ecliptic coordinates corrected for the annual aberration of the Earth. It must be used for star coordinates, not planets.
    /// See AA, p149.
    ///
    /// - parameter julianDay:     The julian day for which the aberration is computed.
    /// - parameter highPrecision: If `false`, the Ron-Vondrák algorithm is used. See AA p.153. If `true`, the newer VSOP87 theory is used.
    ///
    /// - returns: Corected ecliptic coordinates of the star.
    public func correctedForAnnualAberration(julianDay: JulianDay, highPrecision: Bool = true) -> EquatorialCoordinates {
        let diff = KPCAAAberration_EquatorialAberration(self.alpha.value, self.delta.value, julianDay.value, highPrecision)
        return EquatorialCoordinates(alpha: Hour(self.alpha.value+diff.X), delta: Degree(self.delta.value+diff.Y), epoch: self.epoch)
    }

    /// Description of EquatorialCoordinates
    public var description: String {
        return String(format: "α=%@, δ=%@ (epoch %@, equinox %@)", alpha.description, delta.description, epoch.description, equinox.description)
    }
    
}

// MARK: -

/// The coordinates in the ecliptic (a.k.a. celestial) system, based on solar-system planets orbital planes.
public struct EclipticCoordinates: CustomStringConvertible {
    
    /// The celestial longitude
    public let celestialLongitude: Degree
    /// The celestial latitude
    public let celestialLatitude: Degree
    /// The epoch of the coordinates.
    public let epoch: Epoch
    /// The reference equinox.
    public let equinox: Equinox

    /// A convenience accessor for the celestial longitude
    public var lambda: Degree { return celestialLongitude }
    /// A convenience accessor for the celestial latitude
    public var beta: Degree { return celestialLatitude }
    
    /// Creates a new EclipticCoordinates instance.
    ///
    /// - Parameters:
    ///   - celestialLongitude: The celestial longitude value
    ///   - celestialLatitude: The celestial latitude value
    ///   - epoch: The optional epoch value, default to J2000.0
    ///   - equinox: The optional equinox, default to standard equinox J2000.0.
    public init(celestialLongitude: Degree, celestialLatitude: Degree, epoch: Epoch = .J2000, equinox: Equinox = .standardJ2000) {
        self.celestialLongitude = celestialLongitude
        self.celestialLatitude = celestialLatitude
        self.epoch = epoch
        self.equinox = equinox
    }
    
    /// Creates a new EclipticCoordinates instance.
    ///
    /// - Parameters:
    ///   - lambda: The longitude value.
    ///   - beta: The latitude value
    ///   - epoch: The optional epoch value, default to J2000.0. It is not called 'epsilon' to avoid confusion with equinox.
    ///   - equinox: The optional equinox, default to standard equinox J2000.0.
    public init(lambda: Degree, beta: Degree, epoch: Epoch = .J2000, equinox: Equinox = .standardJ2000) {
        self.init(celestialLongitude: lambda, celestialLatitude: beta, epoch: epoch, equinox: equinox)
    }
    
    /// Returns equatorial coordinates corresponding to the current ecliptic ones.
    ///
    /// - Returns: A new equatorial coordinates instance.
    public func makeEquatorialCoordinates() -> EquatorialCoordinates {
        let eclipticObliquity = KPCAANutation_MeanObliquityOfEcliptic(self.epoch.julianDay.value)
        let components = KPCAACoordinateTransformation_Ecliptic2Equatorial(self.celestialLongitude.value, self.celestialLatitude.value, eclipticObliquity)
        return EquatorialCoordinates(alpha: Hour(components.X), delta: Degree(components.Y), epoch: self.epoch)
    }

    /// Returns apparent equatorial coordinates corresponding to the current ecliptic ones.
    ///
    /// - Returns: A new equatorial coordinates instance
    public func makeApparentEquatorialCoordinates() -> EquatorialCoordinates {
        let eclipticObliquity = KPCAANutation_TrueObliquityOfEcliptic(self.epoch.julianDay.value)
        let components = KPCAACoordinateTransformation_Ecliptic2Equatorial(self.celestialLongitude.value, self.celestialLatitude.value, eclipticObliquity)
        return EquatorialCoordinates(alpha: Hour(components.X), delta: Degree(components.Y), epoch: self.epoch)
    }

    /// Returns EclipticCoordinates precessed to a new given epoch.
    ///
    /// - Parameter newEpoch: The new epoch to precess to.
    /// - Returns: A new EclipticCoordinates instance
    public func precessedCoordinates(to newEpoch: Epoch) -> EclipticCoordinates {
        let components = KPCAAPrecession_PrecessEcliptic(self.celestialLongitude.value,
                                                         self.celestialLatitude.value,
                                                         self.epoch.julianDay.value,
                                                         newEpoch.julianDay.value)
        
        return EclipticCoordinates(lambda: Degree(components.X), beta: Degree(components.Y), epoch: newEpoch)
    }
    
    /// Return new ecliptic coordinates corrected for the annual aberration of the Earth. It must be used for star coordinates, not planets.
    /// See AA, p149.
    ///
    /// - parameter julianDay:     The julian day for which the aberration is computed.
    /// - parameter highPrecision: If `false`, the Ron-Vondrák algorithm is used. See AA p.153. If `true`, the newer VSOP87 theory is used.OSun
    ///
    /// - returns: Corected ecliptic coordinates of the star.
    public func correctedForAnnualAberration(julianDay: JulianDay, highPrecision: Bool = true) -> EclipticCoordinates {
        let diff = KPCAAAberration_EclipticAberration(self.lambda.value, self.beta.value, julianDay.value, highPrecision)
        return EclipticCoordinates(lambda: Degree(self.lambda.value+diff.X), beta: Degree(self.beta.value+diff.Y), epoch: self.epoch)
    }

    /// Description of EclipticCoordinates
    public var description: String {
        return String(format: "λ=%@, β=%@ (epoch %@, equinox %@)", lambda.description, beta.description, epoch.description, equinox.description)
    }
    
}

// MARK: -

/// The coordinates of an object in the Milky Way galactic system.
public struct GalacticCoordinates: CustomStringConvertible {
    
    /// The galactic longitude
    public let galacticLongitude: Degree
    /// The galactic latitude
    public let galacticLatitude: Degree
    /// The epoch of the coordinates
    public let epoch: Epoch
    /// The reference equinox.
    public let equinox: Equinox

    /// A convenience accessor for the galactic longitude
    public var l: Degree { return galacticLongitude }
    /// A convenience accessor for the galactic latitude
    public var b: Degree { return galacticLatitude }
    
    /// Creates a new GalacticCoordinates instance.
    ///
    /// - Parameters:
    ///   - galacticLongitude: The galactic longitude
    ///   - galacticLatitude: The galactic latitude
    ///   - epoch: The epoch of coordinates. Default is B1950.0
    ///   - equinox: The optional equinox, default to standard equinox J2000.0.
    public init(galacticLongitude: Degree, galacticLatitude: Degree, epoch: Epoch = .J2000, equinox: Equinox = .standardJ2000) {
        self.galacticLongitude = galacticLongitude
        self.galacticLatitude = galacticLatitude
        self.epoch = epoch
        self.equinox = equinox
    }
    
    /// Creates a new GalacticCoordinates instance.
    ///
    /// - Parameters:
    ///   - l: The galactic longitude
    ///   - b: The galactic latitude
    ///   - epoch: The epoch of coordinates. Default is B1950.0
    public init(l: Degree, b: Degree, epoch: Epoch = .J2000, equinox: Equinox = .standardJ2000) {
        self.init(galacticLongitude: l, galacticLatitude: b, epoch: epoch, equinox: equinox)
    }
    
    /// Returns the equatorial coordinates corresponding to the current galactic one.
    /// Careful: the epoch should necessarily be that of the galactic coordinates which is always B1950.0.
    ///
    /// - Returns: A new EquatorialCoordinates object.
    public func makeEquatorialCoordinates() -> EquatorialCoordinates {
        let components = KPCAACoordinateTransformation_Galactic2Equatorial(self.galacticLongitude.value, self.galacticLatitude.value)
        return EquatorialCoordinates(alpha: Hour(components.X), delta: Degree(components.Y), epoch: self.epoch)
    }
    
    /// Description of GalacticCoordinates
    public var description: String {
        return String(format: "l=%@, b=%@ (epoch %@, equinox %@)", l.description, b.description, epoch.description, equinox.description)
    }
    
}

// MARK: -

/// The coordinates of an object as seen from an observer location on Earth.
public struct HorizontalCoordinates: CustomStringConvertible {
    /// The azimuth, westward from the South see AA. p91
    public let azimuth: Degree
    /// The altitude
    public let altitude: Degree
    /// The location on Earth
    public let geographicCoordinates: GeographicCoordinates
    /// The julian day
    public let julianDay: JulianDay
    
    /// The azimuth angle, starting from the North.
    public var northBasedAzimuth: Degree { return (azimuth + 180).reduced }
    
    /// Creates a new HorizontalCoordinates instance.
    ///
    /// - Parameters:
    ///   - azimuth: The azimuth value.
    ///   - altitude: The altitude value
    ///   - geographicCoordinates: The location on Earth.
    public init(azimuth: Degree, altitude: Degree, geographicCoordinates: GeographicCoordinates, julianDay: JulianDay) {
        self.azimuth = azimuth
        self.altitude = altitude
        self.geographicCoordinates = geographicCoordinates
        self.julianDay = julianDay
    }
    
    /// Returns the equivalent Equatorial coordinates for the given Julian Day.
    ///
    /// - Parameters:
    ///   - julianDay: The julian day at which the coordinates are returned.
    ///   - epoch: The optional epoch value, default to J2000.0
    /// - Returns: A new EquatorialCoordinates object.
    public func makeEquatorialCoordinates(julianDay: JulianDay, epoch: Epoch = .J2000) -> EquatorialCoordinates? {
        let components = KPCAACoordinateTransformation_Horizontal2Equatorial(self.azimuth.value,
                                                                             self.altitude.value,
                                                                             self.geographicCoordinates.latitude.value)
        let lst = julianDay.meanLocalSiderealTime(longitude: geographicCoordinates.longitude)
        return EquatorialCoordinates(alpha: Hour(lst.value - components.X).reduced, delta: Degree(components.Y), epoch: epoch)
    }
    
    /// Returns the angular separation between two horizontal coordinates.
    ///
    /// - Parameter otherCoordinates: The other coordinates to consider.
    /// - Returns: A angle value, between the two coordinates.
    public func angularSeparation(with otherCoordinates: HorizontalCoordinates) -> Degree {
        // note: we actually use AA method for *equatorial* coordinates separation (works fine for horizontal coordinates)
        return Degree(KPCAAAngularSeparation_Separation(self.azimuth.inHours.value,
                                                        self.altitude.value,
                                                        otherCoordinates.azimuth.inHours.value,
                                                        otherCoordinates.altitude.value))
    }
    
    public var description: String { return String(format: "A=%@, h=%@", azimuth.description, altitude.description) }
    
}


