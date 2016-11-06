//
//  OribitingObject.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 28/08/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

/// Basic properties of an orbiting object. Used by solar system planets and the Moon.
/// Default implementation for planets is located in PlanetaryBase extension.

public protocol OrbitingObject : ObjectBase {
    /// The ecliptic (=heliocentric) longitude of the object
    var eclipticLongitude: Degree { get }
    
    /// The ecliptic (=heliocentric) latitude of the object
    var eclipticLatitude: Degree { get }
    
    /// The radius vector (=distance to the Sun)
    var radiusVector: AU { get }
    
    /// The ecliptic coordinates of the object
    var eclipticCoordinates: EclipticCoordinates { get }
}

