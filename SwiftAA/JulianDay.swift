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

public extension JulianDay {
    /**
     Transform a julian day into a Date.
     
     - returns: The corresponding Date instance.
     */
    func Date() -> KPCAADate {
        return KPCAADate(julianDay: self, usingGregorianCalendar: true)
    }
    
    /**
     Computes the mean sidereal time for the Greenwich meridian.
     That is, the Greenwich hour angle of the mean vernal point (the intersection of the ecliptic
     of the date with the mean equator of the date).
     
     - returns: The sidereal time in hours.
     */
    func meanGreenwichSiderealTime() -> Hour {
        return KPCAASidereal_MeanGreenwichSiderealTime(self)
    }

    /**
     Computes the mean sidereal time for a given longitude on Earth.
     
     - parameter longitude: Positively Westward (see AA p. 93 for explanations).
     Basically: this is the contrary of IAU decision. But this orientation is consistent
     with longitude orientation in all other planets!
     
     - returns: The sidereal time in hours.
     */
    func meanLocalSiderealTime(forGeographicLongitude longitude: Double) -> Hour {
        return self.meanGreenwichSiderealTime() - RadiansToHours(DegreesToRadians(longitude))
    }

    /**
     Computes the apparent sidereal time.
     That is, the Greenwich hour angle of the true vernal equinox, obtained by adding a correction
     that depends on the nutation in longitude, and the true obliquity of the ecliptic.
     
     - returns: The sidereal time in hours.
     */
    func apparentGreenwichSiderealTime() -> Hour {
        return KPCAASidereal_ApparentGreenwichSiderealTime(self)
    }
}