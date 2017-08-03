//
//  Asteroids.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/12/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

/// See AA p. 391. AA+ result is given in kilometers
public func asteroidDiameter(magnitude: SpaceMagnitude, albedo: Double) -> Meter {
    return Meter(KPCAADiameters_AsteroidDiameter(magnitude.value, albedo) * 1000.0)
}

/// See AA p. 391. AA+ result is given in kilometers
public func apparentAsteroidDiameter(magnitude: SpaceMagnitude, albedo: Double) -> Meter {
    return Meter(KPCAADiameters_ApparentAsteroidDiameter(magnitude.value, albedo) * 1000.0)
}
