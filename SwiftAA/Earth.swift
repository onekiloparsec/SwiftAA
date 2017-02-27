//
//  Earth.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public enum TwilightSunAltitude: Degree {
    case diskCenterOnGeometricHorizon = 0
    case upperLimbOnGeometricHorizon = -0.25
    case riseAndSet = -0.5833333333333333333333 // -35/60 // diskCenterOnHorizonWithRefraction
    case upperLimbOnHorizonWithRefraction = -0.833
    case civilian = -6.0
    case nautical = -12.0
    case amateurAstronomical = -15.0
    case astronomical = -18.0
}

public enum TwilightError: Error {
    case alwaysBelowAltitude
    case alwaysAboveAltitude
    case accuracyNotReached
}

public class Earth: Object, PlanetaryBase, ElementsOfPlanetaryOrbit {
    public static var color: Color {
        get { return Color(red:0.133, green:0.212, blue:0.290, alpha:1.000) }
    }
    
    public static let equatorialRadius: Meter = 6378140.0
    public static let polarRadius: Meter = 6356760.0

    // Additional methods for Earth to deal with the baryCentric parameter
    func perihelion(_ year: Double, baryCentric: Bool = true) -> JulianDay {
        return JulianDay(KPCAAPlanetPerihelionAphelion_EarthPerihelion(KPCAAPlanetPerihelionAphelion_EarthK(year), baryCentric))
    }
    
    func aphelion(_ year: Double, baryCentric: Bool = true) -> JulianDay {
        return JulianDay(KPCAAPlanetPerihelionAphelion_EarthAphelion(KPCAAPlanetPerihelionAphelion_EarthK(year), baryCentric))
    }
    
    func longitudeOfAscendingNode() -> Degree {
        // There is no method for .MeanEquinoxOfTheDate, hence defaulting to J2000
        return Degree(KPCAAElementsPlanetaryOrbit_LongitudeAscendingNodeJ2000(self.planetStrict, self.julianDay.value))
    }

    /**
     Computes the julian day of the equinox for the given year
     
     - parameter northward: if yes, means the spring equinox for the northern hemisphere.
     if flase, it is the autumn equinox of the northern hemisphere.
     
     - returns: A julian day
     */
    func equinox(_ northward: Bool) -> JulianDay {
        let year = self.julianDay.date.year
        if northward == true {
            return JulianDay(KPCAAEquinoxesAndSolstices_NorthwardEquinox(year, self.highPrecision))
        }
        else {
            return JulianDay(KPCAAEquinoxesAndSolstices_SouthwardEquinox(year, self.highPrecision))
        }
    }
    
    /**
     Computes the julian day of the solstice for the given year
     
     - parameter northern: if true, means the summer solstice in the northern hemisphere,
     if false, means the winter solstice in the norther hemisphere.
     
     - returns: A julian day
     */
    func solstice(_ northern: Bool) -> JulianDay {
        let year = self.julianDay.date.year
        if northern == true {
            return JulianDay(KPCAAEquinoxesAndSolstices_NorthernSolstice(year, self.highPrecision))
        }
        else {
            return JulianDay(KPCAAEquinoxesAndSolstices_SouthernSolstice(year, self.highPrecision))
        }
    }
    
    /**
     Computes the length of a given season.
     
     - parameter season:             The season to compute the length of.
     - parameter northernHemisphere: A flag indicating which hemisphere to consider
     
     - returns: A length in (Julian) Days.
     */
    func lengthOfSeason(_ season: Season, northernHemisphere: Bool) -> Double {
        let year = self.julianDay.date.year
        switch season {
        case .spring:
            return KPCAAEquinoxesAndSolstices_LengthOfSpring(year, northernHemisphere, self.highPrecision)
        case .summer:
            return KPCAAEquinoxesAndSolstices_LengthOfSummer(year, northernHemisphere, self.highPrecision)
        case .autumn:
            return KPCAAEquinoxesAndSolstices_LengthOfAutumn(year, northernHemisphere, self.highPrecision)
        case .winter:
            return KPCAAEquinoxesAndSolstices_LengthOfWinter(year, northernHemisphere, self.highPrecision)
        }
    }
    
