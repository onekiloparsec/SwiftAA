//
//  Moon.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 28/08/16.
//  MIT Licence. See LICENCE file.
//

import Foundation
import ObjCAA

/// AA, Chapter 53 (p.371): The mean period of rotation of the Moon is equal to the 
/// mean sidereal period of revolution around the Earth, and the mean plane of the
/// lunar equator intersects the ecliptic at a constant incliation (see
/// @MeanLunarEquatorInclination) [...].
/// On the average, therefore, the same hemisphere of the Moon is always turned
/// towards the Earth. However, apparent oscillations known as optical librations,
/// which are due to variations in the geometric position of the Earth relative to
/// the lunar surface during the course of the orbital motion of the Moon, allow
/// about 59% of the surface to be observed from tbe Earth.
/// The mean center of the Moon's apparent disk is the origin of the system of 
/// selenographic coordinates on the surface of the Moon [see below].
/// The displacement, at any time, of the mean center of the disk from the apparent
/// center, represents the amount of libration, and is measured by the selenographic
/// coordinates of the apparent center of the disk at that time.
/// AA (p.372): The selenographic longitude and latitude of the Earth, as given
/// in the almanacs, are the geocentric selenographic coordinates of the apparent
/// central point of the disk. At this point on the surface of the Moon,
/// the Earth is in the zenith.
public struct SelenographicCoordinates {
    /// Selenographic longitude are measured from the lunar meridian that passes
    /// through the mean center of the apparent disk, positive in the direction of
    /// towards Mare Crisium, that is towards the west of geocentric celestial
    /// sphere.
    public let longitude: Degree
    
    /// Selenographic latitudes are measured from the lunar equator, positive towards
    /// the north, that is, they are positive in the hemisphere containing
    /// Mare Serenitatis.
    public let latitude: Degree
    
    /// The associated colongitude.
    public var colongitude: Degree {
        get { return (450.0.degrees - self.longitude).reduced }
    }

    /// A Selenographic coordinates centered at the equator and prime meridian.
    public static var zero: SelenographicCoordinates {
        return SelenographicCoordinates(longitude: 0.0.degrees, latitude: 0.0.degrees)
    }

    /// Returns a SelenographicCoordinates object.
    ///
    /// - Parameters:
    ///   - longitude: The longitude.
    ///   - latitude: The latitude
    public init(longitude: Degree, latitude: Degree) {
        self.longitude = longitude
        self.latitude = latitude
    }
}


/// The Earth's Moon.
public class Moon : Object, CelestialBody {
    
    /// Accessor to all values underlying the geocentric physical details. Will probably become private
    /// once all relevant accessors are implemented and covered.
    public fileprivate(set) lazy var geocentricPhysicalDetails: KPCAAPhysicalMoonDetails = {
        [unowned self] in
        return KPCPhysicalMoon_CalculateGeocentric(self.julianDay.value)
        }()

    /// Accessor to all values underlying the selenographic details. Will probably become private
    /// once all relevant accessors are implemented and covered.
    public fileprivate(set) lazy var selenographicDetails: KPCAASelenographicMoonDetails = {
        [unowned self] in
        return KPCPhysicalMoon_SelenographicPositionOfSun(self.julianDay.value, self.highPrecision)
        }()
    
    /// Accessor to all values underlying the eclipse details. Will probably become private
    /// once all relevant accessors are implemented and covered.
    public fileprivate(set) lazy var eclipseDetails: KPCAALunarEclipseDetails = {
        [unowned self] in
        return KPCAAEclipses_CalculateLunar(KPCAAMoonPhases_K(self.julianDay.date.fractionalYear))
        }()

    /// The diameter of the Moon.
    public let diameter: Meter = 3476000.0

    /// The standard/mean apparent altitude for rise and set of the Moon. See AA p.102.
    public static let apparentRiseSetAltitude = Degree(0.125)

    // MARK: - CelestialBody
    
