//
//  Neptune.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Neptune: Planet, PlanetaryPhenomena {
    public var julianDay: JulianDay
    public var planet: KPCAAPlanet { return .Neptune }

    public init(julianDay: JulianDay) {
        self.julianDay = julianDay
    }
    
    public static var color: Color {
        get { return Color(red: 0.392, green:0.518, blue:0.871, alpha: 1.0) }
    }
}

