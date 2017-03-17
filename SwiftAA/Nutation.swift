//
//  Nutation.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 01/10/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

extension Earth {
    
    /// The nutation is a periodic oscillation of the rotational axis of the Earth around its "mean" position
    /// It is due principally to the action of the Moon. It can be decomposed into components parallel and
    /// perpendicular to the ecliptic. 
    /// Here it is that component along the ecliptic.
    public var nutationInLongitude: ArcMinute {
        get { return ArcMinute(KPCAANutation_NutationInLongitude(self.julianDay.value)) }
    }
    
    /// The nutation is a periodic oscillation of the rotational axis of the Earth around its "mean" position
    /// It is due principally to the action of the Moon. It can be decomposed into components parallel and
    /// perpendicular to the ecliptic.
    /// Here it is that component perpendicular to the ecliptic.
    public var nutationInObliquity: ArcMinute {
        get { return ArcMinute(KPCAANutation_NutationInObliquity(self.julianDay.value)) }
    }
    
    //public func nutationInRightAscension(julianDay: JulianDay) -> Double {
    //    return KPCAANutation_NutationInObliquity(julianDay)
    //}
    //
    
    //public func nutationInDeclination(julianDay: JulianDay) -> Double {
    //    return KPCAANutation_NutationInObliquity(julianDay)
    //}
    //
    
    /// AA p.147:
    /// The obliquity of the ecliptic, or inclination of the Earth's axis of rotation, is the angle between
    /// the equator and the ecliptic. One distinguishes the mean and the true obliquity, being the angles
    /// which the ecliptic makes with the mean and with the true (instantaneous) equator. In other words,
    /// the adjective "mean" indicates that the correction for nutation is not taken into account.
    /// AA p.92: 
    /// If the _apparent_ right ascension and declination are used, that is
    /// affected by the aberration and the nutation, the true obliquity should be used.
    public func obliquityOfEcliptic(mean: Bool = true) -> Degree {
        return Degree(KPCAANutation_ObliquityOfEcliptic(mean, self.julianDay.value))
    }
}

