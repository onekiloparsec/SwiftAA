//
//  Nutation.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 01/10/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public func nutationInLongitude(julianDay: JulianDay) -> Double {
    return KPCAANutation_NutationInLongitude(julianDay.value)
}

public func nutationInObliquity(julianDay: JulianDay) -> Double {
    return KPCAANutation_NutationInObliquity(julianDay.value)
}

//public func nutationInRightAscension(julianDay: JulianDay) -> Double {
//    return KPCAANutation_NutationInObliquity(julianDay)
//}
//

//public func nutationInDeclination(julianDay: JulianDay) -> Double {
//    return KPCAANutation_NutationInObliquity(julianDay)
//}
//

// Note (p 92): if the _apparent_ right ascension and declination are used, that is
// affected by the aberration and the nutation, the true obliquity should be used.
public func obliquityOfEcliptic(julianDay: JulianDay, mean: Bool = true) -> Double {
    if mean {
        return KPCAANutation_MeanObliquityOfEcliptic(julianDay.value)
    }
    else {
        return KPCAANutation_TrueObliquityOfEcliptic(julianDay.value)
    }
}
