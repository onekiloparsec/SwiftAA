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
    
    func riseTransitSetTimes(geographicCoordinates: GeographicCoordinates) -> RiseTransitSetTimes
}

public extension CelestialBody {
    var equatorialCoordinates: EquatorialCoordinates {
        get { return self.eclipticCoordinates.toEquatorialCoordinates() }
    }
    
    public func riseTransitSetTimes(geographicCoordinates: GeographicCoordinates) -> RiseTransitSetTimes {
        return RiseTransitSetTimes(celestialBody: self, geographicCoordinates: geographicCoordinates)
    }
}

public class RiseTransitSetTimes {
    private lazy var riseTransiteSetTimesDetails: RiseTransitSetTimesDetails = {
    [unowned self] in
        let jd = self.celestialBody.julianDay
        let hp = self.celestialBody.highPrecision
        
        let celestialBodyType = type(of: self.celestialBody)
        let body1: CelestialBody = celestialBodyType.init(julianDay: jd-1, highPrecision: hp)
        let body3: CelestialBody = celestialBodyType.init(julianDay: jd+1, highPrecision: hp)
        
        return riseTransitSet(forJulianDay: jd,
                              equCoords1: body1.equatorialCoordinates,
                              equCoords2: self.celestialBody.equatorialCoordinates,
                              equCoords3: body3.equatorialCoordinates,
                              geoCoords: self.geographicCoordinates)
    }()
    
    public fileprivate(set) var geographicCoordinates: GeographicCoordinates
    public fileprivate(set) var celestialBody: CelestialBody
    
    required public init(celestialBody: CelestialBody, geographicCoordinates: GeographicCoordinates) {
        self.celestialBody = celestialBody
        self.geographicCoordinates = geographicCoordinates
    }
    
    public var riseTime: JulianDay? {
        get { return self.riseTransiteSetTimesDetails.isRiseValid ? self.riseTransiteSetTimesDetails.riseTime : nil }
    }

    public var transitTime: JulianDay? {
        get { return self.riseTransiteSetTimesDetails.isTransitAboveHorizon ? self.riseTransiteSetTimesDetails.transitTime : nil }
    }

    public var setTime: JulianDay? {
        get { return self.riseTransiteSetTimesDetails.isSetValid ? self.riseTransiteSetTimesDetails.setTime : nil }
    }
}



