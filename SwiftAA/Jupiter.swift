//
//  Jupiter.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Jupiter: Planet {
    var julianDay: JulianDay
    var eclipticObject: KPCEclipticObject { return .Jupiter }
    var planet: KPCPlanetaryObject { return .JUPITER }
    
    init(julianDay: JulianDay) {
        self.julianDay = julianDay
    }    
}
