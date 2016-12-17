//
//  EclipticObject.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

enum PlanetError: Error {
    case invalidSubtype
    case invalidCase
}

// MARK: -

public protocol PlanetaryBase: ObjectBase {
    // The planet name
    var name: String { get }
    
    // The planet type indexes
    var planet: KPCAAPlanet { get }
    var planetStrict: KPCAAPlanetStrict { get }
    var planetaryObject: KPCPlanetaryObject { get }
    
    /// The julian day of the perihelion of the planet the after the given julian day
    var perihelion: JulianDay { get }
    
    /// The julian day of the aphelion of the planet the after the given julian day
    var aphelion: JulianDay { get }
    
    /// Distance to the Sun
    var radiusVector: AU { get }
}

// MARK: -

public extension PlanetaryBase {
    
    var name: String {
        get { return String(describing: type(of: self)) }
    }

    // MARK: Object Base
    
    var planet: KPCAAPlanet {
        return KPCAAPlanet.fromString(self.name)
    }
    
    var planetStrict: KPCAAPlanetStrict {
        return KPCAAPlanetStrict.fromPlanet(self.planet)
    }
    
    var planetaryObject: KPCPlanetaryObject {
        return KPCPlanetaryObject.fromPlanet(self.planet)
    }
    
    var perihelion: JulianDay {
        get {
            let k = KPCAAPlanetPerihelionAphelion_K(self.julianDay.date().fractionalYear, self.planetStrict)
            return JulianDay(KPCAAPlanetPerihelionAphelion_Perihelion(k, self.planetStrict))
        }
    }
    
    var aphelion: JulianDay {
        get {
            let k = KPCAAPlanetPerihelionAphelion_K(self.julianDay.date().fractionalYear, self.planetStrict)
            return JulianDay(KPCAAPlanetPerihelionAphelion_Aphelion(k, self.planetStrict))
        }
    }
    
    var radiusVector: AU {
        get { return AU(KPCAAEclipticalElement_RadiusVector(self.julianDay.value, self.planet, self.highPrecision)) }
    }
}