    /// Radius vector of the Moon, that is, its distance from Earth (not Sun).
    /// AA+ uses the Eq. for Delta written in p.342 of AA book.
    /// According to that Eq., the result is in Kilometers. For consistency with others, we return AU.
    public var radiusVector: AstronomicalUnit {
        get { return Meter(self.distance.value*1000.0).inAstronomicalUnits }
    }

    /// Convenience accessor of the Moon distance, that is, its distance from Earth (not Sun), in kilometers.
    public var distance: Kilometer {
        get { return Kilometer(KPCAAMoon_RadiusVector(self.julianDay.value)) }
    }

    /// Horizontal parallax
    public var horizontalParallax: Degree {
        return Degree(KPCAAMoon_RadiusVectorToHorizontalParallax(self.distance.value))
    }

    // MARK: Coordinates
    
    
    /// The apparent ecliptic coordinates of the Moon. In AA p.342, Example 47.a, they are called geocentric longitude
    /// and latitude. But apparent right ascension and declination are derived directly from them using standard
    /// coordinates transformations.
    /// These coordinates are 'apparent' coordinates because they include the effect of nutation in longitude.
    /// It is important to provide the current julian day as epoch to get the right coordinates.
    public var apparentEclipticCoordinates: EclipticCoordinates {
        get {
            let latitude = Degree.init(KPCAAMoon_EclipticLatitude(julianDay.value))
            let longitude = Degree.init(KPCAAMoon_EclipticLongitude(julianDay.value))
            return EclipticCoordinates(lambda: longitude,
                                       beta: latitude,
                                       epoch: .epochOfTheDate(self.julianDay),
                                       equinox: .meanEquinoxOfTheDate(self.julianDay))
        }
    }
    
    /// The apparent equatorial coordinates of the Moon, obtained from the `apparentEclipticCoordinates`.
    public var apparentEquatorialCoordinates: EquatorialCoordinates {
        /// Do not use .makeApparentEquatorialCoordinates as it will over-correct for nutation. 
        get { return self.apparentEclipticCoordinates.makeEquatorialCoordinates() }
    }

    /// The ecliptic coordinates of the Moon. [WARN]: For now, return the apparent ones.
    /// TODO: Is there any other coordinates one could find? Is it meaningful?
    public var eclipticCoordinates: EclipticCoordinates {
        get { return self.apparentEclipticCoordinates }
    }

    /// The equatorial coordinates of the Moon. [WARN]: For now, return the apparent ones.
    /// TODO: Is there any other coordinates one could find? Is it meaningful?
    public var equatorialCoordinates: EquatorialCoordinates {
        get { return self.apparentEquatorialCoordinates }
    }

    // MARK: - Diameters

    /// This is the geocentric semi diameter of the moon, that is for an observer located at the center of the Earth
    public var geocentricSemiDiameter: ArcSecond {
        get { return ArcSecond(KPCAADiameters_GeocentricMoonSemidiameter(self.distance.value)) }
    }
    
    
    /// This is the topocentric semi diameter of the moon, that is for an observer located somewhere on the surface of the Earth.
    ///
    /// - Parameter geographicCoordinates: The location of the observer on Earth. The altitude matters!
    /// - Returns: The topocentric semi diameter of the Moon.
    public func topocentricSemiDiameter(for geographicCoordinates: GeographicCoordinates) -> ArcSecond {
        return ArcSecond(KPCAADiameters_TopocentricMoonSemidiameter(self.distance.value, // Distance from Earth in kilometers, not AU! See AA p.390.
                                                                    self.apparentEquatorialCoordinates.delta.value, // Apparent Declination in Degrees
                                                                    self.hourAngle(for: geographicCoordinates).value, // Hour Angle in Hours
                                                                    geographicCoordinates.latitude.value, // Latitude in Degrees
                                                                    geographicCoordinates.altitude.value)) // Height above see level in meters (see AA p.82)
    }

    // MARK: - KPCAAMoon

    /// The mean longitude of the Moon
    public var meanLongitude: Degree {
        get { return Degree(KPCAAMoon_MeanLongitude(self.julianDay.value)) }
    }

