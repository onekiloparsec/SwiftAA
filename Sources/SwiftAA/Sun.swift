//
//  Sun.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/07/16.
//  MIT Licence. See LICENCE file.
//

import Foundation
import ObjCAA

/// The Sun.
public class Sun: Object, CelestialBody {
    
    /// Accessor to all values of the underlying physical details. Will probably become private
    /// once all relevant accessors are implemented and covered.
    public fileprivate(set) lazy var physicalDetails: KPCAAPhysicalSunDetails = {
        [unowned self] in
        return KPCAAPhysicalSun_CalculateDetails(self.julianDay.value, self.highPrecision)
        }()
    
    /// Accessor to all values of the underlying eclipse details. Will probably become private
    /// once all relevant accessors are implemented and covered.
    public fileprivate(set) lazy var eclipseDetails: KPCAASolarEclipseDetails = {
        [unowned self] in
        KPCAAEclipses_CalculateSolar(KPCAAMoonPhases_K(self.julianDay.date.fractionalYear))
        }()
    
    /// The (constant) diameter of the Sun.
    public static let diameter: Meter = 1392000000.0

    /// The (constant/adopted) semi-diameter of the Sun.
    public static let semiDiameterAtOneAU: ArcSecond = 959.63

    /// The default apparent altitude of the sun to compute rise and set times.
    public static let apparentRiseSetAltitude = ArcMinute(-50).inDegrees // See AA p.101

    // MARK: - Celestial Body
    
    /// The apparent equatorial semi diameter of the sun.
    public var equatorialSemiDiameter: ArcSecond {
        get { return ArcSecond(KPCAADiameters_SunSemidiameterA(self.radiusVector.value)) }
    }
    
    /// The apparent polar semi diameter of the sun
    public var polarSemiDiameter: ArcSecond {
        get { return self.equatorialSemiDiameter }
    }
    
    /// Computes the time of the next start of the synodic rotation of the Sun
    /// (used to follow sunspots).
    ///
    /// - Returns: The julian day of the next start
    public func nextStartOfTimeOfRotation() -> JulianDay {
        let C = ceil((self.julianDay.value - 2398140.2270)/27.2752316) // Equ 29.1 of AA.
        return JulianDay(KPCAAPhysicalSun_TimeOfStartOfRotation(Int(C)))
    }
    
    // MARK: - Coordinates
    
    /// The radius vector (distance between the Earth and the Sun.
    public var radiusVector: AstronomicalUnit { return Earth(julianDay: self.julianDay, highPrecision: self.highPrecision).radiusVector }
    
    /// The ecliptic coordinates of the Sun
    public var eclipticCoordinates: EclipticCoordinates {
        get { return EclipticCoordinates(lambda: Degree(KPCAASun_GeometricEclipticLongitude(self.julianDay.value, self.highPrecision)),
                                         beta: Degree(KPCAASun_GeometricEclipticLatitude(self.julianDay.value, self.highPrecision)),
                                         epoch: .epochOfTheDate(self.julianDay),
                                         equinox: .meanEquinoxOfTheDate(self.julianDay)) }
    }

    /// The apparent ecliptic coordinates of the Sun.
    public var apparentEclipticCoordinates: EclipticCoordinates {
        get { return EclipticCoordinates(lambda: Degree(KPCAASun_ApparentEclipticLongitude(self.julianDay.value, self.highPrecision)),
                                         beta: Degree(KPCAASun_ApparentEclipticLatitude(self.julianDay.value, self.highPrecision)),
                                         epoch: .epochOfTheDate(self.julianDay),
                                         equinox: .meanEquinoxOfTheDate(self.julianDay)) }
    }

    /// The equatorial coordinates of the Sun
    public var equatorialCoordinates: EquatorialCoordinates {
        get { return self.eclipticCoordinates.makeEquatorialCoordinates() }
    }

    /// The apparent equatorial coordinates of the Sun
    public var apparentEquatorialCoordinates: EquatorialCoordinates {
        get { return self.apparentEclipticCoordinates.makeApparentEquatorialCoordinates() }
    }

    // MARK: - Celestial Body Supplement
    
    /// See AA, p.164. In some instances, for example in meteor work, it is necessary to have the Sun's longitude
    /// referred to the standard equinox of J2000.0. Between, 1900 and 2100, this can be performed with sufficient
    /// accuracy.
    public var eclipticCoordinatesStandardJ2000: EclipticCoordinates {
        get { return EclipticCoordinates(lambda: Degree(KPCAASun_GeometricEclipticLongitudeJ2000(self.julianDay.value, self.highPrecision)),
                                         beta: Degree(KPCAASun_GeometricEclipticLatitudeJ2000(self.julianDay.value, self.highPrecision))) }
    }
    
    /// Computes the apparent horizontal coordinates of the Sun for a given location of the observer.
    ///
    /// - Parameter geographicCoordinates: The location of the observer.
    /// - Returns: A new horizontal coordinates instance.
    public func makeHorizontalCoordinates(with geographicCoordinates: GeographicCoordinates) -> HorizontalCoordinates {
        return self.apparentEquatorialCoordinates.makeHorizontalCoordinates(for: geographicCoordinates, at: self.julianDay)
    }

    // MARK: - Physical Observations of the Sun
    
    /// The position angle of the northern extremity of the axis of rotation,
    /// measured eastwards from the North Point of the solar disk.
    public var positionAngleOfNorthernRotationAxisPoint: Degree {
        get { return Degree(self.physicalDetails.P) }
    }
    
    /// The heliographic latitude of the center of the solar disk. It represents the tilt
    /// of the Sun's north pole toward (+) or away (-) from Earth. It is zero about June 6
    /// and December 7, and reaches a maximum value about March 6 (-7º.25) and September 8
    /// (+7º.25).
    public var heliographicLatitudeOfSolarDiskCenter: Degree {
        get { return Degree(self.physicalDetails.B0) }
    }
    
    /// The heliographic longitude of the center of the solar disk. It decreases by about
    /// 13.2 degrees per day.
    public var heliographicLongitudeOfSolarDiskCenter: Degree {
        get { return Degree(self.physicalDetails.L0) }
    }

    /// A synodic rotation cycle of the Sun begins when the heliographic longitude of the
    /// solar disk center is 0º.
    ///
    /// - Parameter C: The rotation number. C = 1 on November 9, 1853.
    /// - Returns: The julian day of the start of the cycle.
    public static func timeOfStartOfSynodicRotation(rotationNumber C: Int) -> JulianDay {
        return JulianDay(KPCAAPhysicalSun_TimeOfStartOfRotation(C))
    }
    
    // MARK: - Equation of Time
    
    /// Compute the equation of time, that is, the difference between the apparent and the mean time. Or, in other
    /// words, the difference between the hour angle of the true Sun and the mean Sun.
    ///
    /// - returns: The equation of time, in Minute.
    public func equationOfTime() -> Minute {
        // KPCAA result is in minutes of time.
        return Minute(KPCAAEquationOfTime_Calculate(self.julianDay.value, self.highPrecision))
    }
    
    // MARK: - Elliptical (Planetary) Details Supplement
    
    /// AA+ provides computation for so-called elliptical planetary details also for the Sun
    public lazy var planetaryDetails: KPCAAEllipticalPlanetaryDetails = {
        [unowned self] in
        return KPCAAElliptical_CalculatePlanetaryDetails(self.julianDay.value, .SUN_elliptical, self.highPrecision)
        }()
}

