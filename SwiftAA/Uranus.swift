//
//  Uranus.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Uranus: Planet {
    public var julianDay: JulianDay
    public var eclipticObject: KPCEclipticObject { return .Uranus }
    public var planet: KPCPlanetaryObject { return .URANUS }
    
    public init(julianDay: JulianDay) {
        self.julianDay = julianDay
    }
    
    public static var color: Color {
        get { return Color(red: 0.639, green:0.804, blue:0.839, alpha: 1.0) }
    }
}
