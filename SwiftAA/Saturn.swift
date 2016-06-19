//
//  Saturn.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Saturn: Planet {
    var julianDay: JulianDay
    var eclipticObject: KPCEclipticObject { return .Saturn }
    var planet: KPCPlanetaryObject { return .SATURN }
    
    init(julianDay: JulianDay) {
        self.julianDay = julianDay
    }
}