    /// The mean elongation of the Moon
    public var meanElongation: Degree {
        get { return Degree(KPCAAMoon_MeanElongation(self.julianDay.value)) }
    }

    /// The mean anomaly of the moon
    public var meanAnomaly: Degree {
        get { return Degree(KPCAAMoon_MeanAnomaly(self.julianDay.value)) }
    }

    /// The argument of Latitude
    public var argumentOfLatitude: Degree {
        get { return Degree(KPCAAMoon_ArgumentOfLatitude(self.julianDay.value)) }
    }

    /// The longitude of mean perigee
    public var longitudeOfMeanPerigee: Degree {
        get { return Degree(KPCAAMoon_MeanLongitudePerigee(self.julianDay.value)) }
    }
    
    /// The longitude of the mean ascending node
    public var longitudeOfMeanAscendingNode: Degree {
        get { return Degree(KPCAAMoon_MeanLongitudeAscendingNode(self.julianDay.value)) }
    }

    /// The longitude of the true ascending node.
    public var longitudeOfTrueAscendingNode: Degree {
        get { return Degree(KPCAAMoon_TrueLongitudeAscendingNode(self.julianDay.value)) }
    }


    // MARK: - KPCAAMoonPhases

    
    /// Returns the Julian Day of the Moon phase.
    ///
    /// - Parameters:
    ///   - phase: The phase of the moon we are looking for.
    ///   - forward: A boolean indicating whether one wants the result after the input date, or not. Default is forward=true.
    ///   - mean: A boolean indicating one wans the mean or the true (instantaneous) value. Default is mean=true.
    /// - Returns: The Julian Day of the Moon phase.
    public func time(of phase: MoonPhase, forward: Bool = true, mean: Bool = true) -> JulianDay {
        var k = floor(KPCAAMoonPhases_K(self.julianDay.date.fractionalYear))
        switch phase {
        case .newMoon:
            k = k + 0.0
        case .firstQuarter:
            k = k + 0.25
        case .fullMoon:
            k = k + 0.50
        case .lastQuarter: 
            k = k + 0.75
        }
        let preliminary = timeOfPhase(k, isMean: mean)
        let isAfter = preliminary > julianDay
        switch (forward, isAfter) {
        case (true, true), (false, false):
            return preliminary
        case (true, false):
            return timeOfPhase(k+1.0, isMean: mean)
        case (false, true):
            return timeOfPhase(k-1.0, isMean: mean)
        }
    }
    
    fileprivate func timeOfPhase(_ k: Double, isMean: Bool) -> JulianDay {
        return isMean ? JulianDay(KPCAAMoonPhases_MeanPhase(k)) : JulianDay(KPCAAMoonPhases_TruePhase(k))
    }

    // MARK: - KPCAAMoonPhysicalDetails


    /// Computes the optical librations of the Moon. That is the displacement, at any time, of the mean center
    /// of the disk from the apparent center, measured by the selenographic coordinates of the apparent
    /// center of the disk at that time. Optical librations are due to variations of the geometric position
    /// of the Earth relative to the lunar surface during the course of the orbital motion of the Moon.
    ///
    /// - Returns: a new instance of SelenographicCoordinates
    public func geocentricOpticalLibration() -> SelenographicCoordinates {
        return SelenographicCoordinates(longitude: Degree(self.geocentricPhysicalDetails.ldash), latitude: Degree(self.geocentricPhysicalDetails.bdash))
    }

    /// Computes the physical librations of the Moon, which is due to the actual rotational motion of the Moon
    /// about its mean rotation. This is much smaller than the optical libration.
    ///
    /// - Returns: a new instance of SelenographicCoordinates
    public func geocentricPhysicalLibration() -> SelenographicCoordinates {
        return SelenographicCoordinates(longitude: Degree(self.geocentricPhysicalDetails.ldash2), latitude: Degree(self.geocentricPhysicalDetails.bdash2))
    }

