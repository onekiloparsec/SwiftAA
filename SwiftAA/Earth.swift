//
//  Earth.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Earth: EclipticObject {
    var julianDay: JulianDay
    var eclipticObject: KPCEclipticObject { return .Earth }
    
    init(julianDay: JulianDay) {
        self.julianDay = julianDay
    }
    
    func perihelion(year: Double, baryCentric: Bool = true) -> JulianDay {
        return KPCAAPlanetPerihelionAphelion_EarthPerihelion(KPCAAPlanetPerihelionAphelion_EarthK(year), baryCentric)
    }
    
    func aphelion(year: Double, baryCentric: Bool = true) -> JulianDay {
        return KPCAAPlanetPerihelionAphelion_EarthAphelion(KPCAAPlanetPerihelionAphelion_EarthK(year), baryCentric)
    }
}
