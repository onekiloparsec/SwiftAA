//
//  Neptune.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Neptune: Planet {
    var julianDay: JulianDay
    var eclipticObject: KPCEclipticObject { return .Neptune }
    var planet: KPCPlanetaryObject { return .NEPTUNE }
    
    init(julianDay: JulianDay) {
        self.julianDay = julianDay
    }
}

