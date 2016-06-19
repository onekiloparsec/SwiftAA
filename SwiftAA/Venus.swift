//
//  Venus.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Venus: Planet {
    var julianDay: JulianDay
    var eclipticObject: KPCEclipticObject { return .Venus }
    var planet: KPCPlanetaryObject { return .VENUS }
    
    init(julianDay: JulianDay) {
        self.julianDay = julianDay
    }
        
    func perihelion(year: Double) -> JulianDay {
        return KPCAAPlanetPerihelionAphelion_MercuryPerihelion(KPCAAPlanetPerihelionAphelion_MercuryK(year))
    }

    func aphelion(year: Double) -> JulianDay {
        return KPCAAPlanetPerihelionAphelion_MercuryAphelion(KPCAAPlanetPerihelionAphelion_MercuryK(year))
    }
}