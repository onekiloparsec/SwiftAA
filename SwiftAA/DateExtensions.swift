//
//  DateExtensions.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 27/01/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import Foundation

public extension Date {
    /**
     Computes the Julian Day from the date.
     
     - returns: The value of the Julian Day, as a fractional (double) number.
     */
    public var julianDay: JulianDay {
        return JulianDay(self)
    }
    
    public var year: Int {
        get { return Calendar.gregorianGMT.component(.year, from: self) }
    }
    
    public var month: Int {
        get { return Calendar.gregorianGMT.component(.month, from: self) }
    }
    
    public var day: Int {
        get { return Calendar.gregorianGMT.component(.day, from: self) }
    }
    
    public var hour: Int {
        get { return Calendar.gregorianGMT.component(.hour, from: self) }
    }
    
    public var minute: Int {
        get { return Calendar.gregorianGMT.component(.minute, from: self) }
    }
    
    public var second: Int {
        get { return Calendar.gregorianGMT.component(.second, from: self) }
    }
    
    public var nanosecond: Int {
        get { return Calendar.gregorianGMT.component(.nanosecond, from: self) }
    }
    
    public var isLeap : Bool {
        get { return ((self.year % 100) == 0) ? (self.year % 400) == 0 : (self.year % 4) == 0 }
    }
    
    public func januaryFirstDate() -> Date {
        var components = DateComponents()
        components.year = self.year
        components.month = 1
        components.day = 1
        components.hour = 0
        components.minute = 0
        components.second = 0
        return Calendar.gregorianGMT.date(from: components)!
    }
    
    public var fractionalYear: Double {
        get {
            let daysCount = (self.isLeap) ? 366.0 : 365.0
            return Double(self.year) + ((self.julianDay.value - self.januaryFirstDate().julianDay.value) / daysCount)
        }
    }
    
    public func daysSince2000January0() -> Int {
        let A = 367*self.year
        let B = (7*(self.year + (self.month+9)/12))/4
        let C = (275*self.month)/9
        let D = self.day-730530
        return A - B + C + D
    }
}


extension Calendar {
    static let gregorianGMT: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar
    }()
    
    func date(bySettingHour hour: Double, of date: Date) -> Date {
        // No check for when hour < 0???
        let h = abs(hour.rounded(.towardZero))
        let m = ((abs(hour) - h) * 60.0).rounded(.towardZero)
        let s = (((abs(hour) - h) * 60.0 - m) * 60.0).rounded(.towardZero)
        let nano = hour - h - m*60 - s*3600
        let newDate = self.date(bySettingHour: Int(h), minute: Int(m), second: Int(s), of: date)!
        return newDate.addingTimeInterval(nano/1e9)
    }
}

// See http://www.stjarnhimlen.se/comp/riset.html
// See https://github.com/onekiloparsec/AstroCocoaKit/blob/master/AstroCocoaKit/sunriset.c
//
/*******************************************************************/
/* This function computes GMST0, the Greenwich Mean Sidereal Time  */
/* at 0h UT (i.e. the sidereal time at the Greenwhich meridian at  */
/* 0h UT).  GMST is then the sidereal time at Greenwich at any     */
/* time of the day.  I've generalized GMST0 as well, and define it */
/* as:  GMST0 = GMST - UT  --  this allows GMST0 to be computed at */
/* other times than 0h UT as well.  While this sounds somewhat     */
/* contradictory, it is very practical:  instead of computing      */
/* GMST like:                                                      */
/*                                                                 */
/*  GMST = (GMST0) + UT * (366.2422/365.2422)                      */
/*                                                                 */
/* where (GMST0) is the GMST last time UT was 0 hours, one simply  */
/* computes:                                                       */
/*                                                                 */
/*  GMST = GMST0 + UT                                              */
/*                                                                 */
/* where GMST0 is the GMST "at 0h UT" but at the current moment!   */
/* Defined in this way, GMST0 will increase with about 4 min a     */
/* day.  It also happens that GMST0 (in degrees, 1 hr = 15 degr)   */
/* is equal to the Sun's mean longitude plus/minus 180 degrees!    */
/* (if we neglect aberration, which amounts to 20 seconds of arc   */
/* or 1.33 seconds of time)                                        */
/*                                                                 */
/*******************************************************************/

public func GMST0(day: Double) -> Degree {
    /* Sidtime at 0h UT = L (Sun's mean longitude) + 180.0 degr  */
    /* L = M + w, as defined in sunpos().  Since I'm too lazy to */
    /* add these numbers, I'll let the C compiler do it for me.  */
    /* Any decent C compiler will add the constants at compile   */
    /* time, imposing no runtime or code overhead.               */
    return Degree( ( 180.0 + 356.0470 + 282.9404 ) + ( 0.9856002585 + 4.70935E-5 ) * day ).reduced
}
