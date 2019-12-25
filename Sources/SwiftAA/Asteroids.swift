//
//  Asteroids.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/12/2016.
//  MIT Licence. See LICENCE file.
//

import Foundation
import ObjCAA

/// See AA p. 391. AA+ result is given in kilometers
public func asteroidDiameter(magnitude: Magnitude, albedo: Double) -> Kilometer {
    return Kilometer(KPCAADiameters_AsteroidDiameter(magnitude.value, albedo))
}

/// See AA p. 391. AA+ result is given in kilometers
public func apparentAsteroidDiameter(magnitude: Magnitude, albedo: Double) -> ArcSecond {
    return ArcSecond(KPCAADiameters_ApparentAsteroidDiameter(magnitude.value, albedo))
}