    /// Computes the total librations of the Moon, which is the sum of the optical and physical librations.
    ///
    /// - Returns: a new instance of SelenographicCoordinates
    public func geocentricTotalLibration() -> SelenographicCoordinates {
        return SelenographicCoordinates(longitude: Degree(self.geocentricPhysicalDetails.l), latitude: Degree(self.geocentricPhysicalDetails.b))
    }
    
    /// AA (p.375): For precise reduction sof observations, the geocentric values
    /// of the librations and position angle of the axis should be reduced to the
    /// values at the place of the observer on the surface of the Earth. For the 
    /// librations, the differences may reach 1 degree and have important effects
    /// on the limb-contour.
    ///
    /// - Parameter geoCoords: The position of the observer on Earth surface.
    /// - Returns: a new instance of SelenographicCoordinates
    public func topocentricTotalLibration(for geographicCoordinates: GeographicCoordinates) -> SelenographicCoordinates {
        let details = KPCPhysicalMoon_CalculateTopocentric(self.julianDay.value, geographicCoordinates.longitude.value, geographicCoordinates.latitude.value)
        return SelenographicCoordinates(longitude: Degree(details.l), latitude: Degree(details.b))
    }

    /// The position angle of the Moon's axis of rotation
    public var rotationAxisPositionAngle: Degree {
        return Degree(self.geocentricPhysicalDetails.P)
    }
    
    /// AA (p.376): The selenographic coordinates of the Sun determine the regions
    /// of the lunar surface that are illuminated. The coordinates returned are 
    /// those of the subsolar point, that is, the point on the Moon surface
    /// where the Sun is in the zenith.
    public var selenographicPositionOfTheSun: SelenographicCoordinates {
        return SelenographicCoordinates(longitude: Degree(self.selenographicDetails.l0), latitude: Degree(self.selenographicDetails.b0))
    }
    
    /// Computes the altitude of the Sun above the Moon's horizon on a given 
    /// location in the Moon surface.
    ///
    /// - Parameter selCoords: The position on the Moon surface.
    /// - Returns: The altitude of the Sun above the local lunar horizon.
    public func altitudeOfTheSun(for selenographicCoordinates: SelenographicCoordinates) -> Degree {
        return Degree(KPCPhysicalMoon_AltitudeOfSun(self.julianDay.value,
                                                    selenographicCoordinates.longitude.value,
                                                    selenographicCoordinates.latitude.value,
                                                    self.highPrecision))
    }

    /// Computes the time of the sunrise, for a given location in the Moon surface,
    /// taking the center of the Sun apparent disk.
    ///
    /// - Parameter selCoords: The position on the Moon surface.
    /// - Returns: The julian day of the sunrise.
    public func timeOfSunrise(for selenographicCoordinates: SelenographicCoordinates) -> JulianDay {
        return JulianDay(KPCPhysicalMoon_TimeOfSunrise(self.julianDay.value,
                                                       selenographicCoordinates.longitude.value,
                                                       selenographicCoordinates.latitude.value,
                                                       self.highPrecision))
    }

    /// Computes the time of the sunset, for a given location in the Moon surface,
    /// taking the center of the Sun apparent disk.
    ///
    /// - Parameter selCoords: The position on the Moon surface.
    /// - Returns: The julian day of the sunset.
    public func timeOfSunset(for selenographicCoordinates: SelenographicCoordinates) -> JulianDay {
        return JulianDay(KPCPhysicalMoon_TimeOfSunset(self.julianDay.value,
                                                      selenographicCoordinates.longitude.value,
                                                      selenographicCoordinates.latitude.value,
                                                      self.highPrecision))
    }

    
    // MARK: - KPCAAMoonPerigeeApogee
    
    /// Computes the date of the perigee.
    ///
    /// - Parameter mean: If `true`, the mean value is computed. Otherwise, the `true` one...
    /// - Returns: A julian day.
    public func perigee(_ mean: Bool = true) -> JulianDay {
        // See AA p.355 about rounding
        let k = KPCAAMoonPerigeeApogee_K(self.julianDay.date.fractionalYear).rounded()
        if mean {
            return JulianDay(KPCAAMoonPerigeeApogee_MeanPerigee(k))
        }
        else {
            return JulianDay(KPCAAMoonPerigeeApogee_TruePerigee(k))
        }
    }

