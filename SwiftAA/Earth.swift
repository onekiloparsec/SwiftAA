//
//  Earth.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Earth {
    let julianDay: JulianDay
    
    init(julianDay: JulianDay) {
        self.julianDay = julianDay
    }
    
    func eclipticLongitude(withHighPrecision hp: Bool = true) -> Double {
        return KPCAAEarth_EclipticLongitude(self.julianDay, hp)
    }
    
    func eclipticLatitude(withHighPrecision hp: Bool = true) -> Double {
        return KPCAAEarth_EclipticLatitude(self.julianDay, hp)
    }
    
    func radiusVector(withHighPrecision hp: Bool = true) -> Double {
        return KPCAAEarth_RadiusVector(self.julianDay, hp)
    }
}
