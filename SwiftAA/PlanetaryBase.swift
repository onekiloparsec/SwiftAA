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


/// The PlanetaryBase extends the simple ObjectBase protocol to provide specific accesors for solar-system planets.
public protocol PlanetaryBase: ObjectBase {
    
    /// The index of the planet in the historical list of all 9 planets: from Mercury to Pluto, including the Earth.
    var planet: KPCAAPlanet { get }
    
    /// The index of the planet in the official list of 8 planets, that is, not accounting the dwarf planet, Pluto.
    var planetStrict: KPCAAPlanetStrict { get }
    
    /// The index of the planet in the list of all planets, but the Earth.
    var planetaryObject: KPCPlanetaryObject { get }
    
    /// The julian day of the perihelion of the planet the after the given julian day of the object.
    var perihelion: JulianDay { get }
    
    /// The julian day of the aphelion of the planet the after the given julian day of the object.
    var aphelion: JulianDay { get }
    
    /// The distance to the Sun.
    var radiusVector: AstronomicalUnit { get }
}

// MARK: -

public extension PlanetaryBase {
    
    /// The index of the planet in the historical list of all 9 planets: from Mercury to Pluto, including the Earth.
    var planet: KPCAAPlanet {
        return KPCAAPlanet.fromString(self.name)
    }
    
    /// The index of the planet in the official list of 8 planets, that is, not accounting the dwarf planet, Pluto.
    var planetStrict: KPCAAPlanetStrict {
        return KPCAAPlanetStrict.fromPlanet(self.planet)
    }
    
    /// The index of the planet in the list of all planets, but the Earth.
    var planetaryObject: KPCPlanetaryObject {
        return KPCPlanetaryObject.fromPlanet(self.planet)
    }
    
    /// The julian day of the perihelion of the planet the after the given julian day of the object.
    var perihelion: JulianDay {
        get {
            let k = KPCAAPlanetPerihelionAphelion_K(self.julianDay.date.fractionalYear, self.planetStrict)
            return JulianDay(KPCAAPlanetPerihelionAphelion_Perihelion(k, self.planetStrict))
        }
    }
    
    /// The julian day of the aphelion of the planet the after the given julian day of the object.
    var aphelion: JulianDay {
        get {
            let k = KPCAAPlanetPerihelionAphelion_K(self.julianDay.date.fractionalYear, self.planetStrict)
            return JulianDay(KPCAAPlanetPerihelionAphelion_Aphelion(k, self.planetStrict))
        }
    }
    
    /// The distance to the Sun.
    var radiusVector: AstronomicalUnit {
        get { return AstronomicalUnit(KPCAAEclipticalElement_RadiusVector(self.julianDay.value, self.planet, self.highPrecision)) }
    }
}


