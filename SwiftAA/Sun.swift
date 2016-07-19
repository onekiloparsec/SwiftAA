//
//  Sun.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/07/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Sun: ObjectBase {
    public private(set) var julianDay: JulianDay
    public private(set) var highPrecision: Bool
    
    public init(julianDay: JulianDay, highPrecision: Bool = true) {
        self.julianDay = julianDay
        self.highPrecision = highPrecision
    }
    
    public init(date: NSDate, highPrecision: Bool = true) {
        self.init(julianDay: KPCAADate(gregorianCalendarDate: date).Julian(), highPrecision: highPrecision)
    }
    
    /**
     Computes the time of the next start of the synodic rotation of the Sun
     (used to follow sunspots).
     
     - returns: The julian day of the next stary
     */
    func nextStartOfTimeOfRotation() -> JulianDay {
        let C = ceil((self.julianDay - 2398140.2270)/27.2752316) // Equ 29.1 of AA.
        return KPCAAPhysicalSun_TimeOfStartOfRotation(Int(C))
    }
    
    func geocentricLongitude(equinox: Equinox) -> Degrees {
        switch equinox {
        case .MeanEquinoxOfTheDate:
            return KPCAASun_GeometricEclipticLongitude(self.julianDay, self.highPrecision)
        case .StandardJ2000:
            return KPCAASun_GeometricEclipticLongitudeJ2000(self.julianDay, self.highPrecision)
        }
    }
    
    func geocentricLatitude(equinox: Equinox) -> Degrees {
        switch equinox {
        case .MeanEquinoxOfTheDate:
            return KPCAASun_GeometricEclipticLatitude(self.julianDay, self.highPrecision)
        case .StandardJ2000:
            return KPCAASun_GeometricEclipticLatitudeJ2000(self.julianDay, self.highPrecision)
        }
    }

}