//
//  Sun.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/07/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

/// The Sun.
public class Sun: Object, CelestialBody {
    
    public fileprivate(set) lazy var physicalDetails: KPCAAPhysicalSunDetails = {
        [unowned self] in
        return KPCAAPhysicalSun_CalculateDetails(self.julianDay.value, self.highPrecision)
        }()
    
    public fileprivate(set) lazy var eclipseDetails: KPCAASolarEclipseDetails = {
        [unowned self] in
        KPCAAEclipses_CalculateSolar(KPCAAMoonPhases_K(self.julianDay.date.fractionalYear))
        }()
    
    /// The (constant) diameter of the Sun.
    public let diameter: Meter = 1392000000.0
    
    // Celestial Body
    
    public var equatorialSemiDiameter: Degree {
        get { return Degree(KPCAADiameters_SunSemidiameterA(self.radiusVector.value)) }
    }
    
    public var polarSemiDiameter: Degree {
        get { return self.equatorialSemiDiameter }
    }
    
    /**
     Computes the time of the next start of the synodic rotation of the Sun
     (used to follow sunspots).
     
     - returns: The julian day of the next stary
     */
    public func nextStartOfTimeOfRotation() -> JulianDay {
        let C = ceil((self.julianDay.value - 2398140.2270)/27.2752316) // Equ 29.1 of AA.
        return JulianDay(KPCAAPhysicalSun_TimeOfStartOfRotation(Int(C)))
    }
    
    /// Celestial Body
    
    /// The radius vector (distance to the Sun... here to conform to CelestialBody protocol).
    public var radiusVector: AstronomicalUnit { return 0.0 }
    
    /// The ecliptic coordinates of the Sun
    public var eclipticCoordinates: EclipticCoordinates {
        get { return EclipticCoordinates(lambda: Degree(KPCAASun_GeometricEclipticLongitude(self.julianDay.value, self.highPrecision)),
                                         beta: Degree(KPCAASun_GeometricEclipticLatitude(self.julianDay.value, self.highPrecision)),
                                         epoch: self.julianDay) }
    }

    public var apparentEclipticCoordinates: EclipticCoordinates {
        get { return EclipticCoordinates(lambda: Degree(KPCAASun_ApparentEclipticLongitude(self.julianDay.value, self.highPrecision)),
                                         beta: Degree(KPCAASun_ApparentEclipticLatitude(self.julianDay.value, self.highPrecision)),
                                         epoch: self.julianDay) }
    }

    /// The equatorial coordinates of the Sun
    public var equatorialCoordinates: EquatorialCoordinates {
        get { return self.eclipticCoordinates.makeEquatorialCoordinates() }
    }

    /// The apparent equatorial coordinates of the Sun
    public var apparentEquatorialCoordinates: EquatorialCoordinates {
        get { return self.apparentEclipticCoordinates.makeApparentEquatorialCoordinates() }
    }

    /// Celestial Body Supplement
    
    /// See AA, p.164. In some instances, for example in meteor work, it is necessary to have the Sun's longitude
    /// referred to the standard equinox of J2000.0. Between, 1900 and 2100, this can be performed with sufficient
    /// accuracy.
    public var eclipticCoordinatesStandardJ2000: EclipticCoordinates {
        get { return EclipticCoordinates(lambda: Degree(KPCAASun_GeometricEclipticLongitudeJ2000(self.julianDay.value, self.highPrecision)),
                                         beta: Degree(KPCAASun_GeometricEclipticLatitudeJ2000(self.julianDay.value, self.highPrecision))) }
    }
    
    /**
     This is the position angle of the northern extremity of the axis of rotation,
     measured eastwards from the North Point of the solar disk.
    
     - returns: The position angle in degrees.
     */
    func positionAngleOfNorthernRotationAxisPoint() -> Degree {
        return Degree(self.physicalDetails.P)
    }
    
    /**
     The heliographic latitude of the center of the solar disk. It represents the tilt
     of the Sun's north pole toward (+) or away (-) from Earth. It is zero about June 6
     and December 7, and reaches a maximum value about March 6 (-7º.25) and September 8
     (+7º.25).
     
     - returns: The latitude in degrees.
     */
    func heliographicLatitudeOfSolarDiskCenter() -> Degree {
        return Degree(self.physicalDetails.B0)
    }
    
    /**
     The heliographic longitude of the center of the solar disk. It decreases by about 
     13.2 degrees per day.
     
     - returns: The longitude in degrees.
     */
    func heliographicLongitudeOfSolarDiskCenter() -> Degree {
        return Degree(self.physicalDetails.L0)
    }

    /**
     A synodic rotation cycle of the Sun begins when the heliographic longitude of the
     solar disk center is 0º.
     
     - parameter C: The rotation number. C = 1 on November 9, 1853.
     
     - returns: The julian day of the start of the cycle.
     */
    func timeOfStartOfSynodicRotation(rotationNumber C: Int) -> JulianDay {
        return JulianDay(KPCAAPhysicalSun_TimeOfStartOfRotation(C))
    }
    
    // MARK: - Equation of Time
    
    /// Compute the equation of time, that is, the difference between the apparent and the mean time. Or, in other
    /// words, the difference between the hour angle of the true Sun and the mean Sun.
    ///
    /// - returns: The equation of time, in days.
    public func equationOfTime() -> Day {
        // KPCAA result is in minutes of time.
        return Day(KPCAAEquationOfTime_Calculate(self.julianDay.value, self.highPrecision) / (24.0 * 60.0))
    }
    
    public static let apparentRiseSetAltitude = ArcMinute(-50).inDegrees // See AA p.101
    
    
    public func makeHorizontalCoordinates(with geographicCoordinates: GeographicCoordinates) -> HorizontalCoordinates {
        return self.apparentEquatorialCoordinates.makeHorizontalCoordinates(with: geographicCoordinates, julianDay: self.julianDay)
    }
}

