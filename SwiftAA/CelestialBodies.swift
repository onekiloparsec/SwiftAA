//
//  OribitingObject.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 28/08/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation


/// Basic properties of an orbiting object. Used by solar system planets, and the Earth Moon, and the Sun.
/// Default implementation for planets is located in PlanetaryBase extension.

public protocol CelestialBody: ObjectBase {
    /// The radius vector (=distance to the Sun)
    var radiusVector: AU { get }
    
    /// The ecliptic (=heliocentric) coordinates of the object
    var eclipticCoordinates: EclipticCoordinates { get }
    
    /// The equatorial coordinates of the object
    var equatorialCoordinates: EquatorialCoordinates { get }
    
    var apparentEquatorialCoordinates: EquatorialCoordinates { get }
    
    func riseTransitSetTimes(geographicCoordinates: GeographicCoordinates) -> RiseTransitSetTimes
    
    func parallacticAngle(geographicCoordinates: GeographicCoordinates) -> Degree
    
    func eclipticLongitudeOnHorizon(geographicCoordinates: GeographicCoordinates) -> Degree
    
    func angleBetweenEclipticAndHorizon(geographicCoordinates: GeographicCoordinates) -> Degree
    
    func angleBetweenNorthCelestialPoleAndNorthPoleOfEcliptic(geographicCoordinates: GeographicCoordinates) -> Degree
    
    var equatorialSemiDiameter: Degree { get }
    
    var polarSemiDiameter: Degree { get }
    
    /// Geometric altitude (h0) of the center of the body at time of apparent rising or setting (see AA p.101)
    var apparentRiseSetAltitude: Degree { get }
    
}

public extension CelestialBody {
    public func riseTransitSetTimes(geographicCoordinates: GeographicCoordinates) -> RiseTransitSetTimes {
        return RiseTransitSetTimes(celestialBody: self, geographicCoordinates: geographicCoordinates)
    }
    
    func parallacticAngle(geographicCoordinates: GeographicCoordinates) -> Degree {
        let lha = self.julianDay.meanLocalSiderealTime(forGeographicLongitude: geographicCoordinates.longitude)
        return Degree(KPCAAParallactic_ParallacticAngle(lha.value,
                                                        geographicCoordinates.latitude.value,
                                                        self.equatorialCoordinates.delta.value))
    }
    
    func eclipticLongitudeOnHorizon(geographicCoordinates: GeographicCoordinates) -> Degree {
        let lha = self.julianDay.meanLocalSiderealTime(forGeographicLongitude: geographicCoordinates.longitude)
        let epsilon = obliquityOfEcliptic(julianDay: self.julianDay, mean: false)
        return Degree(KPCAAParallactic_EclipticLongitudeOnHorizon(lha.value,
                                                                  epsilon.value,
                                                                  geographicCoordinates.latitude.value))
    }
    
    func angleBetweenEclipticAndHorizon(geographicCoordinates: GeographicCoordinates) -> Degree {
        let lha = self.julianDay.meanLocalSiderealTime(forGeographicLongitude: geographicCoordinates.longitude)
        let epsilon = obliquityOfEcliptic(julianDay: self.julianDay, mean: false)
        return Degree(KPCAAParallactic_AngleBetweenEclipticAndHorizon(lha.value,
                                                                      epsilon.value,
                                                                      geographicCoordinates.latitude.value))
    }
    
    func angleBetweenNorthCelestialPoleAndNorthPoleOfEcliptic(geographicCoordinates: GeographicCoordinates) -> Degree {
        let epsilon = obliquityOfEcliptic(julianDay: self.julianDay, mean: false)
        return Degree(KPCAAParallactic_AngleBetweenNorthCelestialPoleAndNorthPoleOfEcliptic(self.eclipticCoordinates.lambda.value,
                                                                                            self.eclipticCoordinates.beta.value,
                                                                                            epsilon.value))
    }

}

