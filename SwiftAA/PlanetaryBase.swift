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

public protocol PlanetaryBase: ObjectBase, OrbitingObject {    
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
        get { return KPCAAPlanetPerihelionAphelion_Perihelion(KPCAAPlanetPerihelionAphelion_K(self.julianDay.date().fractionalYear, self.planetStrict), self.planetStrict) }
    }
    
    var aphelion: JulianDay {
        get { return KPCAAPlanetPerihelionAphelion_Aphelion(KPCAAPlanetPerihelionAphelion_K(self.julianDay.date().fractionalYear, self.planetStrict), self.planetStrict) }
    }
    
    // MARK: OribitingObject
    
    var eclipticLongitude: Degrees {
        get { return KPCAAEclipticalElement_EclipticLongitude(self.julianDay, self.planet, self.highPrecision) }
    }
    
    var eclipticLatitude: Degrees {
        get { return KPCAAEclipticalElement_EclipticLatitude(self.julianDay, self.planet, self.highPrecision) }
    }
    
    public var eclipticCoordinates: EclipticCoordinates {
        get {
            // To compute the _apparent_ RA and Dec from Ecl. coords, the true obliquity must be used (hence mean: false)
            let epsilon = obliquityOfEcliptic(julianDay: self.julianDay, mean: false)
            return EclipticCoordinates(lambda: self.eclipticLongitude, beta: self.eclipticLatitude, epsilon: epsilon)
        }
    }

    var radiusVector: AU {
        get { return KPCAAEclipticalElement_RadiusVector(self.julianDay, self.planet, self.highPrecision) }
    }
}


