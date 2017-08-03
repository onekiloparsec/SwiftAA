//
//  JulianDay.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 26/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation


/// The Julian Day is a continuous count of days and fractions thereof from the beginning of the year -4712.
/// By tradition, the Julian Day begins at Greenwhich mean noon, that is, at 12h Universal Time.
/// Julian Day structs conform to SwiftAA Numeric type protocol.
public struct JulianDay: NumericType {
    
    public static func +(lhs: JulianDay, rhs: JulianDay) -> JulianDay {
        return JulianDay(lhs.value + rhs.value)
    }
    
    public static func +=(lhs: inout JulianDay, rhs: JulianDay) {
        lhs.value = rhs.value + lhs.value
    }
    
    public static func -(lhs: JulianDay, rhs: JulianDay) -> JulianDay {
        return JulianDay(lhs.value - rhs.value)
    }
    
    public static func -=(lhs: inout JulianDay, rhs: JulianDay) {
        lhs.value = rhs.value - lhs.value
    }
    
    public static func *(lhs: JulianDay, rhs: JulianDay) -> JulianDay {
        return JulianDay(lhs.value * rhs.value)
    }
    
    public static func *=(lhs: inout JulianDay, rhs: JulianDay) {
        lhs.value = lhs.value * rhs.value
    }
    
    /// The Julian Day value
    public var value: Double
    public var magnitude: Double
    /// Returns a Julian Day struct initialized to contain the given value.
    ///
    /// - Parameter value: The value for the new Julian Day.
    public init(_ value: Double) {
        self.value = value
        self.magnitude = value
    }
    
    /// Returns a Julian Day struct initialized from a given Gregorian calendar date, in the UT reference frame,
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
    /**
     Returns a new Date object corresponding to the Julian Day value.
     
     - returns: A new Date object, in the gregorian calendar, corresponding to to the Julian Day value.
     */
    public var date: Date {
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
    
    /**
     Returns the so-called Modified Julian Day corresponding to the Julian Day value.
     Contrary to the JD, the Modified Julian Day begins at Greenwhich mean midnight.
     It is equal to JD - 2400 000.5
     
     - returns: A Double value, corresponding to to the modified Julian Day value.
     */
    public var modified: Double {
        get { return self.value - ModifiedJulianDayZero }
    }
    

    /**
     Returns the Julian Day corresponding to the Greenwhich midnight before the actual value.
     
     - returns: A Julian Day object, corresponding to the Greenwhich midnight before the actual value.
     */
    public var midnight: JulianDay { return JulianDay((value - 0.5).rounded(.down) + 0.5) }
    
    /**
     Returns the Julian Day corresponding to the geometric midnight local to a given Earth longitude,
     before the actual value. It is a direct function of the longitude, and makes no reference to time zone whatsoever.
     Once transformed to a Date object, it will most probably not corresponds to the normal "midnight" date & hour,
     since the latter is identical by convention on a given timezone. The local date however is always respected 
     (since you may cross the new-date line depending on longitude).
     
     - returns: A Julian Day object, corresponding to the geometric midnight local to a given Earth longitude.
     */
    public func localMidnight(longitude: Degree) -> JulianDay {
        var shift = 0.0
        if longitude.inHours.value > self.date.fractionalHour { shift = -1.0 }
        else if longitude.inHours.value+12.0 < -self.date.fractionalHour { shift = +1.0 }
        return self.midnight.date.addingTimeInterval(longitude.inHours.inSeconds.value).julianDay + JulianDay(shift)
    }

    
    /// Returns the Julian Day corresponding to the local midnight, based on timezone.
    ///
    /// - Parameter timeZone: The time zone.
    /// - Returns: A Julian Day object
    public func localMidnight(timeZone: TimeZone) -> JulianDay {
        let offsetFromGMT = JulianDay(Double(timeZone.secondsFromGMT(for: self.date)) / (60*60*24))
        return (self + offsetFromGMT).midnight - offsetFromGMT
    }

    /**
     Computes the mean sidereal time for the Greenwich meridian.
     That is, the Greenwich hour angle of the mean vernal point (the intersection of the ecliptic
     of the date with the mean equator of the date).
     
     - returns: The sidereal time in hours.
     */
    public func meanGreenwichSiderealTime() -> Hour {
        return Hour(KPCAASidereal_MeanGreenwichSiderealTime(self.value))
    }

    /**
     Computes the mean sidereal time for a given longitude on Earth.
     
     - parameter longitude: Positively Westward (see AA p. 93 for explanations).
     Basically: this is the contrary of IAU decision. But this orientation is consistent
     with longitude orientation in all other planets!
     
     - returns: The sidereal time in hours.
     */
    public func meanLocalSiderealTime(longitude: Degree) -> Hour {
        return self.meanGreenwichSiderealTime() - longitude.inHours
    }

    /**
     Computes the apparent sidereal time.
     That is, the Greenwich hour angle of the true vernal equinox, obtained by adding a correction
     that depends on the nutation in longitude, and the true obliquity of the ecliptic.
     
     - returns: The sidereal time in hours.
     */
    public func apparentGreenwichSiderealTime() -> Hour {
        return Hour(KPCAASidereal_ApparentGreenwichSiderealTime(self.value))
    }
    
    // Obliquity
    
    public func obliquityOfEcliptic(mean: Bool = true) -> Degree {
        return Degree(KPCAANutation_ObliquityOfEcliptic(mean, self.value))
    }
    
    // MARK: Dynamical Times
    
    /// Returns the difference bewteeen TD (the 'Time Dynamical'), and UT (the Universal Time).
    /// TD was later renamed TT for Terrestrial Time (which is a fairly unfortunate naming...).
    ///
    /// - Returns: The number of seconds (and fraction of thereof) between TD and UT.
    public func deltaT() -> Second {
        return Second(KPCAADynamicalTime_DeltaT(self.value))
    }
    
    public func cumulativeLeapSeconds() -> JulianDay {
        return JulianDay(KPCAADynamicalTime_CumulativeLeapSeconds(self.value))
    }
    
    public func TTtoUTC() -> JulianDay {
        return JulianDay(KPCAADynamicalTime_TT2UTC(self.value))
    }

    public func UTCtoTT() -> JulianDay {
        return JulianDay(KPCAADynamicalTime_UTC2TT(self.value))
    }

    public func TTtoTAI() -> JulianDay {
        return JulianDay(KPCAADynamicalTime_TT2TAI(self.value))
    }

    public func TAItoTT() -> JulianDay {
        return JulianDay(KPCAADynamicalTime_TAI2TT(self.value))
    }

    public func TTtoUT1() -> JulianDay {
        return JulianDay(KPCAADynamicalTime_TT2UT1(self.value))
    }

    public func UT1toTT() -> JulianDay {
        return JulianDay(KPCAADynamicalTime_UT12TT(self.value))
    }

    public func UT1minusUTC() -> JulianDay {
        return JulianDay(KPCAADynamicalTime_UT1MinusUTC(self.value))
    }
}

  
extension JulianDay: CustomStringConvertible {
    
    /// The description of the Julian Day.
    public var description: String {
        switch self {
        case StandardEpoch_J2000_0: return "J2000.0"
        case StandardEpoch_B1950_0: return "B1950.0"
        default: return String(format: "JD %.2f", value)
        }
    }
}



