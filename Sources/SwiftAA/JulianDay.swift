//
//  JulianDay.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 26/06/16.
//  MIT Licence. See LICENCE file.
//

import Foundation
import ObjCAA

/// The Julian Day is a continuous count of days and fractions thereof from the beginning of the year -4712.
/// By tradition, the Julian Day begins at Greenwhich mean noon, that is, at 12h Universal Time.
/// Julian Day structs conform to SwiftAA Numeric type protocol.
public struct JulianDay: NumericType, CustomStringConvertible {
    
    /// The Julian Day value
    public let value: Double
    
    /// Creates a Julian Day initialized to contain the given value.
    ///
    /// - Parameter value: The value for the new Julian Day.
    public init(_ value: Double) {
        self.value = value
    }
    
    /// Creates a Julian Day initialized from a given Gregorian calendar date, in the UT reference frame,
    /// provided by its date components. Hour, minute and second are optional (and set to 0 by default).
    ///
    /// - Parameters:
    ///   - year: The year of the date.
    ///   - month: The month of the date (january = 1)
    ///   - day: The day of the date
    ///   - hour: The hour of the date
    ///   - minute: The minute of the date
    ///   - second: The second of the date. Precision goes to the nanosecond.
    public init(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Double = 0.0) {
        let aaDate = KPCAADate(year: year, month: month, day: Double(day), hour: Double(hour), minute: Double(minute), second: second, usingGregorianCalendar: true)!
        self.init(aaDate.julian())
    }
    
    /// Returns a Julian Day struct initialized from a given Gregorian calendar date, in the UT reference frame,
    /// provided as a Date instance.
    ///
    /// - Parameter date: The date object.
    public init(_ date: Date) {
        let components = Calendar.gregorianGMT.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: date)
        let decimalSeconds = Double(components.second!) + Double(components.nanosecond!)/1e9
        self.init(year: components.year!, month: components.month!, day: components.day!, hour: components.hour!, minute: components.minute!, second: decimalSeconds)
    }
    
    /// Returns a Julian Day struct initialized from a Modified Julian Day (MJD) value.
    ///
    /// - Parameter modified: The Modified Julian Day value.
    public init(modified: Double) {
        self.init(modified + ModifiedJulianDayZero)
    }
}

public extension JulianDay {
    /// Returns a new Date object, in the Gregorian calendar, corresponding to the Julian Day value.
    var date: Date {
        let aaDate = KPCAADate(julianDay: value, usingGregorianCalendar: true)!
        let decimalSeconds = aaDate.second()
        let roundedSeconds = decimalSeconds.rounded(.towardZero)
        let nanoseconds = (decimalSeconds - roundedSeconds) * 1e9
        let components = DateComponents(year: aaDate.year(),
                                        month: aaDate.month(), 
                                        day: aaDate.day(),
                                        hour: aaDate.hour(),
                                        minute: aaDate.minute(),
                                        second: Int(roundedSeconds),
                                        nanosecond: Int(nanoseconds))
        
        let date = Calendar.gregorianGMT.date(from: components)!
        return date
    }
    
    /// Returns the so-called Modified Julian Day corresponding to the Julian Day value.
    /// Contrary to the JD, the Modified Julian Day begins at Greenwhich mean midnight.
    /// It is equal to JD - 2400 000.5
    var modified: Double {
        get { return self.value - ModifiedJulianDayZero }
    }
    
    /// Returns the Julian Day corresponding to the Greenwhich midnight before the actual value.
    var midnight: JulianDay { return JulianDay((value - 0.5).rounded(.down) + 0.5) }
    
