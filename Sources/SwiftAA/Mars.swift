//
//  Mars.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  MIT Licence. See LICENCE file.
//

import Foundation
import ObjCAA

/// The Mars planet.
public class Mars: Planet, PlanetaryPhysicalDetails, MarsPhysicalDetails {

    /// Accessor to all values of the underlying physical details. Will probably become private
    /// once all relevant accessors are implemented and covered.
    public fileprivate(set) lazy var physicalDetails: KPCAAPhysicalMarsDetails = {
        [unowned self] in
        return KPCAAPhysicalMars_CalculateDetails(self.julianDay.value, self.highPrecision)
        }()

    /// The average color of the Planet.
    public class override var averageColor: Color {
        get { return Color(red: 0.137, green:0.447, blue:0.208, alpha: 1.0) }
    }
    
    // MARK: - PlanetaryPhysicalDetails
    
    /// The planetocentric declination of the Earth. When it is positive, the planet' northern pole is tilted towards the Earth.
    public var planetocentricDeclinationOfTheEarth: Degree {
        return Degree(self.physicalDetails.DE)
    }

    /// The planetocentric declination of the Sun. When it is positive, the planet' northern pole is tilted towards the Sun.
    public var planetocentricDeclinationOfTheSun: Degree {
        return Degree(self.physicalDetails.DS)
    }
    
    /// The planetocentric declination of the Sun. When it is positive, the planet' northern pole is tilted towards the Sun.
    public var positionAngleOfNorthernRotationPole: Degree {
        return Degree(self.physicalDetails.P)
    }

    // MARK: - MarsPhysicalDetails

    /// The greatest defect of illumination of the angular quantity of the greatest length
    /// of the dark region linking up the illuminated limb and the planet disk border.
    public var angularAmountOfGreatestDefectOfIllumination: ArcSecond {
        return ArcSecond(self.physicalDetails.q)
    }
    
    /// The greatest defect of illumination of the angular quantity of the greatest length
    /// of the dark region linking up the illuminated limb and the planet disk border.
    public var positionAngleOfGreatestDefectOfIllumination: Degree {
        return Degree(self.physicalDetails.X + 180).reduced
    }
    
    /// The aerographic coordinates are those of Mars, to be compared geographic for the Earth.
    public var aerographicLongitudeOfCentralMeridian: Degree {
        return Degree(self.physicalDetails.w)
    }
    
    /// The apparent diameter of Mars
    public var apparentDiameter: ArcSecond {
        return ArcSecond(self.physicalDetails.d)
    }
}
