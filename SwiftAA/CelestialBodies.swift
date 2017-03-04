//
//  OribitingObject.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 28/08/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation


/// Basic properties of an orbiting object. Used by solar system planets, and the Earth' Moon, and the Sun.
/// Default implementation for planets is located in PlanetaryBase extension.

public protocol CelestialBody: ObjectBase {
    /// The radius vector (=distance to the Sun)
    var radiusVector: AU { get }
    
    /// The ecliptic (=heliocentric) coordinates of the object
    var eclipticCoordinates: EclipticCoordinates { get }
    
    /// The equatorial coordinates of the object
    var equatorialCoordinates: EquatorialCoordinates { get }
    
    var apparentEquatorialCoordinates: EquatorialCoordinates { get }
    
    func riseTransitSetTimes(with geographicCoordinates: GeographicCoordinates) -> RiseTransitSetTimes

    
    /// Returns the Hour Angle of the celestial body, that is, the difference between its local mean sidereal time
    /// and its right ascension.
    ///
    /// - Parameter geographicCoordinates: The geographic coordinates of the place.
    /// - Returns: The Hour Angle of the body.
    func hourAngle(with geographicCoordinates: GeographicCoordinates) -> Hour

    func parallacticAngle(with geographicCoordinates: GeographicCoordinates) -> Degree
    
    func eclipticLongitudeOnHorizon(with geographicCoordinates: GeographicCoordinates) -> Degree
    
    func angleBetweenEclipticAndHorizon(with geographicCoordinates: GeographicCoordinates) -> Degree
    
    func angleBetweenNorthCelestialPoleAndNorthPoleOfEcliptic(with geographicCoordinates: GeographicCoordinates) -> Degree
    
    /// The angle the Earth must make between the time at which the object is at a given altitude, then rotate,
    /// produce a diurnal arc, and reach a time at which the object reached again the same altitude.
    /// Basically, for the object being the Sun, and the altitude being 0=horizon, compute the angle between
    /// sunrise and sunset.
    ///
    /// - Parameters:
    ///   - altitude: The crossing altitude
    ///   - coordinates: The point on Earth from which one computes the arc.
    /// - Returns: The angle of the so-called diurnal arc
    func diurnalArcAngle(forObjectAltitude altitude: Degree, coordinates: GeographicCoordinates) -> (value: Degree?, error: CelestialBodyTransitError?)

    var equatorialSemiDiameter: Degree { get }
    
    var polarSemiDiameter: Degree { get }
    
    /// Geometric altitude (h0) of the center of the body at time of apparent rising or setting (see AA p.101)
    var apparentRiseSetAltitude: Degree { get }
    
}

public extension CelestialBody {
    public func riseTransitSetTimes(with geographicCoordinates: GeographicCoordinates) -> RiseTransitSetTimes {
        return RiseTransitSetTimes(celestialBody: self, geographicCoordinates: geographicCoordinates)
    }
    
    func hourAngle(with geographicCoordinates: GeographicCoordinates) -> Hour {
        return self.julianDay.meanLocalSiderealTime(longitude: geographicCoordinates.longitude) - self.equatorialCoordinates.alpha
    }

    func parallacticAngle(with geographicCoordinates: GeographicCoordinates) -> Degree {
        let lha = self.hourAngle(with: geographicCoordinates)
        return Degree(KPCAAParallactic_ParallacticAngle(lha.value,
                                                        geographicCoordinates.latitude.value,
                                                        self.equatorialCoordinates.delta.value))
    }
    
    func eclipticLongitudeOnHorizon(with geographicCoordinates: GeographicCoordinates) -> Degree {
        let lha = self.hourAngle(with: geographicCoordinates)
        let epsilon = Earth(julianDay: self.julianDay).obliquityOfEcliptic(mean: false)
        return Degree(KPCAAParallactic_EclipticLongitudeOnHorizon(lha.value,
                                                                  epsilon.value,
                                                                  geographicCoordinates.latitude.value))
    }
    
    func angleBetweenEclipticAndHorizon(with geographicCoordinates: GeographicCoordinates) -> Degree {
        let lha = self.hourAngle(with: geographicCoordinates)
        let epsilon = Earth(julianDay: self.julianDay).obliquityOfEcliptic(mean: false)
        return Degree(KPCAAParallactic_AngleBetweenEclipticAndHorizon(lha.value,
                                                                      epsilon.value,
                                                                      geographicCoordinates.latitude.value))
    }
    
    func angleBetweenNorthCelestialPoleAndNorthPoleOfEcliptic(with geographicCoordinates: GeographicCoordinates) -> Degree {
        let epsilon = Earth(julianDay: self.julianDay).obliquityOfEcliptic(mean: false)
        return Degree(KPCAAParallactic_AngleBetweenNorthCelestialPoleAndNorthPoleOfEcliptic(self.eclipticCoordinates.lambda.value,
                                                                                            self.eclipticCoordinates.beta.value,
                                                                                            epsilon.value))
    }

    func diurnalArcAngle(forObjectAltitude altitude: Degree, coordinates: GeographicCoordinates) -> (value: Degree?, error: CelestialBodyTransitError?) {        
        // Compute the diurnal arc that the Sun traverses to reach the specified altitude altit:
        
        let sinAlt = sin(altitude.inRadians.value)
        let sinLat = sin(coordinates.latitude.inRadians.value)
        let sinDec = sin(self.equatorialCoordinates.declination.inRadians.value)
        let cosLat = cos(coordinates.latitude.inRadians.value)
        let cosDec = cos(self.equatorialCoordinates.declination.inRadians.value)
        
        let cost = (sinAlt - sinLat * sinDec) / (cosLat * cosDec)
        
        if (cost >= 1.0 ) {
            return (nil, .alwaysBelowAltitude)
        }
        else if (cost <= -1.0) {
            return (nil, .alwaysAboveAltitude)
        }
        else {
            return (Radian(acos(cost)).inDegrees, nil)
        }
    }
}