    /// Returns the Julian Day corresponding to the geometric midnight local to a given Earth longitude,
    /// before the actual value. It is a direct function of the longitude, and makes no reference to time zone whatsoever.
    /// Once transformed to a Date object, it will most probably not corresponds to the normal "midnight" date & hour,
    /// since the latter is identical by convention on a given timezone. The local date however is always respected
    /// (since you may cross the new-date line depending on longitude).
    ///
    /// - Parameter longitude: The observer longitude
    /// - Returns:  Julian Day instance.
    func localMidnight(longitude: Degree) -> JulianDay {
        var shift = 0.0
        if longitude.inHours.value > self.date.fractionalHour { shift = -1.0 }
        else if longitude.inHours.value+12.0 < -self.date.fractionalHour { shift = +1.0 }
        return self.midnight.date.addingTimeInterval(longitude.inHours.inSeconds.value).julianDay + JulianDay(shift)
    }
    
    /// Returns the Julian Day corresponding to the local midnight, based on timezone.
    ///
    /// - Parameter timeZone: The time zone.
    /// - Returns: A Julian Day object
    func localMidnight(timeZone: TimeZone) -> JulianDay {
        let offsetFromGMT = JulianDay(Double(timeZone.secondsFromGMT(for: self.date)) / (60*60*24))
        return (self + offsetFromGMT).midnight - offsetFromGMT
    }

    /// Computes the mean sidereal time for the Greenwich meridian.
    ///
    /// That is, the Greenwich hour angle of the mean vernal point (the intersection of the ecliptic
    /// of the date with the mean equator of the date).
    ///
    /// - Returns: The sidereal time in hours.
    func meanGreenwichSiderealTime() -> Hour {
        return Hour(KPCAASidereal_MeanGreenwichSiderealTime(self.value))
    }
    
    /// Computes the mean sidereal time for a given longitude on Earth.
    ///
    /// - Parameter longitude: Positively Westward (see AA p. 93 for explanations).
    ///             Basically: this is the contrary of IAU decision. But this orientation is consistent
    ///             with longitude orientation in all other planets!
    /// - Returns: The sidereal time in hours.
    func meanLocalSiderealTime(longitude: Degree) -> Hour {
        return self.meanGreenwichSiderealTime() - longitude.inHours
    }
    
    /// Computes the apparent sidereal time.
    ///
    /// That is, the Greenwich hour angle of the true vernal equinox, obtained by adding a correction
    /// that depends on the nutation in longitude, and the true obliquity of the ecliptic.
    ///
    /// - Returns: The sidereal time in hours.
    func apparentGreenwichSiderealTime() -> Hour {
        return Hour(KPCAASidereal_ApparentGreenwichSiderealTime(self.value))
    }
    
    // Obliquity
    
    /// Obliquity of the ecliptic, that is, the angle between the ecliptic and the celestial equator.
    ///
    /// - Parameter mean: If true, compute the mean obliquity. Otherwise, compute the true obliquity.
    /// - Returns: The obliquity of the ecliptic, in degrees.
    func obliquityOfEcliptic(mean: Bool = true) -> Degree {
        return Degree(KPCAANutation_ObliquityOfEcliptic(mean, self.value))
    }
    
    // MARK: Dynamical Times
    
    /// Returns the difference bewteeen TD (the 'Time Dynamical'), and UT (the Universal Time).
    /// TD was later renamed TT for Terrestrial Time (which is a fairly unfortunate naming...).
    ///
    /// - Returns: The number of seconds (and fraction of thereof) between TD and UT.
    func deltaT() -> Second {
        return Second(KPCAADynamicalTime_DeltaT(self.value))
    }
    
    /// Return the total of leap seconds added to the UTC since their introduction in 1972. 
    /// See here http://tycho.usno.navy.mil/leapsec.html for a thorough explanation.
    ///
    /// - Returns: The total number of leap seconds accumulated since their introduction until the given JD.
    func cumulativeLeapSeconds() -> Second {
        return Second(KPCAADynamicalTime_CumulativeLeapSeconds(self.value))
    }
    