    /**
     Computes the hours of twilights
     
     - parameter sunAltitude: The altitude of the Sun below, or at, the horizon. See TwilightSunAltitude enum for default values.
     - parameter coordinates: The coordinates on Earth where the twilights should be computed.
     
     - returns: A tuple containing the julian days of sunrise and sunset, if meaningful, and an error code, in case.
     */
    func twilightsLowAccuracy(forSunAltitude sunAltitude: Degree, coordinates: GeographicCoordinates) -> (rise: JulianDay?, set: JulianDay?, error: TwilightError?) {
        
        // When the Local Sidereal Time equals the Sun's RA, then the Sun is in the south

        // Algorithm is using positive eastward longitude
        let positiveEastwardLongitude = -coordinates.longitude

        /* Compute d of 12h local mean solar time */
        let d = Double(self.julianDay.date.daysSince2000January0()) + 0.5 - positiveEastwardLongitude.value/360.0

        /* Compute the local sidereal time of this moment */
        let siderealTime = (GMST0(day: d) + Degree(180.0) + positiveEastwardLongitude).reduced
                
        /* Compute time when Sun is at south - in hours UT */
        let sun = Sun(julianDay: StandardEpoch_J2000_0 + JulianDay(d))
        let sunRa = sun.equatorialCoordinates.rightAscension.inDegrees.reduced0
        let time_Sun_at_South = Hour(12.0 - ((siderealTime - sunRa).reduced0).value/15.0)
        
        /* Compute the Sun's apparent radius in degrees and do correction to upper limb, if necessary */
        var correctedSunAltitude = sunAltitude
        if sunAltitude == TwilightSunAltitude.riseAndSet.rawValue {
            correctedSunAltitude = sunAltitude - Degree(0.2666 / self.radiusVector.value)
        }
        
        // Compute the diurnal arc that the Sun traverses to reach the specified altitude altit:
        
        let sinAlt = sin(correctedSunAltitude.inRadians.value)
        let sinLat = sin(coordinates.latitude.inRadians.value)
        let sinDec = sin(sun.equatorialCoordinates.declination.inRadians.value)
        let cosLat = cos(coordinates.latitude.inRadians.value)
        let cosDec = cos(sun.equatorialCoordinates.declination.inRadians.value)
        
        let cost = (sinAlt - sinLat * sinDec) / (cosLat * cosDec)
        
        var error: TwilightError? = nil
        var riseDate: Date? = nil
        var setDate: Date? = nil
        
        if (cost >= 1.0 ) {
            error = .alwaysBelowAltitude
        }
        else if (cost <= -1.0) {
            error = .alwaysAboveAltitude
        }
        else {
            let riseHour = time_Sun_at_South - Radian(acos(cost)).inHours
            let setHour  = time_Sun_at_South + Radian(acos(cost)).inHours

            let date = self.julianDay.date
            riseDate = Calendar.gregorianGMT.date(bySettingHour: riseHour, of: date)
            setDate = Calendar.gregorianGMT.date(bySettingHour: setHour, of: date)
        }
        
        return (riseDate?.julianDay, setDate?.julianDay, error)
    }
    
    func twilights(forSunAltitude sunAltitude: Degree, coordinates: GeographicCoordinates) -> (rise: JulianDay?, set: JulianDay?, error: TwilightError?) {
        
        let jd_midnight = self.julianDay.localMidnight(longitude: coordinates.longitude)
        let sun_midnight = Sun(julianDay: jd_midnight)
        if sun_midnight.makeHorizontalCoordinates(with: coordinates).altitude > sunAltitude {
            return (nil, nil, .alwaysAboveAltitude)
        }

        let jd_noon = self.julianDay.localMidnight(longitude: coordinates.longitude) + 0.5
        let sun_noon = Sun(julianDay: jd_noon)
        if sun_noon.makeHorizontalCoordinates(with: coordinates).altitude < sunAltitude {
            return (nil, nil, .alwaysBelowAltitude)
        }

        // Start at noon.
        let jd_start = self.julianDay.midnight + 0.5
        var jd_rise = jd_start
        var jd_set  = jd_start
        
        let accuracy = 1.0.seconds.inDays
        var jd_diff  = 10*accuracy
        
        var security = 0
        while abs(jd_diff) > accuracy && security < 10 {
            security += 1
            
            let ut1 = find_time_Sun_at_South_Schylter(forJulianDay: jd_rise, coordinates: coordinates)
            let ut2 = find_time_Sun_at_South_Schylter(forJulianDay: jd_set, coordinates: coordinates)

            let arc1 = Sun(julianDay: jd_rise).diurnalArcAngle(forObjectAltitude: sunAltitude, coordinates: coordinates)
            let arc2 = Sun(julianDay: jd_set).diurnalArcAngle(forObjectAltitude: sunAltitude, coordinates: coordinates)
            
            if arc1.error != nil || arc2.error != nil {
                security = 10
                break
            }
            
            let new_jd_rise = Calendar.gregorianGMT.date(bySettingHour: ut1 - arc1.value!.inHours, of: jd_rise.date).julianDay
            jd_set = Calendar.gregorianGMT.date(bySettingHour: ut2 + arc2.value!.inHours, of: jd_set.date).julianDay

            jd_diff = new_jd_rise-jd_rise
            jd_rise = new_jd_rise
        }
        
        if security >= 9 {
            return (nil, nil, .accuracyNotReached)
        }
        else {
            return (jd_rise, jd_set, nil)
        }
    }
}

func find_time_Sun_at_South_Schylter(forJulianDay jd: JulianDay, coordinates: GeographicCoordinates) -> Hour {
    let positiveEastwardLongitude = -coordinates.longitude
    let d = Double(jd.date.daysSince2000January0()) + 0.5 - positiveEastwardLongitude.value/360.0
    let siderealTime = (GMST0(day: d) + Degree(180.0) + positiveEastwardLongitude).reduced
    let sun = Sun(julianDay: StandardEpoch_J2000_0 + JulianDay(d))
    let sunRa = sun.equatorialCoordinates.rightAscension.inDegrees.reduced0
    return Hour(12.0 - ((siderealTime - sunRa).reduced0).value/15.04107)
}

func find_time_Sun_at_South_SwiftAA(forJulianDay jd: JulianDay, coordinates: GeographicCoordinates) -> Hour {
    // Somehow, there is a 0.5 day shift (midnight instead of noon) compared to explanations given by Paul Schylter.
    // See http://www.stjarnhimlen.se/comp/riset.html
    // But the values are correct like this.
    let localMidnight = jd.localMidnight(longitude: coordinates.longitude)
    let siderealTime = localMidnight.meanLocalSiderealTime(longitude: coordinates.longitude)
    let sun = Sun(julianDay: localMidnight)
    let sunRa = sun.equatorialCoordinates.rightAscension.inDegrees.reduced0
    return Hour((siderealTime.inDegrees-sunRa).reduced0.value/15.04107)    
}
