//
//  Venus.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Venus: Planet {
    public var julianDay: JulianDay
    public var eclipticObject: KPCEclipticObject { return .Venus }
    public var planet: KPCPlanetaryObject { return .VENUS }
    
    public init(julianDay: JulianDay) {
        self.julianDay = julianDay
    }
    
    public static var color: Color {
        get { return Color(red: 0.784, green:0.471, blue:0.137, alpha: 1.0) }
    }
}
