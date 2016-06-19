//
//  Planet.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

/**
 *  The Planet protocol specializes the EclipticObject for planets that are not the Earth!
 */
public protocol Planet: EclipticObject {
    
    var planet: KPCPlanetaryObject { get }

    /**
     Compute the julian day of the perihelion of the planet for a given year
     
     - parameter year: The year to consider. Can have decimals.
     
     - returns: A julian day
     */
    func perihelion(year: Double) -> JulianDay
    
    /**
     Compute the julian day of the aphelion of the planet for a given year
     
     - parameter year: The year to consider. Can have decimals.
     
     - returns: A julian day
     */
    func aphelion(year: Double) -> JulianDay
    
    /**
     Compute the julian day of the mean inferior conjunction of the planet for the given year.
     The 'mean' configuration here means that it is calculated from
     circular orbits and uniform planetary motions. See AA. pp 250.
     
     - parameter year: The year to consider. Can have decimals.
     
     - returns: A julian day.
     */
    func meanInferiorConjunction(year: Double) -> JulianDay
    
    /**
     Compute the julian day of the true inferior conjunction of the planet for the given year.
     The 'true' configuration here means that it is calculated by adding corrections to computations made from
     circular orbits and uniform planetary motions. See AA. pp 251.
     
     - parameter year: The year to consider. Can have decimals.
     
     - returns: A julian day.
     */
    func trueInferiorConjunction(year: Double) -> JulianDay
    
    /**
     Compute the julian day of the mean superior conjunction of the planet for the given year.
     The 'mean' configuration here means that it is calculated from
     circular orbits and uniform planetary motions. See AA. pp 250.
     
     - parameter year: The year to consider. Can have decimals.
     
     - returns: A julian day.
     */
    func meanSuperiorConjunction(year: Double) -> JulianDay
    
    /**
     Compute the julian day of the true superior conjunction of the planet for the given year.
     The 'true' configuration here means that it is calculated by adding corrections to computations made from
     circular orbits and uniform planetary motions. See AA. pp 251.
     
     - parameter year: The year to consider. Can have decimals.
     
     - returns: A julian day.
     */
    func trueSuperiorConjunction(year: Double) -> JulianDay
    
    /**
     Compute the details of the planet configuration
     
     - parameter highPrecision: If true, the VSOP87 implementation will be used to increase precision.
     
     - returns: a KPCAAEllipticalPlanetaryDetails struct
     */
    func planetaryDetails(highPrecision: Bool) -> KPCAAEllipticalPlanetaryDetails
    
    /**
     Compute the illuminated fraction of the planet as seen from the Earth.
     
     - parameter highPrecision: If true, the VSOP87 implementation will be used to increase precision.

     - returns: a value between 0 and 1.
     */
    func illuminatedFraction(highPrecision: Bool) -> Double
}

public extension Planet {
    
    func perihelion(year: Double) -> JulianDay {
        return KPCAAPlanetPerihelionAphelion_Perihelion(KPCAAPlanetPerihelionAphelion_K(year, self.eclipticObject), self.eclipticObject)
    }
    
    func aphelion(year: Double) -> JulianDay {
        return KPCAAPlanetPerihelionAphelion_Aphelion(KPCAAPlanetPerihelionAphelion_K(year, self.eclipticObject), self.eclipticObject)
    }

    func meanInferiorConjunction(year: Double) -> JulianDay {
        let k = KPCAAPlanetaryPhenomena_K(year, self.planet, KPCPlanetaryEventType.INFERIOR_CONJUNCTION)
        return KPCAAPlanetaryPhenomena_Mean(k, self.planet, KPCPlanetaryEventType.INFERIOR_CONJUNCTION)
    }

    func trueInferiorConjunction(year: Double) -> JulianDay {
        let k = KPCAAPlanetaryPhenomena_K(year, self.planet, KPCPlanetaryEventType.INFERIOR_CONJUNCTION)
        return KPCAAPlanetaryPhenomena_True(k, self.planet, KPCPlanetaryEventType.INFERIOR_CONJUNCTION)
    }

    func meanSuperiorConjunction(year: Double) -> JulianDay {
        let k = KPCAAPlanetaryPhenomena_K(year, self.planet, KPCPlanetaryEventType.SUPERIOR_CONJUNCTION)
        return KPCAAPlanetaryPhenomena_Mean(k, self.planet, KPCPlanetaryEventType.SUPERIOR_CONJUNCTION)
    }

    func trueSuperiorConjunction(year: Double) -> JulianDay {
        let k = KPCAAPlanetaryPhenomena_K(year, self.planet, KPCPlanetaryEventType.SUPERIOR_CONJUNCTION)
        return KPCAAPlanetaryPhenomena_True(k, self.planet, KPCPlanetaryEventType.SUPERIOR_CONJUNCTION)
    }
    
    func planetaryDetails(highPrecision: Bool = true) -> KPCAAEllipticalPlanetaryDetails {
        return KPCAAElliptical_CalculatePlanetaryDetails(self.julianDay, self.planet, highPrecision)
    }
    
    func illuminatedFraction(highPrecision: Bool = true) -> Double {
        // Delta = ApparentGeocentricDistance = distance earth-planet
        let Delta = self.planetaryDetails().ApparentGeocentricDistance
        let earth = Earth(julianDay: self.julianDay)

        let phaseAngle = KPCAAIlluminatedFraction_PhaseAngle(self.radiusVector(highPrecision),
                                                             earth.radiusVector(highPrecision),
                                                             Delta)
        
        return KPCAAIlluminatedFraction_IlluminatedFraction(phaseAngle)
    }
}