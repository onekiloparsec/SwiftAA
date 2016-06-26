//
//  EclipticObject.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation


public protocol Planet: Base {
    /// The mean color of the planet
    static var color: Color { get }

    // The planet type type
    var planet: KPCAAPlanet { get }
    
    /// The name of the planet
    var name: String { get }

    /**
     Initialization of a Planet
     
     - parameter julianDay:     The julian day at which one will consider the planet
     - parameter highPrecision: Use VSOP87 implementation will be used to increase precision.
     
     - returns: A new instance of a Planet
     */
    init(julianDay: JulianDay, highPrecision: Bool)
    
    /// The ecliptic (=heliocentric) longitude of the planet
    var eclipticLongitude: Degrees { get }
    
    /// The ecliptic (=heliocentric) latitude of the planet
    var eclipticLatitude: Degrees { get }

    /// The radius vector (=distance to the Sun)
    var radiusVector: AU { get }

    /// The julian day of the perihelion of the planet the after the given julian day
    var perihelion: JulianDay { get }
    
    /// The julian day of the aphelion of the planet the after the given julian day
    var aphelion: JulianDay { get }
}

public extension Planet {
    var name: String {
        get { return self.planet.toString() }
    }
    
    var eclipticLongitude: Degrees {
        get { return KPCAAEclipticalElement_EclipticLongitude(self.julianDay, self.planet, self.highPrecision) }
    }
    
    var eclipticLatitude: Degrees {
        get { return KPCAAEclipticalElement_EclipticLatitude(self.julianDay, self.planet, self.highPrecision) }
    }
    
    var radiusVector: AU {
        get { return KPCAAEclipticalElement_RadiusVector(self.julianDay, self.planet, self.highPrecision) }
    }

    var perihelion: JulianDay {
        get { return KPCAAPlanetPerihelionAphelion_Perihelion(KPCAAPlanetPerihelionAphelion_K(Double(self.julianDay.Date().Year()), self.planet), self.planet) }
    }
    
    var aphelion: JulianDay {
        get { KPCAAPlanetPerihelionAphelion_Aphelion(KPCAAPlanetPerihelionAphelion_K(Double(self.julianDay.Date().Year()), self.planet), self.planet) }
    }
}
