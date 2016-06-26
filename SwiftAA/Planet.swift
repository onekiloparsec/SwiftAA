//
//  EclipticObject.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation


public protocol Planet: TimeBase {
    /**
     Identifies the ecliptical object.
     */
    var planet: KPCAAPlanet { get }
    var name: String { get }

    /// The mean color of the planet
    static var color: Color { get }

    init(julianDay: JulianDay)
    
    /**
     Compute the ecliptic (=heliocentric) longitude of the planet
     
     - parameter hp: If true, the VSOP87 implementation will be used to increase precision.
     
     - returns: the ecliptic longitude in AU
     */
    func eclipticLongitude(highPrecision: Bool) -> Degrees
    
    /**
     Compute the ecliptic (=heliocentric) latitude of the planet
     
     - parameter hp: If true, the VSOP87 implementation will be used to increase precision.
     
     - returns: the ecliptic latitude in AU
     */
    func eclipticLatitude(highPrecision: Bool) -> Degrees
    
    /**
     Compute the radius vector (=distance to the Sun)
     
     - parameter hp: If true, the VSOP87 implementation will be used to increase precision.
     
     - returns: the radius vector in AU
     */
    func radiusVector(highPrecision: Bool) -> AU

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
}

public extension Planet {
    var name: String {
        get { return self.planet.toString() }
    }
    
    func eclipticLongitude(highPrecision: Bool = true) -> Degrees {
        return KPCAAEclipticalElement_EclipticLongitude(self.julianDay, self.planet, highPrecision)
    }
    
    func eclipticLatitude(highPrecision: Bool = true) -> Degrees {
        return KPCAAEclipticalElement_EclipticLatitude(self.julianDay, self.planet, highPrecision)
    }
    
    func radiusVector(highPrecision: Bool = true) -> AU {
        return KPCAAEclipticalElement_RadiusVector(self.julianDay, self.planet, highPrecision)
    }

    func perihelion(year: Double) -> JulianDay {
        return KPCAAPlanetPerihelionAphelion_Perihelion(KPCAAPlanetPerihelionAphelion_K(year, self.planet), self.planet)
    }
    
    func aphelion(year: Double) -> JulianDay {
        return KPCAAPlanetPerihelionAphelion_Aphelion(KPCAAPlanetPerihelionAphelion_K(year, self.planet), self.planet)
    }
}
