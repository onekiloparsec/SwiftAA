//
//  Venus.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

// AA, pp. 269 and followings: 

public struct Venus {
    let julianDay: Double
    
    init(julianDay: Double) {
        self.julianDay = julianDay
    }
    
    func eclipticLongitude(withHighPrecision hp: Bool = true) -> Double {
        return KPCAAVenus_EclipticLongitude(self.julianDay, hp)
    }

    func eclipticLatitude(withHighPrecision hp: Bool = true) -> Double {
        return KPCAAVenus_EclipticLatitude(self.julianDay, hp)
    }

    func radiusVector(withHighPrecision hp: Bool = true) -> Double {
        return KPCAAVenus_RadiusVector(self.julianDay, hp)
    }
    
    /**
     Compute the julian day of the perihelion of Venus for a given year
     
     - parameter year: The year to consider. Can have decimals.
     
     - returns: A julian day
     */
    func perihelion(year: Double) -> JulianDay {
        return KPCAAPlanetPerihelionAphelion_MercuryPerihelion(KPCAAPlanetPerihelionAphelion_MercuryK(year))
    }

    /**
     Compute the julian day of the aphelion of Venus for a given year
     
     - parameter year: The year to consider. Can have decimals.
     
     - returns: A julian day
     */
    func aphelion(year: Double) -> JulianDay {
        return KPCAAPlanetPerihelionAphelion_MercuryAphelion(KPCAAPlanetPerihelionAphelion_MercuryK(year))
    }
    
    /**
     Compute the julian day of the mean inferior conjunction of Venus for the given year.
     The 'mean' configuration here means that it is calculated from 
     circular orbits and uniform planetary motions. See AA. pp 250.
     
     - parameter year: The year to consider. Can have decimals.
     
     - returns: A julian day.
     */
    func meanInferiorConjunction(year: Double) -> JulianDay {
        let k = KPCAAPlanetaryPhenomena_K(year, KPCPlanetaryObject.VENUS, KPCPlanetaryEventType.INFERIOR_CONJUNCTION)
        return KPCAAPlanetaryPhenomena_Mean(k, KPCPlanetaryObject.VENUS, KPCPlanetaryEventType.INFERIOR_CONJUNCTION)
    }
    
    /**
     Compute the julian day of the true inferior conjunction of Venus for the given year.
     The 'true' configuration here means that it is calculated by adding corrections to computations made from
     circular orbits and uniform planetary motions. See AA. pp 251.
     
     - parameter year: The year to consider. Can have decimals.
     
     - returns: A julian day.
     */
    func trueInferiorConjunction(year: Double) -> JulianDay {
        let k = KPCAAPlanetaryPhenomena_K(year, KPCPlanetaryObject.VENUS, KPCPlanetaryEventType.INFERIOR_CONJUNCTION)
        return KPCAAPlanetaryPhenomena_True(k, KPCPlanetaryObject.VENUS, KPCPlanetaryEventType.INFERIOR_CONJUNCTION)
    }
    
    /**
     Compute the julian day of the mean superior conjunction of Venus for the given year.
     The 'mean' configuration here means that it is calculated from
     circular orbits and uniform planetary motions. See AA. pp 250.
     
     - parameter year: The year to consider. Can have decimals.
     
     - returns: A julian day.
     */
    func meanSuperiorConjunction(year: Double) -> JulianDay {
        let k = KPCAAPlanetaryPhenomena_K(year, KPCPlanetaryObject.VENUS, KPCPlanetaryEventType.SUPERIOR_CONJUNCTION)
        return KPCAAPlanetaryPhenomena_Mean(k, KPCPlanetaryObject.VENUS, KPCPlanetaryEventType.SUPERIOR_CONJUNCTION)
    }
    
    /**
     Compute the julian day of the true superior conjunction of Venus for the given year.
     The 'true' configuration here means that it is calculated by adding corrections to computations made from
     circular orbits and uniform planetary motions. See AA. pp 251.
     
     - parameter year: The year to consider. Can have decimals.
     
     - returns: A julian day.
     */
    func trueSuperiorConjunction(year: Double) -> JulianDay {
        let k = KPCAAPlanetaryPhenomena_K(year, KPCPlanetaryObject.VENUS, KPCPlanetaryEventType.SUPERIOR_CONJUNCTION)
        return KPCAAPlanetaryPhenomena_True(k, KPCPlanetaryObject.VENUS, KPCPlanetaryEventType.SUPERIOR_CONJUNCTION)
    }
    
//    func illuminatedFraction(year: Double) -> Double {
//        let r =
//    }

}