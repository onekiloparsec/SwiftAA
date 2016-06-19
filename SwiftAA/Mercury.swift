//
//  Mercury.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Mercury: Planet {
    var julianDay: JulianDay
    var eclipticObject: KPCEclipticObject { return .Mercury }
    var planet: KPCPlanetaryObject { return .MERCURY }
    
    init(julianDay: JulianDay) {
        self.julianDay = julianDay
    }
}