    /// Computes the date of the apogeee.
    ///
    /// - Parameter mean: If `true`, the mean value is computed. Otherwise, the `true` one...
    /// - Returns: A julian day.
    public func apogee(_ mean: Bool = true) -> JulianDay {
        // See AA p.355 about rounding
        let k = KPCAAMoonPerigeeApogee_K(self.julianDay.date.fractionalYear).rounded()
        let shift = (k < 0) ? -0.5 : 0.5
        if mean {
            return JulianDay(KPCAAMoonPerigeeApogee_MeanApogee(k+shift))
        }
        else {
            return JulianDay(KPCAAMoonPerigeeApogee_TrueApogee(k+shift))

        }
    }
    
    
    /// Computes the parallax of the perigee
    ///
    /// - Returns: The parallax in arcseconds.
    public func perigeeParallax() -> ArcSecond {
        let k = KPCAAMoonPerigeeApogee_K(self.julianDay.date.fractionalYear)
        return Degree(KPCAAMoonPerigeeApogee_PerigeeParallax(k)).inArcSeconds
    }

    /// Computes the parallax of the apogeee
    ///
    /// - Returns: The parallax in arcseconds.
    public func apogeeParallax() -> ArcSecond {
        let k = KPCAAMoonPerigeeApogee_K(self.julianDay.date.fractionalYear)
        return Degree(KPCAAMoonPerigeeApogee_ApogeeParallax(k)).inArcSeconds
    }

    // MARK: - KPCAAMoonMaxDeclinations
 
    /// Compute the date of the maximum declination of the Moon. 
    ///
    /// Computation are geocentric, and they refer to the center of the Moon's disk.
    /// 
    /// The plan of the Moon's orbit forms with the plane of ecliptic an angle of 5º. Therefore, in the sky the Moon
    /// is moving approximatively along the ecliptic, and during each revolution (27 days) it reaches its greatest
    /// northern declination (in Tauris, Gemini or in northern Orion), and two weeks later its greatest southern 
    /// declination (in Sagittarius or in Ophiuchus).
    /// 
    /// Because the lunar orbit forms with the ecliptic an angle of 5º, and the ecliptic an angle of 23º with the 
    /// celestial equator, the extreme declinations of the Moon are between 18º and 28º (North or South), approximately.
    /// When, as in 1987, the ascending node of the lunar orbit is in the vicinity of the the vernal equinox, the Moon
    /// reaches high northern and southern declinations, approximately +28.5º and -28.5º. This situation is repeated
    /// at intervals of 18.6 years, the revolution period of the lunar nodes.
    ///
    /// Note that the word 'mean' is opposed to 'true' in the sense that the former takes into accounnt the
    /// abberration and light-time effects. Since the word 'true' is a reserved word in the Swift programmatic language,
    /// the parameter name must be different, hence the choice of the word 'mean'.
    ///
    /// - parameter mean:       If mean=true, compute the date of the mean greatest dec. Otherwise, compute the... true one.
    /// - parameter northernly: If true, computes the date of the mean greatest dec. for the Earth northern hemisphere.
    ///
    /// - returns: The date of the greatest declination of the Moon
    public func dateOfGreatestDeclination(_ mean: Bool = true, northernly: Bool = true) -> JulianDay {
        let k = KPCAAMoonMaxDeclinations_K(self.julianDay.date.fractionalYear).rounded()
        if mean {
            return JulianDay(KPCAAMoonMaxDeclinations_MeanGreatestDeclination(k, northernly))
        }
        else {
            return JulianDay(KPCAAMoonMaxDeclinations_TrueGreatestDeclination(k, northernly))
        }
    }
    
