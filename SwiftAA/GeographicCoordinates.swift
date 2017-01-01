//
//  GeographicCoordinates.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/11/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation
import CoreLocation

public struct GeographicCoordinates {
    public let longitude: Degree
    public let latitude: Degree
    public let altitude: Meter
    
    public var location: CLLocation {
        let coordinates = CLLocationCoordinate2D(latitude: latitude.value, longitude: -longitude.value)
        let location = CLLocation(coordinate: coordinates, altitude: altitude.value, horizontalAccuracy: 0, verticalAccuracy: 0, timestamp: Date())
        return location
    }
    
    public init(positivelyWestwardLongitude longitude: Degree, latitude: Degree, altitude: Meter = 0) {
        self.longitude = longitude
        self.latitude = latitude
        self.altitude = altitude
    }
    
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
}

