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
public protocol PlanetaryPhenomena: PlanetBase {
    
    var planetaryObject: KPCPlanetaryObject { get }
    
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
}

public extension PlanetaryPhenomena {
    
    var planetaryObject: KPCPlanetaryObject {
        if self is Planet {
            let typedSelf: Planet = self as! Planet
            switch typedSelf.planet {
            case .Mercury:
                return .MERCURY
            case .Venus:
                return .VENUS
            case .Mars:
                return .MARS
            case .Jupiter:
                return .JUPITER
            case .Saturn:
                return .SATURN
            case .Uranus:
                return .URANUS
            case .Neptune:
                return .NEPTUNE
            default:
                break
            }
        }
//        see what god himself says https://forums.developer.apple.com/thread/4289#11819 about throwing in computed properties
//        throw PlanetError.InvalidSubtype
        return .UNDEFINED
    }
    
    func inferiorConjunction(mean: Bool) -> JulianDay {
        let year = Double(self.julianDay.Date().Year())
        let k = KPCAAPlanetaryPhenomena_K(year, self.planetaryObject, .INFERIOR_CONJUNCTION)
        if mean == true {
            return KPCAAPlanetaryPhenomena_Mean(k, self.planetaryObject, .INFERIOR_CONJUNCTION)
        }
        else {
            return KPCAAPlanetaryPhenomena_True(k, self.planetaryObject, .INFERIOR_CONJUNCTION)
        }
    }

    func superiorConjunction(mean: Bool) -> JulianDay {
        let year = Double(self.julianDay.Date().Year())
        let k = KPCAAPlanetaryPhenomena_K(year, self.planetaryObject, .SUPERIOR_CONJUNCTION)
        if mean == true {
            return KPCAAPlanetaryPhenomena_Mean(k, self.planetaryObject, .SUPERIOR_CONJUNCTION)
        }
        else {
            return KPCAAPlanetaryPhenomena_True(k, self.planetaryObject, .SUPERIOR_CONJUNCTION)
        }
    }
}

