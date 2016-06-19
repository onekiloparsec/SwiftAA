//
//  Uranus.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Uranus: Planet {
    var julianDay: JulianDay
    var eclipticObject: KPCEclipticObject { return .Uranus }
    var planet: KPCPlanetaryObject { return .URANUS }
    
    init(julianDay: JulianDay) {
        self.julianDay = julianDay
    }
}