    /// Transform a Terrestrial Time (TT) value in a UTC (Coordinated Universal Time) one. UTC differs from 
    /// TAI by an integral number of seconds. UTC is kept within 0.9 seconds of UT1 by the introduction of 
    /// one-second steps to UTC, the "leap second." To date these steps have always been positive.
    /// See AA p.77- and http://tycho.usno.navy.mil/systime.html
    ///
    /// - Returns: A new julian day
    func TTtoUTC() -> JulianDay {
        return JulianDay(KPCAADynamicalTime_TT2UTC(self.value))
    }

    /// Transform a UTC (Universal Time Coordinates) value in a Terrestrial Time (TT) one. UTC differs from
    /// TAI by an integral number of seconds. UTC is kept within 0.9 seconds of UT1 by the introduction of
    /// one-second steps to UTC, the "leap second." To date these steps have always been positive
    /// See AA p.77- and http://tycho.usno.navy.mil/systime.html
    ///
    /// - Returns: A new julian day
    func UTCtoTT() -> JulianDay {
        return JulianDay(KPCAADynamicalTime_UTC2TT(self.value))
    }

    /// Transform a Terrestrial Time (TT) value in a TAI one. TAI is the International Atomic Time scale, 
    /// a statistical timescale based on a large number of atomic clocks
    /// See AA p.77- and http://tycho.usno.navy.mil/systime.html
    ///
    /// - Returns: A new julian day
    func TTtoTAI() -> JulianDay {
        return JulianDay(KPCAADynamicalTime_TT2TAI(self.value))
    }

    /// Transform a TAI value to a Terrestrial Time (TT) one. TAI is the International Atomic Time scale,
    /// a statistical timescale based on a large number of atomic clocks
    /// See AA p.77- and http://tycho.usno.navy.mil/systime.html
    ///
    /// - Returns: A new julian day
    func TAItoTT() -> JulianDay {
        return JulianDay(KPCAADynamicalTime_TAI2TT(self.value))
    }

    /// Transform a Terrestrial Time (TT) value in a UT1 one. Universal Time (UT) is counted from 0 hours at midnight, 
    /// with unit of duration the mean solar day, defined to be as uniform as possible despite variations in the 
    /// rotation of the Earth. UT0 is the rotational time of a particular place of observation. It is observed as 
    /// the diurnal motion of stars or extraterrestrial radio sources. UT1 is computed by correcting UT0 for the effect 
    /// of polar motion on the longitude of the observing site. It varies from uniformity because of the irregularities 
    /// in the Earth's rotation.
    /// See AA p.77- and http://tycho.usno.navy.mil/systime.html
    ///
    /// - Returns: A new julian day
    func TTtoUT1() -> JulianDay {
        return JulianDay(KPCAADynamicalTime_TT2UT1(self.value))
    }

    /// Transform a UT1 value in a Terrestrial Time (TT) one. Universal Time (UT) is counted from 0 hours at midnight,
    /// with unit of duration the mean solar day, defined to be as uniform as possible despite variations in the
    /// rotation of the Earth. UT0 is the rotational time of a particular place of observation. It is observed as
    /// the diurnal motion of stars or extraterrestrial radio sources. UT1 is computed by correcting UT0 for the effect
    /// of polar motion on the longitude of the observing site. It varies from uniformity because of the irregularities
    /// in the Earth's rotation.
    /// See AA p.77- and http://tycho.usno.navy.mil/systime.html
    ///
    /// - Returns: A new julian day
    func UT1toTT() -> JulianDay {
        return JulianDay(KPCAADynamicalTime_UT12TT(self.value))
    }

    /// Computes the difference between UT1 and UTC. Not to be confused with Delta T.
    /// See AA p.77- and http://tycho.usno.navy.mil/systime.html
    ///
    /// - Returns: A difference in Seconds.
    func UT1minusUTC() -> Second {
        return Second(KPCAADynamicalTime_UT1MinusUTC(self.value))
    }
    
    /// The description of the Julian Day.
    var description: String {
        switch self {
        case StandardEpoch_J2000_0: return "J2000.0"
        case StandardEpoch_B1950_0: return "B1950.0"
        default: return String(format: "JD %.2f", value)
        }
    }
}


