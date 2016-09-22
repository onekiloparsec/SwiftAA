//
//  Planets.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 03/07/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

// IlluminatedFraction

// To be understood as a "non-Earth" planet
public class Planet: Object, PlanetaryBase, PlanetaryPhenomena, ElementsOfPlanetaryOrbit, EllipticalPlanetaryDetails  {

    public class var averageColor: Color {
        get { return Color.white }
    }
    
    public lazy var planetaryDetails: KPCAAEllipticalPlanetaryDetails = {
        [unowned self] in
        return KPCAAElliptical_CalculatePlanetaryDetails(self.julianDay, self.planetaryObject, self.highPrecision)
        }()
    
    public lazy var ellipticalObjectDetails: KPCAAEllipticalObjectDetails = {
        [unowned self] in
        return KPCAAElliptical_CalculateObjectDetailsNoElements(self.julianDay, self.highPrecision)
        }()
    

}

// Earth special case 
public protocol EarthPlanet: PlanetaryBase, ElementsOfPlanetaryOrbit {}

// special Pluto:
public protocol DwarfPlanet: PlanetaryBase {}

