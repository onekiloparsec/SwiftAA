//
//  ElementsOfPlanetaryOrbit.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 26/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public protocol ElementsOfPlanetaryOrbit: PlanetaryBase {
    /**
     Computes the mean longitude of the orbit
     
     - parameter equinox: The equinox for which the computation is made
     
     - returns: The longitude in degrees
     */
    func meanLongitude(equinox: Equinox) -> Degrees
    
    /**
     Computes the semi major axis of the orbit
     
     - returns: The semi major axis in astronomical units
     */
    func semimajorAxis() -> AU
    
    /**
     Computes the eccentricity of the orbit
     
     - returns: The eccentricity (comprise between 0==circular, and 1).
     */
    func eccentricity() -> Double
    
    /**
     Computes the inclination of the planet on the plane of the ecliptic
     
     - parameter equinox: The equinox for which the computation is made
     
     - returns: The inclination in degrees
     */
    func inclination(equinox: Equinox) -> Degrees
    
    /**
     Computes the longitude of the ascending node.
     
     - parameter equinox: The equinox for which the computation is made
     
     - returns: The longitude in degrees
     */
    func longitudeOfAscendingNode(equinox: Equinox) -> Degrees
    
    /**
     Compute the longitude of the perihelion
     
     - parameter equinox: The equinox for which the computation is made
     
     - returns: The longitude in degrees
     */
    func longitudeOfPerihelion(equinox: Equinox) -> Degrees    
}

public extension ElementsOfPlanetaryOrbit {
    func meanLongitude(equinox: Equinox = .StandardJ2000) -> Degrees {
        switch equinox {
        case .MeanEquinoxOfTheDate:
            return KPCAAElementsPlanetaryOrbit_MeanLongitude(self.planetStrict, self.julianDay)
        case .StandardJ2000:
            return KPCAAElementsPlanetaryOrbit_MeanLongitudeJ2000(self.planetStrict, self.julianDay)
        }
    }
    
    func semimajorAxis() -> AU {
        return KPCAAElementsPlanetaryOrbit_SemimajorAxis(self.planetStrict, self.julianDay)
    }
    
    func eccentricity() -> Double {
        return KPCAAElementsPlanetaryOrbit_Eccentricity(self.planetStrict, self.julianDay)
    }
    
    func inclination(equinox: Equinox = .StandardJ2000) -> Degrees {
        switch equinox {
        case .MeanEquinoxOfTheDate:
            return KPCAAElementsPlanetaryOrbit_Inclination(self.planetStrict, self.julianDay)
        case .StandardJ2000:
            return KPCAAElementsPlanetaryOrbit_InclinationJ2000(self.planetStrict, self.julianDay)
        }
    }
    
    func longitudeOfAscendingNode(equinox: Equinox = .StandardJ2000) -> Degrees {
        switch equinox {
        case .MeanEquinoxOfTheDate:
            return KPCAAElementsPlanetaryOrbit_LongitudeAscendingNode(self.planetStrict, self.julianDay)
        case .StandardJ2000:
            return KPCAAElementsPlanetaryOrbit_LongitudeAscendingNodeJ2000(self.planetStrict, self.julianDay)
        }
    }
    
    func longitudeOfPerihelion(equinox: Equinox = .StandardJ2000) -> Degrees {
        switch equinox {
        case .MeanEquinoxOfTheDate:
            return KPCAAElementsPlanetaryOrbit_LongitudePerihelion(self.planetStrict, self.julianDay)
        case .StandardJ2000:
            return KPCAAElementsPlanetaryOrbit_LongitudePerihelionJ2000(self.planetStrict, self.julianDay)
        }
    }
}