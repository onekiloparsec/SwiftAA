//
//  Moon.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 28/08/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public class Moon : Object, OrbitingObject {
    public fileprivate(set) var geocentricPhysicalDetails: KPCAAPhysicalMoonDetails
//    public fileprivate(set) var topocentricPhysicalDetails: KPCAAPhysicalMoonDetails
    public fileprivate(set) var selenographicDetails: KPCAASelenographicMoonDetails
    
    public let diameter: Meters = 3476000.0

    public required init(julianDay: JulianDay, highPrecision: Bool = true) {
        self.geocentricPhysicalDetails = KPCPhysicalMoon_CalculateGeocentric(julianDay)
        self.selenographicDetails = KPCPhysicalMoon_SelenographicPositionOfSun(julianDay, highPrecision)
        super.init(julianDay: julianDay, highPrecision: highPrecision)
    }
        
    // MARK: - OrbitingObject
    
    public var eclipticLongitude: Degrees {
        get { return KPCAAMoon_EclipticLongitude(self.julianDay) }
    }
    
    public var eclipticLatitude: Degrees {
        get { return KPCAAMoon_EclipticLatitude(self.julianDay) }
    }
    
    public var eclipticCoordinates: EclipticCoordinates {
        get {
            // To compute the _apparent_ RA and Dec, the true obliquity must be used.
            let epsilon = obliquityOfEcliptic(julianDay: self.julianDay, mean: false)
            return EclipticCoordinates(lambda: self.eclipticLongitude.Hours, beta: self.eclipticLatitude, epsilon: epsilon)
        }
    }
    
    /// Radius vector of the Moon, that is, its distance from Earth.
    /// AA+ uses the Eq. for Delta written in p.342 of AA book.
    /// According to that Eq., the result is in Kilometers!
    public var radiusVector: Meters {
        get { return KPCAAMoon_RadiusVector(self.julianDay)*1000.0 }
    }
    
    // MARK: - KPCAAMoon

    public var meanLongitude: Degrees {
        get { return KPCAAMoon_MeanLongitude(self.julianDay) }
    }

    public var meanElongation: Degrees {
        get { return KPCAAMoon_MeanElongation(self.julianDay) }
    }

    public var meanAnomaly: Degrees {
        get { return KPCAAMoon_MeanAnomaly(self.julianDay) }
    }

    public var argumentOfLatitude: Degrees {
        get { return KPCAAMoon_ArgumentOfLatitude(self.julianDay) }
    }

    public var meanLongitudeOfPerigee: Degrees {
        get { return KPCAAMoon_MeanLongitudePerigee(self.julianDay) }
    }

    public func longitudeOfAscendingNode(_ mean: Bool = true) -> Degrees {
        if mean {
            return KPCAAMoon_MeanLongitudeAscendingNode(self.julianDay)
        }
        else {
            return KPCAAMoon_TrueLongitudeAscendingNode(self.julianDay)
        }
    }

    // MARK: - Static Methods
    
    static func horizontalParallax(fromRadiusVector radiusVector: AU) -> Degrees {
        return KPCAAMoon_RadiusVectorToHorizontalParallax(radiusVector)
    }
    
    static func radiusVector(fromHorizontalParallax parallax: Degrees) -> AU {
        return KPCAAMoon_HorizontalParallaxToRadiusVector(parallax)
    }
    
    // MARK: - KPCAAMoonPhases

    func timeOfPhase(forPhase ph: MoonPhase, mean: Bool = true) -> JulianDay {
        var k = round(KPCAAMoonPhases_K(self.julianDay.date().fractionalYear))
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
        return mean ? KPCAAMoonPhases_MeanPhase(k) : KPCAAMoonPhases_TruePhase(k)
    }

    // MARK: - KPCAAMoonPhysicalDetails

    // TODO: Complete PhysicalMoon details APIs
    
    // MARK: - KPCAAMoonPerigeeApogee

    // TODO: Check Apogee Perigee Units
    
    public func perigee(_ mean: Bool = true) -> Double {
        let k = KPCAAMoonPerigeeApogee_K(self.julianDay.date().fractionalYear)
        if mean {
            return KPCAAMoonPerigeeApogee_MeanPerigee(k)
        }
        else {
            return KPCAAMoonPerigeeApogee_TruePerigee(k)
        }
    }

    public func apogee(_ mean: Bool = true) -> Double {
        let k = KPCAAMoonPerigeeApogee_K(self.julianDay.date().fractionalYear)
        if mean {
            return KPCAAMoonPerigeeApogee_MeanApogee(k)
        }
        else {
            return KPCAAMoonPerigeeApogee_TrueApogee(k)

        }
    }
    
    public func perigeeParallax() -> Double {
        let k = KPCAAMoonPerigeeApogee_K(self.julianDay.date().fractionalYear)
        return KPCAAMoonPerigeeApogee_PerigeeParallax(k)
    }

    public func apogeeParallax() -> Double {
        let k = KPCAAMoonPerigeeApogee_K(self.julianDay.date().fractionalYear)
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
        let k = KPCAAMoonMaxDeclinations_K(self.julianDay.date().fractionalYear)
        if mean {
            return KPCAAMoonMaxDeclinations_MeanGreatestDeclination(k, northernly)
        }
        else {
            return KPCAAMoonMaxDeclinations_TrueGreatestDeclination(k, northernly)
        }
    }
    
    /// Compute the value of the maximum declination of the Moon
    ///
    /// - parameter mean:       If mean=true, compute the date of the mean greatest dec. Otherwise, compute the... true one.
    /// - parameter northernly: If true, computes the date of the mean greatest dec. for the Earth northern hemisphere.
    ///
    /// - returns: The greatest declination of the Moon
    public func greatestDeclination(_ mean: Bool = true, northernly: Bool = true) -> Degrees {
        let k = KPCAAMoonMaxDeclinations_K(self.julianDay.date().fractionalYear)
        if mean {
            return KPCAAMoonMaxDeclinations_MeanGreatestDeclinationValue(k)
        }
        else {
            return KPCAAMoonMaxDeclinations_TrueGreatestDeclinationValue(k, northernly)
        }
    }

    
    /// Compute the geocentric elongation of the Moon
    ///
    /// - returns: The geocentric elongation of the Moon
    public func geocentricElongation() -> Degrees {
        let sun = Sun(julianDay: self.julianDay, highPrecision: self.highPrecision)
        let sunEquatorialCoords = sun.eclipticCoordinates().toEquatorialCoordinates()
        let moonEquatorialCoords = self.eclipticCoordinates.toEquatorialCoordinates()

        return KPCAAMoonIlluminatedFraction_GeocentricElongation(moonEquatorialCoords.alpha,
                                                                 moonEquatorialCoords.delta,
                                                                 sunEquatorialCoords.alpha,
                                                                 sunEquatorialCoords.delta)
    }
    
    /// The phase angle of the Moon
    ///
    /// - returns: The phase angle of the Moon
    public func phaseAngle() -> Degrees {
        let earth = Earth(julianDay: self.julianDay, highPrecision: self.highPrecision)
        
        // Both must be in the same unit
        let moonEarthDistance = self.radiusVector.AU
        let earthSunDistance = earth.radiusVector // in AU by default
        
        return KPCAAMoonIlluminatedFraction_PhaseAngle(self.geocentricElongation(), moonEarthDistance, earthSunDistance)
    }
    
    /// The illuminated fraction of the Moon
    ///
    /// - returns: A number between 0. and 1. representing the illuminated fraction of the Moon
    public func illuminatedFraction() -> Double {
        return KPCAAMoonIlluminatedFraction_IlluminatedFraction(self.phaseAngle())
    }
    
    /// The position angle of the Moon's bright limb is the position angle of the midpoint of the illuminated limb of
    /// the Moon, reckoned eastward from the North Point of the disk (not from the axis of rotation of the lunar globe).
    ///
    /// - returns: The position angle of the Moon's bright limb.
    public func positionAngleOfTheBrightLimb() -> Degrees {
        let sun = Sun(julianDay: self.julianDay, highPrecision: self.highPrecision)
        let sunEquatorialCoords = sun.eclipticCoordinates().toEquatorialCoordinates()
        let moonEquatorialCoords = self.eclipticCoordinates.toEquatorialCoordinates()

        return KPCAAMoonIlluminatedFraction_PositionAngle(sunEquatorialCoords.alpha,
                                                          sunEquatorialCoords.delta,
                                                          moonEquatorialCoords.alpha,
                                                          moonEquatorialCoords.delta)
    }
}


