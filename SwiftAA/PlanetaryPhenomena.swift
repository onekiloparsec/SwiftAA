//
//  Planet.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

/**
 *  The PlanetaryPhenomena protocol encompass all methods associated with planetary phenomena in the solar system:
 *  conjunction, oppotisions, etc.
 */
public protocol PlanetaryPhenomena: PlanetaryBase {
        
    /**
     Compute the julian day of the inferior conjunction of the planet after the given julian day.

     - parameter mean: The 'mean' configuration here means that it is calculated from 
     circular orbits and uniform planetary motions. See AA. pp 250.
     
     if false, the true inferior conjunction is computed. That is, calculated by adding corrections 
     to computations made from circular orbits and uniform planetary motions. See AA. pp 251.
     
     - returns: A julian day.
     */
    func inferiorConjunction(mean: Bool) -> JulianDay
    
    /**
     Compute the julian day of the superior conjunction of the planet after the given julian day.
     
     - parameter mean: The 'mean' configuration here means that it is calculated from
     circular orbits and uniform planetary motions. See AA. pp 250.
     
     if false, the true inferior conjunction is computed. That is, calculated by adding corrections
     to computations made from circular orbits and uniform planetary motions. See AA. pp 251.
     
     - returns: A julian day.
     */
    func superiorConjunction(mean: Bool) -> JulianDay
    
    func opposition(mean: Bool) -> JulianDay
    func conjunction(mean: Bool) -> JulianDay
    func easternElongation(mean: Bool) -> JulianDay
    func westernElongation(mean: Bool) -> JulianDay
    func station1(mean: Bool) -> JulianDay
    func station2(mean: Bool) -> JulianDay
    func elongationValue(eastern: Bool) -> Degree
}

public extension PlanetaryPhenomena {
    
    func inferiorConjunction(mean: Bool = true) -> JulianDay {
        return JulianDay(KPCAAPlanetaryPhenomena(mean, self.julianDay.date.fractionalYear, self.planetaryObject, .INFERIOR_CONJUNCTION))
    }

    func superiorConjunction(mean: Bool = true) -> JulianDay {
        return JulianDay(KPCAAPlanetaryPhenomena(mean, self.julianDay.date.fractionalYear, self.planetaryObject, .SUPERIOR_CONJUNCTION))
    }

    func opposition(mean: Bool = true) -> JulianDay {
        return JulianDay(KPCAAPlanetaryPhenomena(mean, self.julianDay.date.fractionalYear, self.planetaryObject, .OPPOSITION))
    }

    func conjunction(mean: Bool = true) -> JulianDay {
        return JulianDay(KPCAAPlanetaryPhenomena(mean, self.julianDay.date.fractionalYear, self.planetaryObject, .CONJUNCTION))
    }

    func easternElongation(mean: Bool = true) -> JulianDay {
        return JulianDay(KPCAAPlanetaryPhenomena(mean, self.julianDay.date.fractionalYear, self.planetaryObject, .EASTERN_ELONGATION))
    }

    func westernElongation(mean: Bool = true) -> JulianDay {
        return JulianDay(KPCAAPlanetaryPhenomena(mean, self.julianDay.date.fractionalYear, self.planetaryObject, .WESTERN_ELONGATION))
    }

    func station1(mean: Bool = true) -> JulianDay {
        return JulianDay(KPCAAPlanetaryPhenomena(mean, self.julianDay.date.fractionalYear, self.planetaryObject, .STATION1))
    }

    func station2(mean: Bool = true) -> JulianDay {
        return JulianDay(KPCAAPlanetaryPhenomena(mean, self.julianDay.date.fractionalYear, self.planetaryObject, .STATION2))
    }

    func elongationValue(eastern: Bool = true) -> Degree {
        let k = KPCAAPlanetaryPhenomena_K(self.julianDay.date.fractionalYear, self.planetaryObject, .EASTERN_ELONGATION)
        return Degree(KPCAAPlanetaryPhenomena_ElongationValue(k, self.planetaryObject, eastern))
    }

}

