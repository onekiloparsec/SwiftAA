//
//  Pluto.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Pluto: EclipticObject {
    public var julianDay: JulianDay
    public var eclipticObject: KPCEclipticObject { return .Pluto }
    
    public init(julianDay: JulianDay) {
        self.julianDay = julianDay
    }
    
    public static var color: Color {
        get { return Color(red: 0.776, green:0.620, blue:0.486, alpha: 1.0) }
    }
}

