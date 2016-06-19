//
//  Earth.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Earth: EclipticObject {
    public var julianDay: JulianDay
    public var eclipticObject: KPCEclipticObject { return .Earth }
    
    public init(julianDay: JulianDay) {
        self.julianDay = julianDay
    }
    
    public var color: Color {
        get { return Color(red: 145.0/255.0, green:139.0/255.0, blue:129.0/255.0, alpha: 1.0) }
    }

    func perihelion(year: Double, baryCentric: Bool = true) -> JulianDay {
        return KPCAAPlanetPerihelionAphelion_EarthPerihelion(KPCAAPlanetPerihelionAphelion_EarthK(year), baryCentric)
    }
    
    func aphelion(year: Double, baryCentric: Bool = true) -> JulianDay {
        return KPCAAPlanetPerihelionAphelion_EarthAphelion(KPCAAPlanetPerihelionAphelion_EarthK(year), baryCentric)
    }
}
