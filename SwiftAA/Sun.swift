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
    private var physicalDetails: KPCAAPhysicalSunDetails
    
    public let diameter: Meters = 1392000000.0
    
    public init(julianDay: JulianDay, highPrecision: Bool = true) {
        self.julianDay = julianDay
        self.highPrecision = highPrecision
        self.physicalDetails = KPCAAPhysicalSun_CalculateDetails(julianDay, highPrecision)
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
    
    /**
     This is the position angle of the northern extremity of the axis of rotation,
     measured eastwards from the North Point of the solar disk.
    
     - returns: The position angle in degrees.
     */
    func positionAngleOfNorthernRotationAxisPoint() -> Degrees {
        return self.physicalDetails.P
    }
    
    /**
     The heliographic latitude of the center of the solar disk. It represents the tilt
     of the Sun's north pole toward (+) or away (-) from Earth. It is zero about June 6
     and December 7, and reaches a maximum value about March 6 (-7º.25) and September 8
     (+7º.25).
     
     - returns: The latitude in degrees.
     */
    func heliographicLatitudeOfSolarDiskCenter() -> Degrees {
        return self.physicalDetails.B0
    }
    
    /**
     The heliographic longitude of the center of the solar disk. It decreases by about 
     13.2 degrees per day.
     
     - returns: The longitude in degrees.
     */
    func heliographicLongitudeOfSolarDiskCenter() -> Degrees {
        return self.physicalDetails.L0
    }

    /**
     A synodic rotation cycle of the Sun begins when the heliographic longitude of the
     solar disk center is 0º.
     
     - parameter C: The rotation number. C = 1 on November 9, 1853.
     
     - returns: The julian day of the start of the cycle.
     */
    func timeOfStartOfSynodicRotation(rotationNumber C: Int) -> JulianDay {
        return KPCAAPhysicalSun_TimeOfStartOfRotation(C)
    }
}