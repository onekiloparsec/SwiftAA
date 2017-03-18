//
//  GeographicCoordinates.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/11/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation
import CoreLocation

/// The GeographicCoordinates object encompasses the basic elements of a location on Earth, including its altitude.
public struct GeographicCoordinates {
    public let longitude: Degree
    public let latitude: Degree
    public let altitude: Meter
    
    /// Returns the equivalent CLLocation object.
    public var location: CLLocation {
        let coordinates = CLLocationCoordinate2D(latitude: latitude.value, longitude: -longitude.value)
        let location = CLLocation(coordinate: coordinates, altitude: altitude.value, horizontalAccuracy: 0, verticalAccuracy: 0, timestamp: Date())
        return location
    }
    
    /// Convenience method
    public static var zero: GeographicCoordinates {
        return GeographicCoordinates(positivelyWestwardLongitude: 0.0.degrees, latitude: 0.0.degrees)
    }
        
    /// Returns a GeographicCoordinates object.
    ///
    /// - Parameters:
    ///   - longitude: The (positively westward) longitude.
    ///   - latitude: The latitude
    ///   - altitude: The optional altitude (default = 0).
    public init(positivelyWestwardLongitude longitude: Degree, latitude: Degree, altitude: Meter = 0) {
        self.longitude = longitude
        self.latitude = latitude
        self.altitude = altitude
    }
    
    /// Returns a GeographicCoordinates object.
    ///
    /// - Parameter location: a CLLocation object
    public init(_ location: CLLocation) {
        let lon = Degree(-location.coordinate.longitude)
        let lat = Degree(location.coordinate.latitude)
        let alt = Meter(location.altitude)
        self.init(positivelyWestwardLongitude: lon, latitude: lat, altitude: alt)
    }
    
    
    /// High accuracy computation of the distance between two points on Earth's surface, taking into account
    /// the Earth flattening.
    ///
    /// - parameter otherCoordinates: The coordinates of the second point.
    ///
    /// - returns: The distance, in meters, between the two points, along Earth's surface.
    public func globeDistance(to otherCoordinates: GeographicCoordinates) -> Meter {
        // KPCAA result is in kilometers.
        return Meter(KPCAAGlobe_DistanceBetweenPoints(self.latitude.value,
                                                      self.longitude.value,
                                                      otherCoordinates.latitude.value,
                                                      otherCoordinates.longitude.value) * 1000)
    }
    
    /// Returns the radius of the curvature of the Earth's meridian
    /// See AA p.82-83 Symbol: Rm
    public var globeRadiusOfCurvature: Meter {
        // Returned AA value is in kilometers.
        get { return Meter(KPCAAGlobe_RadiusOfCurvature(self.latitude.value)*1000.0) }
    }
    
    /// Returns the radius of the circle made at a constant latitude
    /// Uses the Earth ellipsoid as defined by IAU in 1976.
    /// See AA p.82-83. Symbol: Rp
    public var globeRadiusOfParallelOfLatitude: Meter {
        // Returned AA value is in kilometers.
        get { return Meter(KPCAAGlobe_RadiusOfParallelOfLatitude(self.latitude.value)*1000.0) }
    }
    
    /// Note: rho is the observer's distance to center of the Earth (for an equatorial radius set to unity). 
    /// Theta (or phi) prime is the geocentric (not geographic) latitude. See AA p.81
    public func rhoSinThetaPrime(forObserverHeight height: Double) -> Double {
        return KPCAAGlobe_RhoSinThetaPrime(self.latitude.value, height)
    }
    
    /// Note: rho is the observer's distance to center of the Earth (for an equatorial radius set to unity). 
    /// Theta (or phi) prime is the geocentric (not geographic) latitude. See AA p.81
    public func rhoCosThetaPrime(forObserverHeight height: Double) -> Double {
        return KPCAAGlobe_RhoCosThetaPrime(self.latitude.value, height)
    }
}

