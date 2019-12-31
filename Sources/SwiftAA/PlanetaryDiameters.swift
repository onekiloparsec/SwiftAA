//
//  Diameters.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 2017-09-23.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import Foundation
import ObjCAA

enum InvalidParameterError: Error {
    case invalidPlanet(KPCAAPlanet)
}

public protocol PlanetaryDiameters: EllipticalPlanetaryDetails {

    /// The equatorial semi diameter of the planet. Note that values of the Astronomical Almanac of 1984 are returned.
    /// There are also older values (1980) named "A" values. In the case of Venus, the "B" value refers to the planet's
    /// crust, while the "A" value refers to the top of the cloud level. The latter is more relevant for astronomical
    /// phenomena such as transits and occultations.
    func equatorialSemiDiameter(usingOldValues: Bool) throws -> Degree

    /// The polar semi diameter of the planet. See `equatorialSemiDiameter` about "A" et "B" values.
    /// Note that for all planets but Jupiter and Saturn, the polarSemiDiameter is identical to the equatorial one.
    func polarSemiDiameter(usingOldValues: Bool) throws -> Degree
}

public extension PlanetaryDiameters {
    /// The equatorial semi diameter of the object
    func equatorialSemiDiameter(usingOldValues: Bool = false) throws -> Degree {
        if (usingOldValues) {
            guard self.planet != .Pluto else {
                throw InvalidParameterError.invalidPlanet(self.planet)
            }
            return Degree(KPCAADiameters_EquatorialSemiDiameterA(self.planetStrict, self.trueGeocentricDistance.value))
        } else {
            return Degree(KPCAADiameters_EquatorialSemiDiameterB(self.planet, self.trueGeocentricDistance.value))
        }
    }
    
    /// The polar semi diameter of the object.
    func polarSemiDiameter(usingOldValues: Bool = false) throws -> Degree {
        if (usingOldValues) {
            guard self.planet != .Pluto else {
                throw InvalidParameterError.invalidPlanet(self.planet)
            }
            return Degree(KPCAADiameters_PolarSemiDiameterA(self.planetStrict, self.trueGeocentricDistance.value))
        } else {
            return Degree(KPCAADiameters_PolarSemiDiameterB(self.planet, self.trueGeocentricDistance.value))
        }
    }
}
