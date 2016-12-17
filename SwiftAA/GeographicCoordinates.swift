//
//  GeographicCoordinates.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/11/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct GeographicCoordinates {
    fileprivate(set) var longitude: Degree
    fileprivate(set) var latitude: Degree
    var altitude: Meter
    
    init(positivelyWestwardLongitude longitude: Degree, latitude: Degree, altitude: Meter = 0) {
        self.longitude = longitude
        self.latitude = latitude
        self.altitude = altitude
    }
    
    
    /// High accuracy computation of the distance between two points on Earth's surface, taking into account
    /// the Earth flattening.
    ///
    /// - parameter otherCoordinates: The coordinates of the second point.
    ///
    /// - returns: The distance, in meters, between the two points, along Earth's surface.
    public func globeDistance(to otherCoordinates: GeographicCoordinates) -> Meter {
        // KPCAA result is in kilometers.
        return KPCAAGlobe_DistanceBetweenPoints(self.latitude.value,
                                                self.longitude.value,
                                                otherCoordinates.latitude.value,
                                                otherCoordinates.longitude.value) * 1000
    }
}

