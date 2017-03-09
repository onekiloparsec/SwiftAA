//
//  RiseTransitSet.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/12/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

/// The RiseTransitSetTimesDetails struct encompasses all elements of the times of rise, transit and set.
public struct RiseTransitSetTimesDetails {
    public private(set) var isRiseValid: Bool
    public private(set) var riseTime: JulianDay
    public private(set) var isTransitAboveHorizon: Bool
    public private(set) var transitTime: JulianDay
    public private(set) var isSetValid: Bool
    public private(set) var setTime: JulianDay
}


/// Calculate the rise, transit and set times of a celestial body for a given
/// location on Earth.
/// 
/// One must correct the instants of the geometric rise and set of the center
/// of the celestial body by the athomspheric refraction. Because of it, the
/// body is actually below the horizon at the instant of its apparent rise or set.
/// The value of 0º34' is generally adopted for the effect of refraction
/// at the horizon. For the Sun, the calculated times generally refer to the 
/// apparent rise or set of the upper limb of the disk, hence, 0º16'
/// should be added to the semidiameter
///
/// Actually, the amount of refraction changes with air temperature, pressure and
/// the elevation of the observer. A change of temperature from winter to summer
/// can shift the times of sunrise and sunset by about 20 secondes in mid-northern
/// and mid-southern latitudes. Similarly, observing sunrise or sunset over
/// a range of barometric pressures leads to a variation of a dozen seconds in the
/// times. However, in this chapter we shall use a mean value of the atmospheric
/// refraction at the horizon, namely the value of 0º34' mentionned above.
///
/// Notes:
/// The geographic longitude must be expressed postively west from Greenwhich,
/// in degrees.
/// The standard altitude, i.e. the geometric altitude of the center of the body
/// at the time of apparent rising, setting, namely:
/// h0 = -0º34' = 0º.5667 for stars and planets
/// h0 = -0º50' = 0º.8333 for the sun
/// h0 = +0º.125 for the moon
/// Actually, for the moon h0 is not constant. See p.102 of AA.
///
/// - Parameters:
///   - julianDay: the date at which one want to compute the times.
///   - equCoords1: the equatorial coordinates of the body at Date - 1 Day.
///   - equCoords2: the equatorial coordinates of the body at Date.
///   - equCoords3: the equatorial coordinates of the body at Date + 1 Day.
///   - geoCoords: the location on Earth, with its altitude set to the standard one (see above)
/// - Returns: the times of rise, transit and set, with an indication if it is actually valid or not.
public func riseTransitSet(forJulianDay julianDay: JulianDay,
                           equCoords1: EquatorialCoordinates,
                           equCoords2: EquatorialCoordinates,
                           equCoords3: EquatorialCoordinates,
                           geoCoords: GeographicCoordinates,
                           apparentRiseSetAltitude: Degree) -> RiseTransitSetTimesDetails
{
    let details = KPCAARiseTransitSet_Calculate(julianDay.value,
                                                equCoords1.alpha.value,
                                                equCoords1.delta.value,
                                                equCoords2.alpha.value,
                                                equCoords2.delta.value,
                                                equCoords3.alpha.value,
                                                equCoords3.delta.value,
                                                geoCoords.longitude.value,
                                                geoCoords.latitude.value,
                                                apparentRiseSetAltitude.value)
    
    let base = julianDay
    let rise = base + Hour(details.Rise).inJulianDays
    let transit = base + Hour(details.Transit).inJulianDays
    let set = base + Hour(details.Set).inJulianDays
    
    return RiseTransitSetTimesDetails(isRiseValid: details.isRiseValid.boolValue,
                                      riseTime: rise,
                                      isTransitAboveHorizon: details.isTransitAboveHorizon.boolValue,
                                      transitTime: transit,
                                      isSetValid: details.isSetValid.boolValue,
                                      setTime: set)
}


/// Convenient class for storing the Rise, Transit and Set times of a celestial body.
public class RiseTransitSetTimes {
    private lazy var riseTransitSetTimesDetails: RiseTransitSetTimesDetails = {
        [unowned self] in
        let midnight = self.celestialBody.julianDay.localMidnight(timeZone: self.timeZone)
        let hp = self.celestialBody.highPrecision
        
        let celestialBodyType = type(of: self.celestialBody)
        let body1: CelestialBody = celestialBodyType.init(julianDay: midnight-1, highPrecision: hp)
        let body2: CelestialBody = celestialBodyType.init(julianDay: midnight, highPrecision: hp)
        let body3: CelestialBody = celestialBodyType.init(julianDay: midnight+1, highPrecision: hp)
        
        return riseTransitSet(forJulianDay: midnight,
                              equCoords1: body1.apparentEquatorialCoordinates,
                              equCoords2: body2.apparentEquatorialCoordinates,
                              equCoords3: body3.apparentEquatorialCoordinates,
                              geoCoords: self.geographicCoordinates,
                              apparentRiseSetAltitude: self.riseSetAltitude)
    }()
    
    public fileprivate(set) var geographicCoordinates: GeographicCoordinates
    public fileprivate(set) var celestialBody: CelestialBody
    private let riseSetAltitude: Degree
    private let timeZone: TimeZone
    

    /// Returns a new RiseTransitSetTimes object giving access to Rise, Transit and Set times of the provided body.
    ///
    /// - Parameters:
    ///   - celestialBody: The celestialbody for which to compute the times.
    ///   - geographicCoordinates: The geographic coordinates for which to compute the times.
    ///   - riseSetAltitude: The altitude considered for rise and set times.
    required public init(celestialBody: CelestialBody, geographicCoordinates: GeographicCoordinates, timeZone: TimeZone? = nil, riseSetAltitude: Degree? = nil) {
        self.celestialBody = celestialBody
        self.geographicCoordinates = geographicCoordinates
        self.riseSetAltitude = riseSetAltitude ?? celestialBody.apparentRiseSetAltitude
        self.timeZone = timeZone ?? TimeZone(secondsFromGMT: 0)!
    }
    
    /// The rise time of the celestial body, in Julian Day.
    public var riseTime: JulianDay? {
        get { return self.riseTransitSetTimesDetails.isRiseValid ? self.riseTransitSetTimesDetails.riseTime : nil }
    }
    
    /// The transit time of the celestial body, in Julian Day.
    public var transitTime: JulianDay? {
        get { return self.riseTransitSetTimesDetails.isTransitAboveHorizon ? self.riseTransitSetTimesDetails.transitTime : nil }
    }
    
    /// The set time of the celestial body, in Julian Day.
    public var setTime: JulianDay? {
        get { return self.riseTransitSetTimesDetails.isSetValid ? self.riseTransitSetTimesDetails.setTime : nil }
    }
}



