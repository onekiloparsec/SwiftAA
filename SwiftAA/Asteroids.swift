//
//  Asteroids.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/12/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

/// See AA p. 391. Result is given in kilometers
public func asteroidDiameter(magnitude: Magnitude, albedo: Double) -> Meter {
    return KPCAADiameters_AsteroidDiameter(magnitude, albedo) * 1000.0
}

/// See AA p. 391. Result is given in kilometers
public func apparentAsteroidDiameter(magnitude: Magnitude, albedo: Double) -> Meter {
    return KPCAADiameters_ApparentAsteroidDiameter(magnitude, albedo) * 1000.0
}
