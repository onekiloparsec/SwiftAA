//
//  Planets.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 03/07/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

// To be understood as a "non-Earth" planet
public protocol Planet: PlanetaryBase, PlanetaryPhenomena, ElementsOfPlanetaryOrbit, IlluminatedFraction {}

// Earth special case 
public protocol EarthPlanet: PlanetaryBase, ElementsOfPlanetaryOrbit {}

// special Pluto:
public protocol DwarfPlanet: PlanetaryBase {}

