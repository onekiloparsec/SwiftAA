//
//  Venus.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Venus: Planet, IlluminatedFraction, PlanetaryPhenomena, ElementsOfPlanetaryOrbit {
    public var planet: KPCAAPlanet { return .Venus }
    
    public var julianDay: JulianDay
    public var highPrecision: Bool
    
    public init(julianDay: JulianDay, highPrecision: Bool = true) {
        self.julianDay = julianDay
        self.highPrecision = highPrecision
    }
    
    public static var color: Color {
        get { return Color(red: 0.784, green:0.471, blue:0.137, alpha: 1.0) }
    }
}
