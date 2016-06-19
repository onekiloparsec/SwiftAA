//
//  Neptune.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Neptune: Planet {
    public var julianDay: JulianDay
    public var eclipticObject: KPCEclipticObject { return .Neptune }
    public var planet: KPCPlanetaryObject { return .NEPTUNE }
    
    public init(julianDay: JulianDay) {
        self.julianDay = julianDay
    }
    
    public var color: Color {
        get { return Color(red: 145.0/255.0, green:139.0/255.0, blue:129.0/255.0, alpha: 1.0) }
    }
}

