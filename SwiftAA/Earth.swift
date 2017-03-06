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

public class Earth: Object, PlanetaryBase, ElementsOfPlanetaryOrbit {
    public static var color: Color {
        get { return Color(red:0.133, green:0.212, blue:0.290, alpha:1.000) }
    }
    
    public static let equatorialRadius: Meter = 6378140.0
    public static let polarRadius: Meter = 6356760.0

    // Additional methods for Earth to deal with the baryCentric parameter
    
    /// The Julian Day of the perihelion of the Earth-Moon system. See AA p273.
    var barycentricPerihelion: JulianDay {
        get { return JulianDay(KPCAAPlanetPerihelionAphelion_EarthPerihelion(KPCAAPlanetPerihelionAphelion_EarthK(self.julianDay.date.fractionalYear), true)) }
    }
    
    /// The Julian Day of the aphelion of the Earth-Moon system. See AA p273.
    var barycentricAphelion: JulianDay {
        get { return JulianDay(KPCAAPlanetPerihelionAphelion_EarthAphelion(KPCAAPlanetPerihelionAphelion_EarthK(self.julianDay.date.fractionalYear), true)) }
    }
    
    /// The longitude of the ascnending node.
    var longitudeOfAscendingNode: Degree {
        get { return Degree(KPCAAElementsPlanetaryOrbit_LongitudeAscendingNodeJ2000(self.planetStrict, self.julianDay.value)) }
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
    func lengthOfSeason(_ season: Season, northernHemisphere: Bool) -> Day {
        let year = self.julianDay.date.year
        switch season {
        case .spring:
            return Day(KPCAAEquinoxesAndSolstices_LengthOfSpring(year, northernHemisphere, self.highPrecision))
        case .summer:
            return Day(KPCAAEquinoxesAndSolstices_LengthOfSummer(year, northernHemisphere, self.highPrecision))
        case .autumn:
            return Day(KPCAAEquinoxesAndSolstices_LengthOfAutumn(year, northernHemisphere, self.highPrecision))
        case .winter:
            return Day(KPCAAEquinoxesAndSolstices_LengthOfWinter(year, northernHemisphere, self.highPrecision))
        }
    }
    
    /// Returns the times of twilights (including transit time).
    ///
    /// - Parameters:
    ///   - sunAltitude: The sun altitude to consider. See TwilightSunAltitude for known values.
    ///   - coordinates: The geographic coordinates for which to compute the twilights.
    /// - Returns: The rise, transit and set times, in Julian Day, and an error, if relevant.
    func twilights(forSunAltitude sunAltitude: Degree, coordinates: GeographicCoordinates) -> (rise: JulianDay?, transit: JulianDay?, set: JulianDay?, error: CelestialBodyTransitError?) {
        
        var error: CelestialBodyTransitError? = nil
        
        let jd_midnight = self.julianDay.localMidnight(longitude: coordinates.longitude)
        let sun_midnight = Sun(julianDay: jd_midnight)
        if sun_midnight.makeHorizontalCoordinates(with: coordinates).altitude > sunAltitude {
            error = .alwaysAboveAltitude
        }

        let jd_noon = self.julianDay.localMidnight(longitude: coordinates.longitude) + 0.5
        let sun_noon = Sun(julianDay: jd_noon)
        if sun_noon.makeHorizontalCoordinates(with: coordinates).altitude < sunAltitude {
            error = .alwaysBelowAltitude
        }

        let sun = Sun(julianDay: self.julianDay)
        let times = RiseTransitSetTimes(celestialBody: sun, geographicCoordinates: coordinates, riseSetAltitude: sunAltitude)
        return (times.riseTime, times.transitTime, times.setTime, error)
    }
    
    
    /// Returns the rise, transit and set times for a given planet, as seen from Earth. That is, the equivalent
    /// of Sun twilights, but for planets.
    ///
    /// - Parameters:
    ///   - planet: The considered planet. Cannot be the Earth.
    ///   - coordinates: The geographic coordinates for which to compute the twilights.
    /// - Returns: The rise, transit and set times, in Julian Day, and an error, if relevant.
    func riseTransitSetTimes(for planetaryObject: KPCPlanetaryObject, coordinates: GeographicCoordinates) -> (rise: JulianDay?, transit: JulianDay?, set: JulianDay?, error: CelestialBodyTransitError?) {
        guard planetaryObject != .UNDEFINED else {
            return (nil, nil, nil, nil)
        }
        
        let planetaryObject = planetaryObject.objectType!.init(julianDay: self.julianDay)
        
        let times = RiseTransitSetTimes(celestialBody: planetaryObject as CelestialBody,
                                        geographicCoordinates: coordinates,
                                        riseSetAltitude: TwilightSunAltitude.diskCenterOnGeometricHorizon.rawValue)
        
        return (times.riseTime, times.transitTime, times.setTime, nil)
    }
}

