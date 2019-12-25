//
//  PlanetaryPhysicalDetails.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 2017-09-23.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import Foundation

/**
 *  The PlanetaryPhenomena protocol encompass all methods associated with planetary phenomena in the solar system:
 *  conjunction, oppotisions, etc.
 */
public protocol PlanetaryPhysicalDetails: PlanetaryBase {
    
    /// The planetocentric declination of the Earth. When it is positive, the planet' northern pole is tilted towards the Earth
    var planetocentricDeclinationOfTheEarth: Degree { get }
    
    /// The planetocentric declination of the Sun. When it is positive, the planet' northern pole is tilted towards the Sun
    var planetocentricDeclinationOfTheSun: Degree { get }
    
    /// The position angle of the northern rotation pole of the planet
    var positionAngleOfNorthernRotationPole: Degree { get }
}

public protocol MarsPhysicalDetails: PlanetaryPhysicalDetails {
    
    /// See AA. ch 42, pp. 287-
    
    /// The greatest defect of illumination of the angular quantity of the greatest length
    /// of the dark region linking up the illuminated limb and the planet disk border.
    var angularAmountOfGreatestDefectOfIllumination: ArcSecond { get }
    
    /// The greatest defect of illumination of the angular quantity of the greatest length
    /// of the dark region linking up the illuminated limb and the planet disk border.
    var positionAngleOfGreatestDefectOfIllumination: Degree { get }
    
    /// The aerographic coordinates are those of Mars, to be compared geographic for the Earth.
    var aerographicLongitudeOfCentralMeridian: Degree { get }

    /// The aerographic coordinates are those of Mars, to be compared geographic for the Earth.
    var apparentDiameter: ArcSecond { get }
}


public protocol JupiterPhysicalDetails: PlanetaryPhysicalDetails {
    
    /// See AA. ch 43, pp. 293-
    
    var geometricCentralMeridianLongitudeSystemI: Degree { get }
    
    var geometricCentralMeridianLongitudeSystemII: Degree { get }
    
    var apparentCentralMeridianLongitudeSystemI: Degree { get }
    
    var apparentCentralMeridianLongitudeSystemII: Degree { get }
}

