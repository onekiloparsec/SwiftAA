//
//  Earth.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Earth: EarthPlanet {
    public static var color: Color {
        get { return Color(red:0.133, green:0.212, blue:0.290, alpha:1.000) }
    }
    
    public fileprivate(set) var julianDay: JulianDay
    public fileprivate(set) var highPrecision: Bool
    
    public let equatorialRadius: Meters = 6378140.0
    public let polarRadius: Meters = 6356760.0

    public init(julianDay: JulianDay, highPrecision: Bool = true) {
        self.julianDay = julianDay
        self.highPrecision = highPrecision
    }
        
    // Additional methods for Earth to deal with the baryCentric parameter
    func perihelion(_ year: Double, baryCentric: Bool = true) -> JulianDay {
        return KPCAAPlanetPerihelionAphelion_EarthPerihelion(KPCAAPlanetPerihelionAphelion_EarthK(year), baryCentric)
    }
    
    func aphelion(_ year: Double, baryCentric: Bool = true) -> JulianDay {
        return KPCAAPlanetPerihelionAphelion_EarthAphelion(KPCAAPlanetPerihelionAphelion_EarthK(year), baryCentric)
    }
    
    func longitudeOfAscendingNode() -> Degrees {
        // There is no method for .MeanEquinoxOfTheDate, hence defaulting to J2000
        return KPCAAElementsPlanetaryOrbit_LongitudeAscendingNodeJ2000(self.planetStrict, self.julianDay)
    }

    /**
     Computes the julian day of the equinox for the given year
     
     - parameter northward: if yes, means the spring equinox for the northern hemisphere.
     if flase, it is the autumn equinox of the northern hemisphere.
     
     - returns: A julian day
     */
    func equinox(_ northward: Bool) -> JulianDay {
        let year = self.julianDay.date().year
        if northward == true {
            return KPCAAEquinoxesAndSolstices_NorthwardEquinox(year, self.highPrecision)
        }
        else {
            return KPCAAEquinoxesAndSolstices_SouthwardEquinox(year, self.highPrecision)
        }
    }
    
    /**
     Computes the julian day of the solstice for the given year
     
     - parameter northern: if true, means the summer solstice in the northern hemisphere,
     if false, means the winter solstice in the norther hemisphere.
     
     - returns: A julian day
     */
    func solstice(_ northern: Bool) -> JulianDay {
        let year = self.julianDay.date().year
        if northern == true {
            return KPCAAEquinoxesAndSolstices_NorthernSolstice(year, self.highPrecision)
        }
        else {
            return KPCAAEquinoxesAndSolstices_SouthernSolstice(year, self.highPrecision)
        }
    }
    
    /**
     Computes the length of a given season.
     
     - parameter season:             The season to compute the length of.
     - parameter northernHemisphere: A flag indicating which hemisphere to consider
     
     - returns: A length in (Julian) Days.
     */
    func lengthOfSeason(_ season: Season, northernHemisphere: Bool) -> Double {
        let year = self.julianDay.date().year
        switch season {
        case .spring:
            return KPCAAEquinoxesAndSolstices_LengthOfSpring(year, northernHemisphere, self.highPrecision)
        case .summer:
            return KPCAAEquinoxesAndSolstices_LengthOfSummer(year, northernHemisphere, self.highPrecision)
        case .autumn:
            return KPCAAEquinoxesAndSolstices_LengthOfAutumn(year, northernHemisphere, self.highPrecision)
        case .winter:
            return KPCAAEquinoxesAndSolstices_LengthOfWinter(year, northernHemisphere, self.highPrecision)
        }
    }
}
