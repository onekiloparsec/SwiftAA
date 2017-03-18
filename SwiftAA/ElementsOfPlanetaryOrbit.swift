//
//  ElementsOfPlanetaryOrbit.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 26/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public protocol ElementsOfPlanetaryOrbit: PlanetaryBase {
    /// Computes the mean longitude of the orbit
    ///
    /// - Parameter equinox: The equinox for which the computation is made
    /// - Returns: The longitude in degrees
    func meanLongitude(_ equinox: Equinox) -> Degree
    
    /// Computes the semi major axis of the orbit
    ///
    /// - Returns: The semi major axis in astronomical units
    func semimajorAxis() -> AstronomicalUnit
    
    /// Computes the eccentricity of the orbit
    ///
    /// - Returns: The eccentricity (comprise between 0==circular, and 1).
    func eccentricity() -> Double
    
    /// Computes the inclination of the planet on the plane of the ecliptic
    ///
    /// - Parameter equinox: The equinox for which the computation is made
    /// - Returns: The inclination in degrees
    func inclination(_ equinox: Equinox) -> Degree
    
    /// Computes the longitude of the ascending node.
    ///
    /// - Parameter equinox: The equinox for which the computation is made
    /// - Returns: The longitude in degrees
    func longitudeOfAscendingNode(_ equinox: Equinox) -> Degree
    
    /// Compute the longitude of the perihelion
    ///
    /// - Parameter equinox: The equinox for which the computation is made
    /// - Returns: The longitude in degrees
    func longitudeOfPerihelion(_ equinox: Equinox) -> Degree    
}

public extension ElementsOfPlanetaryOrbit {
    /// Computes the mean longitude of the orbit
    ///
    /// - Parameter equinox: The equinox for which the computation is made
    /// - Returns: The longitude in degrees
    func meanLongitude(_ equinox: Equinox = .standardJ2000) -> Degree {
        switch equinox {
        case .meanEquinoxOfTheDate:
            return Degree(KPCAAElementsPlanetaryOrbit_MeanLongitude(self.planetStrict, self.julianDay.value))
        case .standardJ2000:
            return Degree(KPCAAElementsPlanetaryOrbit_MeanLongitudeJ2000(self.planetStrict, self.julianDay.value))
        }
    }
    
    /// Computes the semi major axis of the orbit
    ///
    /// - Returns: The semi major axis in astronomical units
    func semimajorAxis() -> AstronomicalUnit {
        return AstronomicalUnit(KPCAAElementsPlanetaryOrbit_SemimajorAxis(self.planetStrict, self.julianDay.value))
    }
    
    /// Computes the eccentricity of the orbit
    ///
    /// - Returns: The eccentricity (comprise between 0==circular, and 1).
    func eccentricity() -> Double {
        return KPCAAElementsPlanetaryOrbit_Eccentricity(self.planetStrict, self.julianDay.value)
    }
    
    /// Computes the inclination of the planet on the plane of the ecliptic
    ///
    /// - Parameter equinox: The equinox for which the computation is made
    /// - Returns: The inclination in degrees
    func inclination(_ equinox: Equinox = .standardJ2000) -> Degree {
        switch equinox {
        case .meanEquinoxOfTheDate:
            return Degree(KPCAAElementsPlanetaryOrbit_Inclination(self.planetStrict, self.julianDay.value))
        case .standardJ2000:
            return Degree(KPCAAElementsPlanetaryOrbit_InclinationJ2000(self.planetStrict, self.julianDay.value))
        }
    }
    
    /// Computes the longitude of the ascending node.
    ///
    /// - Parameter equinox: The equinox for which the computation is made
    /// - Returns: The longitude in degrees
    func longitudeOfAscendingNode(_ equinox: Equinox = .standardJ2000) -> Degree {
        switch equinox {
        case .meanEquinoxOfTheDate:
            return Degree(KPCAAElementsPlanetaryOrbit_LongitudeAscendingNode(self.planetStrict, self.julianDay.value))
        case .standardJ2000:
            return Degree(KPCAAElementsPlanetaryOrbit_LongitudeAscendingNodeJ2000(self.planetStrict, self.julianDay.value))
        }
    }
    
    /// Compute the longitude of the perihelion
    ///
    /// - Parameter equinox: The equinox for which the computation is made
    /// - Returns: The longitude in degrees
    func longitudeOfPerihelion(_ equinox: Equinox = .standardJ2000) -> Degree {
        switch equinox {
        case .meanEquinoxOfTheDate:
            return Degree(KPCAAElementsPlanetaryOrbit_LongitudePerihelion(self.planetStrict, self.julianDay.value))
        case .standardJ2000:
            return Degree(KPCAAElementsPlanetaryOrbit_LongitudePerihelionJ2000(self.planetStrict, self.julianDay.value))
        }
    }
}
