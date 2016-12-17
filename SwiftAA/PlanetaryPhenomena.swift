//
//  Planet.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

/**
 *  The Planet protocol specializes the PlanetaryBase for planets that are not the Earth!
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
    func inferiorConjunction(_ mean: Bool) -> JulianDay
    
    /**
     Compute the julian day of the superior conjunction of the planet after the given julian day.
     
     - parameter mean: The 'mean' configuration here means that it is calculated from
     circular orbits and uniform planetary motions. See AA. pp 250.
     
     if false, the true inferior conjunction is computed. That is, calculated by adding corrections
     to computations made from circular orbits and uniform planetary motions. See AA. pp 251.
     
     - returns: A julian day.
     */
    func superiorConjunction(_ mean: Bool) -> JulianDay    
}

public extension PlanetaryPhenomena {
        
    func inferiorConjunction(_ mean: Bool = true) -> JulianDay {
        let year = self.julianDay.date().fractionalYear
        let k = KPCAAPlanetaryPhenomena_K(year, self.planetaryObject, .INFERIOR_CONJUNCTION)
        if mean == true {
            return JulianDay(KPCAAPlanetaryPhenomena_Mean(k, self.planetaryObject, .INFERIOR_CONJUNCTION))
        }
        else {
            return JulianDay(KPCAAPlanetaryPhenomena_True(k, self.planetaryObject, .INFERIOR_CONJUNCTION))
        }
    }

    func superiorConjunction(_ mean: Bool = true) -> JulianDay {
        let year = self.julianDay.date().fractionalYear
        let k = KPCAAPlanetaryPhenomena_K(year, self.planetaryObject, .SUPERIOR_CONJUNCTION)
        if mean == true {
            return JulianDay(KPCAAPlanetaryPhenomena_Mean(k, self.planetaryObject, .SUPERIOR_CONJUNCTION))
        }
        else {
            return JulianDay(KPCAAPlanetaryPhenomena_True(k, self.planetaryObject, .SUPERIOR_CONJUNCTION))
        }
    }
}

