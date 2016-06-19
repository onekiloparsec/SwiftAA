//
//  Mars.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Mars: Planet {
    public var julianDay: JulianDay
    public var eclipticObject: KPCEclipticObject { return .Mars }
    public var planet: KPCPlanetaryObject { return .MARS }
    
    public init(julianDay: JulianDay) {
        self.julianDay = julianDay
    }
}
