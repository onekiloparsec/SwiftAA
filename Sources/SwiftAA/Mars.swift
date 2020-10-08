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
    
    /// The geocentric position angle of Mars' northern rotation pole, also called position angle of axis. It is the angle
    /// that the Martian meridian from the center of the disk to the northern rotation pole forms (on the geocentric celestial sphere)
    /// with the declination circle through the center. It is measured eastwards from the North Point of the disk. By defintion,
    /// position angle 0º means northwards on the sky, 90º east, 180º south and 270º west. See AA. p 287.
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
    
    /// The areographic longitude of the central meridian, as seen from the Earth. The word "areographic" means that use is made
    /// of a coordinate system on the surface of Mars. Compare with "geographic" for the Earth. See AA. p 287.
    public var aerographicLongitudeOfCentralMeridian: Degree {
        return Degree(self.physicalDetails.w)
    }
    
    /// The apparent diameter of Mars
    public var apparentDiameter: ArcSecond {
        return ArcSecond(self.physicalDetails.d)
    }
}
