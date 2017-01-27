//
//  JulianDay.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 26/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct JulianDay: NumericType {
    
    public let value: Double
    
    public init(_ value: Double) {
        self.value = value
    }
    
    public init(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Double = 0.0) {
        let aaDate = KPCAADate(year: year, month: month, day: Double(day), hour: Double(hour), minute: Double(minute), second: second, usingGregorianCalendar: true)!
        self.init(aaDate.julian())
    }
    
    public init(_ date: Date) {
        let components = Calendar.gregorianGMT.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: date)
        let decimalSeconds = Double(components.second!) + Double(components.nanosecond!)/1e9
        self.init(year: components.year!, month: components.month!, day: components.day!, hour: components.hour!, minute: components.minute!, second: decimalSeconds)
    }
    
}

public extension JulianDay {
    /**
     Transform a julian day into a Date.
     
     - returns: The corresponding Date instance.
     */
    public var date: Date {
        let aaDate = KPCAADate(julianDay: value, usingGregorianCalendar: true)!
        let decimalSeconds = aaDate.second()
        let roundedSeconds = decimalSeconds.rounded(.towardZero)
        let nanoseconds = (decimalSeconds - roundedSeconds) * 1e9
        let components = DateComponents(year: aaDate.year(), month: aaDate.month(), day: aaDate.day(), hour: aaDate.hour(), minute: aaDate.minute(), second: Int(roundedSeconds), nanosecond: Int(nanoseconds))
        let date = Calendar.gregorianGMT.date(from: components)!
        return date
    }
    
    public var modified: JulianDay {
        get { return JulianDay(self.value - ModifiedJulianDayZero) }
    }
    
    public var midnight: JulianDay { return JulianDay((value - 0.5).rounded(.down) + 0.5) }
    
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
    public func meanLocalSiderealTime(forGeographicLongitude longitude: Degree) -> Hour {
        return Hour(self.meanGreenwichSiderealTime().value - RadiansToHours(DegreesToRadians(longitude.value)))
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
    
    // MARK: Dynamical Times
    
    public func deltaT() -> JulianDay {
        return JulianDay(KPCAADynamicalTime_DeltaT(self.value))
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
    public var description: String {
        switch self {
        case StandardEpoch_J2000_0: return "J2000.0"
        case StandardEpoch_B1950_0: return "B1950.0"
        default: return String(format: "JD %.2f", value)
        }
    }
}



