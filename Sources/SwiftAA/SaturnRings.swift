//
//  SaturnRings.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/11/2016.
//  MIT Licence. See LICENCE file.
//

import Foundation
import ObjCAA

/// Saturnicentric coordinates are centered on Saturn.
public struct SaturnicentricCoordinates {
    /// Saturnicentric longitudes, referred to the plane of the ring.
    public let longitude: Degree
    
    /// Saturnicentric latitudes, referred to the plane of the ring, positive towards the north. 
    /// When the latitude is positive, the visible/illuminated surface of the ring is the northern one.
    public let latitude: Degree
}


//// Saturn has many rings. Here we consider the ring system as a whole.
public struct SaturnRingSystem {
    fileprivate var details: KPCAASaturnRingDetails
    public fileprivate(set) var julianDay: JulianDay
    
    /// The Saturnicentric coordinates of the Earth referred to the plane of the ring (B)
    public var earthCoordinates: SaturnicentricCoordinates {
        get { return SaturnicentricCoordinates(longitude: Degree(self.details.U2), latitude: Degree(self.details.B)) }
    }
    
    /// The Saturnicentric coordinates of the Sun referred to the plane of the ring (B)
    public var sunCoordinates: SaturnicentricCoordinates {
        get { return SaturnicentricCoordinates(longitude: Degree(self.details.U1), latitude: Degree(self.details.Bdash)) }
    }

    /// The difference between the Saturnicentric longitude of the Sun and the Earth, measured in
    /// the plane of the ring. Used to compute Saturn's magnitude.
    public var saturnicentricSunEarthLongitudesDifference: Degree { get { return Degree(self.details.DeltaU) } }

    /// The position angle of the north pole of rotation of the planet. Because the ring is
    /// situated exactly in Saturn's equator plane, P is also the geocentric position angle of the
    /// northern semiminor axis of the apparent ellipse of the ring, measured from the North towards
    /// the East (trust me... see AA p.317)
    public var northPolePositionAngle: Degree { get { return Degree(self.details.P) } }

    /// The major axis of the outer edge of the outer ring.
    public var majorAxis: ArcSecond { get { return ArcSecond(self.details.a) } }

    /// The minor axis of the outer edge of the outer ring.
    public var minorAxis: ArcSecond { get { return ArcSecond(self.details.b) } }

    /// Creates a Saturn Ring system instance.
    ///
    /// - Parameter details: The details of the ring system.
    init(_ details: KPCAASaturnRingDetails, julianDay: JulianDay) {
        self.details = details
        self.julianDay = julianDay
    }
}

