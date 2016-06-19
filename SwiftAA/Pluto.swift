//
//  Pluto.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Pluto: Planet {
    var julianDay: JulianDay
    var eclipticObject: KPCEclipticObject { return .Pluto }
    var planet: KPCPlanetaryObject { return .PLUTO }
    
    init(julianDay: JulianDay) {
        self.julianDay = julianDay
    }
}

