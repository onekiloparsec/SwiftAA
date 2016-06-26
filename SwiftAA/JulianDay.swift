//
//  JulianDay.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 26/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public typealias JulianDay=Double
public typealias Hour=Double

extension JulianDay {
    func Date() -> KPCAADate {
        return KPCAADate(julianDay: self, usingGregorianCalendar: true)
    }
    
    func MeanGreenwichSiderealTime() -> Hour {
        return KPCAASidereal_MeanGreenwichSiderealTime(self)
    }
    
    func ApparentGreenwichSiderealTime() -> Hour {
        return KPCAASidereal_ApparentGreenwichSiderealTime(self)
    }
}