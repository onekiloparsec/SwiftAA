//
//  Moon.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 28/08/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

/// The Earth's Moon object.
public class Moon : Object, CelestialBody {
//    public fileprivate(set) var topocentricPhysicalDetails: KPCAAPhysicalMoonDetails
    
    public fileprivate(set) lazy var geocentricPhysicalDetails: KPCAAPhysicalMoonDetails = {
        [unowned self] in
        return KPCPhysicalMoon_CalculateGeocentric(self.julianDay.value)
        }()
    
    public fileprivate(set) lazy var selenographicDetails: KPCAASelenographicMoonDetails = {
        [unowned self] in
        return KPCPhysicalMoon_SelenographicPositionOfSun(self.julianDay.value, self.highPrecision)
        }()
    
    public fileprivate(set) lazy var eclipseDetails: KPCAALunarEclipseDetails = {
        [unowned self] in
        return KPCAAEclipses_CalculateLunar(KPCAAMoonPhases_K(self.julianDay.date.fractionalYear))
        }()

    /// The diameter of the Moon.
    public let diameter: Meter = 3476000.0
        
    // MARK: - CelestialBody
    
    /// Radius vector of the Moon, that is, its distance from Earth.
    /// AA+ uses the Eq. for Delta written in p.342 of AA book.
    /// According to that Eq., the result is in Kilometers. For consistency with others, we return AU.
    public var radiusVector: AstronomicalUnit {
        get { return Meter(KPCAAMoon_RadiusVector(self.julianDay.value)*1000.0).AU }
    }

    public var eclipticCoordinates: EclipticCoordinates {
        get {
            let latitude = Degree.init(KPCAAMoon_EclipticLatitude(julianDay.value))
            let longitude = Degree.init(KPCAAMoon_EclipticLongitude(julianDay.value))
            return EclipticCoordinates(lambda: longitude, beta: latitude)
        }
    }
    
    public var apparentEclipticCoordinates: EclipticCoordinates {
        get { return self.eclipticCoordinates }
    }
    
    public var equatorialCoordinates: EquatorialCoordinates {
        get { return self.eclipticCoordinates.makeEquatorialCoordinates() }
    }
    
    public var apparentEquatorialCoordinates: EquatorialCoordinates {
        get { return self.eclipticCoordinates.makeApparentEquatorialCoordinates() }
    }

    /// This is the geocentric semi diameter of the moon, that is for an observer located at the center of the Earth
    public var equatorialSemiDiameter: Degree {
        get { return Degree(KPCAADiameters_GeocentricMoonSemidiameter(self.radiusVector.value)) }
    }
    
    /// This is the geocentric semi diameter of the moon, that is for an observer located at the center of the Earth
    public var polarSemiDiameter: Degree {
        get { return Degree(KPCAADiameters_GeocentricMoonSemidiameter(self.radiusVector.value)) }
    }

    // TODO: add topocentric semi diameters
    

    // MARK: - KPCAAMoon

    public var meanLongitude: Degree {
        get { return Degree(KPCAAMoon_MeanLongitude(self.julianDay.value)) }
    }

    public var meanElongation: Degree {
        get { return Degree(KPCAAMoon_MeanElongation(self.julianDay.value)) }
    }

    public var meanAnomaly: Degree {
        get { return Degree(KPCAAMoon_MeanAnomaly(self.julianDay.value)) }
    }

    public var argumentOfLatitude: Degree {
        get { return Degree(KPCAAMoon_ArgumentOfLatitude(self.julianDay.value)) }
    }

    public var meanLongitudeOfPerigee: Degree {
        get { return Degree(KPCAAMoon_MeanLongitudePerigee(self.julianDay.value)) }
    }

    public func longitudeOfAscendingNode(_ mean: Bool = true) -> Degree {
        if mean {
            return Degree(KPCAAMoon_MeanLongitudeAscendingNode(self.julianDay.value))
        }
        else {
            return Degree(KPCAAMoon_TrueLongitudeAscendingNode(self.julianDay.value))
        }
    }

    // MARK: - Static Methods
    
    static func horizontalParallax(fromRadiusVector radiusVector: AstronomicalUnit) -> Degree {
        return Degree(KPCAAMoon_RadiusVectorToHorizontalParallax(radiusVector.value))
    }
    
    static func radiusVector(fromHorizontalParallax parallax: Degree) -> AstronomicalUnit {
        return AstronomicalUnit(KPCAAMoon_HorizontalParallaxToRadiusVector(parallax.value))
    }
    
    // MARK: - KPCAAMoonPhases

    
    /// Returns the Julian Day of the Moon phase.
    ///
    /// - Parameters:
    ///   - ph: The phase of the moon we are looking for.
    ///   - isNext: A boolean indicating whether one wants the result after the input date, or not.
    ///   - mean: A boolean indicating one wans the mean or the true (instantaneous) value. Default is mean=true.
    /// - Returns: The Julian Day of the Moon phase.
    public func timeOfPhase(forPhase ph: MoonPhase, isNext: Bool = true, mean: Bool = true) -> JulianDay {
        var k = round(KPCAAMoonPhases_K(self.julianDay.date.fractionalYear))
        switch ph {
        case .new:
            k = k + 0.0
        case .firstQuarter:
            k = k + 0.25
        case .full:
            k = k + 0.50
        case .lastQuarter: 
            k = k + 0.75
        }
        let preliminary = timeOfPhase(k, isMean: mean)
        let isActuallyNext = preliminary > julianDay
        switch (isNext, isActuallyNext) {
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

    // TODO: Complete PhysicalMoon details APIs
    
    // MARK: - KPCAAMoonPerigeeApogee

    // TODO: Check Apogee Perigee Units
    
    public func perigee(_ mean: Bool = true) -> Double {
        let k = KPCAAMoonPerigeeApogee_K(self.julianDay.date.fractionalYear)
        if mean {
            return KPCAAMoonPerigeeApogee_MeanPerigee(k)
        }
        else {
            return KPCAAMoonPerigeeApogee_TruePerigee(k)
        }
    }

    public func apogee(_ mean: Bool = true) -> Double {
        let k = KPCAAMoonPerigeeApogee_K(self.julianDay.date.fractionalYear)
        if mean {
            return KPCAAMoonPerigeeApogee_MeanApogee(k)
        }
        else {
            return KPCAAMoonPerigeeApogee_TrueApogee(k)

        }
    }
    
    public func perigeeParallax() -> Double {
        let k = KPCAAMoonPerigeeApogee_K(self.julianDay.date.fractionalYear)
        return KPCAAMoonPerigeeApogee_PerigeeParallax(k)
    }

    public func apogeeParallax() -> Double {
        let k = KPCAAMoonPerigeeApogee_K(self.julianDay.date.fractionalYear)
        return KPCAAMoonPerigeeApogee_ApogeeParallax(k)
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
        let k = KPCAAMoonMaxDeclinations_K(self.julianDay.date.fractionalYear)
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
        let k = KPCAAMoonMaxDeclinations_K(self.julianDay.date.fractionalYear)
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
    
    // TODO: Check Units

    public func passageThroughNode() -> Double {
        let k = KPCAAMoonNodes_K(self.julianDay.date.fractionalYear)
        return KPCAAMoonNodes_PassageThroNode(k)
    }
    
    public static let apparentRiseSetAltitude = Degree(0.125) // Mean value, see AA p.102
    
}


