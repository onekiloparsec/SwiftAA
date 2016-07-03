//
//  EclipticObject.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

enum PlanetError: ErrorType {
    case InvalidSubtype
    case InvalidCase
}

public protocol PlanetaryBase {
    /// The mean color of the planet
    static var color: Color { get }
    
    var julianDay: JulianDay { get set }
    var highPrecision: Bool { get set }

    /**
     Initialization of a Planet
     
     - parameter julianDay:     The julian day at which one will consider the planet
     - parameter highPrecision: Use VSOP87 implementation will be used to increase precision.
     
     - returns: A new instance of a PlanetaryBase object
     */
    init(julianDay: JulianDay, highPrecision: Bool)

    // The planet type indexes
    var planet: KPCAAPlanet { get }
    var planetaryObject: KPCPlanetaryObject { get }
    
    // The planet name
    var name: String { get }
    
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

public extension PlanetaryBase {    
    var planet: KPCAAPlanet {
        return KPCAAPlanet.fromString(self.name)
    }
    
    var planetaryObject: KPCPlanetaryObject {
        switch self.planet {
        case .Mercury:
            return .MERCURY
        case .Venus:
            return .VENUS
        case .Mars:
            return .MARS
        case .Jupiter:
            return .JUPITER
        case .Saturn:
            return .SATURN
        case .Uranus:
            return .URANUS
        case .Neptune:
            return .NEPTUNE
        default:
            break
        }
//        see what god himself says https://forums.developer.apple.com/thread/4289#11819 about throwing errors in computed properties
//        throw PlanetError.InvalidSubtype
        return .UNDEFINED
    }
    
    var name: String {
        get { return String(self.dynamicType) }
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
        get { return KPCAAPlanetPerihelionAphelion_Aphelion(KPCAAPlanetPerihelionAphelion_K(Double(self.julianDay.Date().Year()), self.planet), self.planet) }
    }
}
