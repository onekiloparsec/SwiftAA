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
    
    /// The year component of the date.
    public var year: Int {
        get { return Calendar.gregorianGMT.component(.year, from: self) }
    }
    
    /// The month component of the date
    public var month: Int {
        get { return Calendar.gregorianGMT.component(.month, from: self) }
    }
    
    /// The dat component of the date.
    public var day: Int {
        get { return Calendar.gregorianGMT.component(.day, from: self) }
    }
    
    /// The hour component of the date.
    public var hour: Int {
        get { return Calendar.gregorianGMT.component(.hour, from: self) }
    }
    
    /// The fractional hour of the date
    public var fractionalHour: Double {
        get { return Double(self.hour) + Double(self.minute)/60.0 + Double(self.second)/3600.0 + Double(self.nanosecond)/1e9/3600.0 }
    }
    
    /// The minute component of the date.
    public var minute: Int {
        get { return Calendar.gregorianGMT.component(.minute, from: self) }
    }
    
    /// The second component of the date.
    public var second: Int {
        get { return Calendar.gregorianGMT.component(.second, from: self) }
    }
    
    /// The remainder of the date, in nanoseconds.
    public var nanosecond: Int {
        get { return Calendar.gregorianGMT.component(.nanosecond, from: self) }
    }
    
    /// Returns whether the date is in a leap year or not.
    public var isLeap : Bool {
        get { return ((self.year % 100) == 0) ? (self.year % 400) == 0 : (self.year % 4) == 0 }
    }
    
    /// Returns a new date corresponding the 1st of January of the same year.
    ///
    /// - Returns: A new date object.
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
    
    
    /// The fractional year corresponding to the date.
    public var fractionalYear: Double {
        get {
            let daysCount = (self.isLeap) ? 366.0 : 365.0
            return Double(self.year) + ((self.julianDay.value - self.januaryFirstDate().julianDay.value) / daysCount)
        }
    }
    
    /// Returns the number of integral days since January 1st, 2000.
    ///
    /// - Returns: The number of integral days since January 1st, 2000.
    public func daysSince2000January0() -> Int {
        let A = 367*self.year
        let B = (7*(self.year + (self.month+9)/12))/4
        let C = (275*self.month)/9
        let D = self.day-730530
        return A - B + C + D
    }
}


extension Calendar {
    
    /// Convenience constructor of the Gregorian calendar, in the GMT/UT time zone.
    static let gregorianGMT: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar
    }()
    
    /// Returns a new date by setting the fractional hour value to a given date.
    ///
    /// - Parameters:
    ///   - hour: The fractional hour value.
    ///   - date: The date to which the hour must be set.
    /// - Returns: A new date object.
    func date(bySettingHour hour: Hour, of date: Date) -> Date {
        // No check for when hour < 0???
        let h = abs(hour.value.rounded(.towardZero))
        let m = ((abs(hour.value) - h) * 60.0).rounded(.towardZero)
        let s = (((abs(hour.value) - h) * 60.0 - m) * 60.0).rounded(.towardZero)
        let nano = hour.value - h - m*60 - s*3600
        let newDate = self.date(bySettingHour: Int(h), minute: Int(m), second: Int(s), of: date)!
        return newDate.addingTimeInterval(nano/1e9)
    }
}

