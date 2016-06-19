//
//  Mercury.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Mercury: Planet {
    public var julianDay: JulianDay
    public var eclipticObject: KPCEclipticObject { return .Mercury }
    public var planet: KPCPlanetaryObject { return .MERCURY }

    public init(julianDay: JulianDay) {
        self.julianDay = julianDay
    }
}