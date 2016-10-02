//
//  Planets.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 03/07/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

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

// special Pluto:
public protocol DwarfPlanet: ObjectBase, PlanetaryBase {}

