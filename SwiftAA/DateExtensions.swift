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