    /// Compute the value of the maximum declination of the Moon
    ///
    /// - parameter mean:       If mean=true, compute the date of the mean greatest dec. Otherwise, compute the... true one.
    /// - parameter northernly: If true, computes the date of the mean greatest dec. for the Earth northern hemisphere.
    ///
    /// - returns: The greatest declination of the Moon
    public func greatestDeclination(_ mean: Bool = true, northernly: Bool = true) -> Degree {
        let k = KPCAAMoonMaxDeclinations_K(self.julianDay.date.fractionalYear).rounded()
        if mean {
            return Degree(KPCAAMoonMaxDeclinations_MeanGreatestDeclinationValue(k))
        }
        else {
            return Degree(KPCAAMoonMaxDeclinations_TrueGreatestDeclinationValue(k, northernly))
        }
    }

    
    /// Compute the geocentric elongation of the Moon
    ///
    /// - returns: The geocentric elongation of the Moon
    public func geocentricElongation() -> Degree {
        let sun = Sun(julianDay: self.julianDay, highPrecision: self.highPrecision)
        let moonEquatorialCoords = self.eclipticCoordinates.makeEquatorialCoordinates()

        /// Moon coordinates first.
        return Degree(KPCAAMoonIlluminatedFraction_GeocentricElongation(moonEquatorialCoords.alpha.value,
                                                                        moonEquatorialCoords.delta.value,
                                                                        sun.equatorialCoordinates.alpha.value,
                                                                        sun.equatorialCoordinates.delta.value))
    }
    
    /// The phase angle of the Moon
    ///
    /// - returns: The phase angle of the Moon (full moon = 0°, first/last quarter = +90°, new moon = +180°)
    public func phaseAngle() -> Degree {
        let earth = Earth(julianDay: self.julianDay, highPrecision: self.highPrecision)
        
        // Both must be in the same unit
        let moonEarthDistance = self.radiusVector.value
        let earthSunDistance = earth.radiusVector.value // in AU by default
        
        return Degree(KPCAAMoonIlluminatedFraction_PhaseAngle(self.geocentricElongation().value, moonEarthDistance, earthSunDistance))
    }
    
    /// The illuminated fraction of the Moon
    ///
    /// - returns: A number between 0. and 1. representing the illuminated fraction of the Moon
    public func illuminatedFraction() -> Double {
        return KPCAAMoonIlluminatedFraction_IlluminatedFraction(self.phaseAngle().value)
    }
    
    /// The position angle of the Moon's bright limb is the position angle of the midpoint of the illuminated limb of
    /// the Moon, reckoned eastward from the North Point of the disk (not from the axis of rotation of the lunar globe).
    ///
    /// - returns: The position angle of the Moon's bright limb.
    public func positionAngleOfTheBrightLimb() -> Degree {
        let sun = Sun(julianDay: self.julianDay, highPrecision: self.highPrecision)
        let moonEquatorialCoords = self.eclipticCoordinates.makeEquatorialCoordinates()

        /// Sun coordinates first. See AA p. 345
        return Degree(KPCAAMoonIlluminatedFraction_PositionAngle(sun.equatorialCoordinates.alpha.value,
                                                                 sun.equatorialCoordinates.delta.value,
                                                                 moonEquatorialCoords.alpha.value,
                                                                 moonEquatorialCoords.delta.value))
    }
    
    // MARK: - Moon Nodes
    
    
    /// Computes the date of the passage of the Moon through the ascending node.
    ///
    /// - Returns: A julian day.
    public func passageThroughAscendingNode() -> JulianDay {
        let k = KPCAAMoonNodes_K(self.julianDay.date.fractionalYear).rounded()
        return JulianDay(KPCAAMoonNodes_PassageThroNode(k))
    }

    /// Computes the date of the passage of the Moon through the descending node.
    ///
    /// - Returns: A julian day.
    public func passageThroughDescendingNode() -> JulianDay {
        let k = KPCAAMoonNodes_K(self.julianDay.date.fractionalYear).rounded() + 0.5 // See AA p.363.
        return JulianDay(KPCAAMoonNodes_PassageThroNode(k))
    }

    
}


