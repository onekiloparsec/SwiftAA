//
//  SaturnRings.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/11/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

//// Saturn has many rings. Here we consider the ring system as a whole.
public struct SaturnRingSystem {
    fileprivate var details: KPCAASaturnRingDetails

    /**
     The Saturnicentric latitude of the Earth referred to the plane of the ring (B),
     positive towards the north. When B is positive, the visible surface of the ring is
     the northern one.
    */
    public var saturnicentricEarthLatitude: Degree { get { return Degree(self.details.B) } }

    /**
     The Saturnicentric latitude of the Sun referred to the plane of the ring (B'),
     positive towards the north. When B' is positive, the illuminated surface of the ring is
     the northern one.
     */
    public var saturnicentricSunLatitude: Degree { get { return Degree(self.details.Bdash) } }

    /**
     The position angle of the north pole of rotation of the planet. Because the ring is
     situated exactly in Saturn's equator plane, P is also the geocentric position angle of the
     northern semiminor axis of the apparent ellipse of the ring, measured from the North towards
     the East (trust me... see AA p.317)
    */
    public var northPolePositionAngle: Degree { get { return Degree(self.details.P) } }

    /**
     The major axis of the outer edge of the outer ring.
    */
    public var majorAxis: Degree { get { return Degree(self.details.a / 3600.0) } }

    /**
     The minor axis of the outer edge of the outer ring.
     */
    public var minorAxis: Degree { get { return Degree(self.details.b / 3600.0) } }

    /**
     The difference between the Saturnicentric longitude of the Sun and the Earth, measured in
     the plane of the ring. Used to compute Saturn's magnitude.
    */
    public var saturnicentricSunEarthLongitudesDifference: Degree { get { return Degree(self.details.DeltaU) } }

    /// Returns a Saturn Ring system object.
    ///
    /// - Parameter details: The details of the ring system.
    init(_ details: KPCAASaturnRingDetails) {
        self.details = details
    }
}

