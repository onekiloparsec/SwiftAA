//
//  OribitingObject.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 28/08/16.
//  MIT Licence. See LICENCE file.
//

import Foundation
import ObjCAA

/// Basic properties of an orbiting object. Used by solar system planets, and the Earth' Moon, and the Sun.

public protocol CelestialBody: ObjectBase {
    /// The radius vector (=distance to the Sun)
    var radiusVector: AstronomicalUnit { get }
    
    /// The coordinates of the object in the equatorial system (based on Earth equator).
    var equatorialCoordinates: EquatorialCoordinates { get }
    
    /// The coordinates of the object in the heliocentric ecliptic system.
//    var heliocentricEclipticCoordinates: EclipticCoordinates { get }
    
    /// Returns the Rise, Transit and Set times of the body for a given location on Earth.
    ///
    /// - Parameter geographicCoordinates: The coordinates of the location on Earth.
    /// - Returns: A RiseTransitSetTimes object.
    func riseTransitSetTimes(for geographicCoordinates: GeographicCoordinates) -> RiseTransitSetTimes

    
    /// Returns the Hour Angle of the celestial body, that is, the difference between its local mean sidereal time
    /// and its right ascension.
    ///
    /// - Parameter geographicCoordinates: The geographic coordinates of the observer.
    /// - Returns: The Hour Angle of the body.
    func hourAngle(for geographicCoordinates: GeographicCoordinates) -> Hour

    
    /// The parallactic angle is the angle between the direction of the *zenith point* relative the center of the disk,
    /// and that of the celestial north. The zenith point of the disk of a body (for instance, the Sun or the Moon) is 
    /// the uppermost point of the disk at the sky as seen by the observer at a given instant. See Fig. 4, AA p.98.
    /// Exactly in zenith, the angle is not defined. When a celestial body passes exactly through the zenith, the
    /// parallactic angle suddenly jumps from -90º to 90º.
    ///
    /// - Parameter geographicCoordinates: The geographic coordinates of the observer.
    /// - Returns: The angle in degrees.
    func parallacticAngle(for geographicCoordinates: GeographicCoordinates) -> Degree
    
    
    /// For a given location of the observer, the ecliptic plane cross that of the local horizontal plane, marking
    /// the horizon. Thus, one can compute the longitude of the two points of the ecliptic which are (180º appart)
    /// on the horizon.
    ///
    /// - Parameter geographicCoordinates: The geographic coordinates of the observer.
    /// - Returns: The longitude of the ecliptic.
    func eclipticLongitudeOnHorizon(for geographicCoordinates: GeographicCoordinates) -> Degree
    
    
    /// For a given location of the observer, the ecliptic plane cross that of the local horizontal plane, marking
    /// the horizon. Thus, one can compute the angle between the two planes.
    ///
    /// - Parameter geographicCoordinates: The geographic coordinates of the observer.
    /// - Returns: The angle between the ecliptic and the horizon.
    func angleBetweenEclipticAndHorizon(for geographicCoordinates: GeographicCoordinates) -> Degree
    
    func angleBetweenNorthCelestialPoleAndNorthPoleOfEcliptic(for geographicCoordinates: GeographicCoordinates) -> Degree
    
    /// The angle the Earth must make between the time at which the object is at a given altitude, then rotate,
    /// produce a diurnal arc, and reach a time at which the object reached again the same altitude.
    /// Basically, for the object being the Sun, and the altitude being 0=horizon, compute the angle between
    /// sunrise and sunset.
    ///
    /// - Parameters:
    ///   - objectAltitude: The crossing altitude
    ///   - geographicCoordinates: The point on Earth from which one computes the arc.
    /// - Returns: The angle of the so-called diurnal arc
    func diurnalArcAngle(for objectAltitude: Degree, geographicCoordinates: GeographicCoordinates) -> (value: Degree?, error: CelestialBodyTransitError?)
    
    /// Geometric altitude (h0) of the center of the body at time of apparent rising or setting (see AA p.101)
    static var apparentRiseSetAltitude: Degree { get }
}

