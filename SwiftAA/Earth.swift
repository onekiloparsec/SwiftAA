//
//  Earth.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Earth: EarthPlanet {    
    public var julianDay: JulianDay
    public var highPrecision: Bool
    
    public init(julianDay: JulianDay, highPrecision: Bool = true) {
        self.julianDay = julianDay
        self.highPrecision = highPrecision
    }
    
    public static var color: Color {
        get { return Color(red:0.133, green:0.212, blue:0.290, alpha:1.000) }
    }

    // Additional methods for Earth to deal with the baryCentric parameter
    func perihelion(year: Double, baryCentric: Bool = true) -> JulianDay {
        return KPCAAPlanetPerihelionAphelion_EarthPerihelion(KPCAAPlanetPerihelionAphelion_EarthK(year), baryCentric)
    }
    
    func aphelion(year: Double, baryCentric: Bool = true) -> JulianDay {
        return KPCAAPlanetPerihelionAphelion_EarthAphelion(KPCAAPlanetPerihelionAphelion_EarthK(year), baryCentric)
    }
    
    func longitudeOfAscendingNode(equinox: Equinox) throws -> Degrees {
        switch equinox {
        case .MeanEquinoxOfTheDate:
            throw PlanetError.InvalidCase
        case .StandardJ2000:
            return KPCAAElementsPlanetaryOrbit_LongitudeAscendingNodeJ2000(self.planet, self.julianDay)
        }
    }
}