public extension CelestialBody {
    /// Returns the Rise, Transit and Set times of the body for a given location on Earth.
    ///
    /// - Parameter geographicCoordinates: The coordinates of the location on Earth.
    /// - Returns: A RiseTransitSetTimes object.
    func riseTransitSetTimes(for geographicCoordinates: GeographicCoordinates) -> RiseTransitSetTimes {
        return RiseTransitSetTimes(celestialBody: self, geographicCoordinates: geographicCoordinates)
    }
    
    /// Returns the Hour Angle of the celestial body, that is, the difference between its local mean sidereal time
    /// and its right ascension.
    ///
    /// - Parameter geographicCoordinates: The geographic coordinates of the place.
    /// - Returns: The Hour Angle of the body.
    func hourAngle(for geographicCoordinates: GeographicCoordinates) -> Hour {
        return self.julianDay.meanLocalSiderealTime(longitude: geographicCoordinates.longitude) - self.equatorialCoordinates.alpha
    }

    func parallacticAngle(for geographicCoordinates: GeographicCoordinates) -> Degree {
        let lha = self.hourAngle(for: geographicCoordinates)
        return Degree(KPCAAParallactic_ParallacticAngle(lha.value,
                                                        geographicCoordinates.latitude.value,
                                                        self.equatorialCoordinates.delta.value))
    }
    
    func eclipticLongitudeOnHorizon(for geographicCoordinates: GeographicCoordinates) -> Degree {
        let theta = self.julianDay.meanLocalSiderealTime(longitude: geographicCoordinates.longitude)
        let epsilon = self.julianDay.obliquityOfEcliptic(mean: false)
        return Degree(KPCAAParallactic_EclipticLongitudeOnHorizon(theta.value,
                                                                  epsilon.value,
                                                                  geographicCoordinates.latitude.value))
    }
    
    func angleBetweenEclipticAndHorizon(for geographicCoordinates: GeographicCoordinates) -> Degree {
        let theta = self.julianDay.meanLocalSiderealTime(longitude: geographicCoordinates.longitude)
        let epsilon = self.julianDay.obliquityOfEcliptic(mean: false)
        return Degree(KPCAAParallactic_AngleBetweenEclipticAndHorizon(theta.value,
                                                                      epsilon.value,
                                                                      geographicCoordinates.latitude.value))
    }
    
    func angleBetweenNorthCelestialPoleAndNorthPoleOfEcliptic(for geographicCoordinates: GeographicCoordinates) -> Degree {
        let epsilon = self.julianDay.obliquityOfEcliptic(mean: false)
        let eclipticCoords = self.equatorialCoordinates.makeEclipticCoordinates()
        return Degree(KPCAAParallactic_AngleBetweenNorthCelestialPoleAndNorthPoleOfEcliptic(eclipticCoords.lambda.value,
                                                                                            eclipticCoords.beta.value,
                                                                                            epsilon.value))
    }

    /// The angle the Earth must make between the time at which the object is at a given altitude, then rotate,
    /// produce a diurnal arc, and reach a time at which the object reached again the same altitude.
    /// Basically, for the object being the Sun, and the altitude being 0=horizon, compute the angle between
    /// sunrise and sunset.
    ///
    /// - Parameters:
    ///   - objectAltitude: The crossing altitude
    ///   - geographicCoordinates: The point on Earth from which one computes the arc.
    /// - Returns: The angle of the so-called diurnal arc
    func diurnalArcAngle(for objectAltitude: Degree, geographicCoordinates: GeographicCoordinates) -> (value: Degree?, error: CelestialBodyTransitError?) {
        // Compute the diurnal arc that the Sun traverses to reach the specified altitude altit:
        
        let sinAlt = sin(objectAltitude.inRadians.value)
        let sinLat = sin(geographicCoordinates.latitude.inRadians.value)
        let sinDec = sin(self.equatorialCoordinates.declination.inRadians.value)
        let cosLat = cos(geographicCoordinates.latitude.inRadians.value)
        let cosDec = cos(self.equatorialCoordinates.declination.inRadians.value)
        
        let cost = (sinAlt - sinLat * sinDec) / (cosLat * cosDec)
        
        if (cost >= 1.0 ) {
            return (value: nil, error: .alwaysBelowAltitude)
        }
        else if (cost <= -1.0) {
            return (value: nil, error: .alwaysAboveAltitude)
        }
        else {
            return (value: Radian(acos(cost)).inDegrees, error: nil)
        }
    }
}

