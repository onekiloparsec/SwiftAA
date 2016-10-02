//
//  Sun.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/07/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public class Sun: Object {
    fileprivate var physicalDetails: KPCAAPhysicalSunDetails
    
    public let diameter: Meter = 1392000000.0
    
    public required init(julianDay: JulianDay, highPrecision: Bool = true) {
        self.physicalDetails = KPCAAPhysicalSun_CalculateDetails(julianDay, highPrecision)
        super.init(julianDay: julianDay, highPrecision: highPrecision)
    }
        
    /**
     Computes the time of the next start of the synodic rotation of the Sun
     (used to follow sunspots).
     
     - returns: The julian day of the next stary
     */
    public func nextStartOfTimeOfRotation() -> JulianDay {
        let C = ceil((self.julianDay - 2398140.2270)/27.2752316) // Equ 29.1 of AA.
        return KPCAAPhysicalSun_TimeOfStartOfRotation(Int(C))
    }
    
    public func eclipticLongitude(_ equinox: Equinox) -> Degree {
        switch equinox {
        case .meanEquinoxOfTheDate:
            return KPCAASun_GeometricEclipticLongitude(self.julianDay, self.highPrecision)
        case .standardJ2000:
            return KPCAASun_GeometricEclipticLongitudeJ2000(self.julianDay, self.highPrecision)
        }
    }
    
    public func eclipticLatitude(_ equinox: Equinox) -> Degree {
        switch equinox {
        case .meanEquinoxOfTheDate:
            return KPCAASun_GeometricEclipticLatitude(self.julianDay, self.highPrecision)
        case .standardJ2000:
            return KPCAASun_GeometricEclipticLatitudeJ2000(self.julianDay, self.highPrecision)
        }
    }
    
    // TODO: Refactor the ecliptic coords func into a single protocol, as in Planets/OrbitingObject?

    public func eclipticCoordinates() -> EclipticCoordinates {
        // To compute the _apparent_ RA and Dec, the true obliquity must be used.
        let epsilon = obliquityOfEcliptic(julianDay: self.julianDay, mean: false)
        return EclipticCoordinates(lambda: self.eclipticLongitude(.meanEquinoxOfTheDate),
                                   beta: self.eclipticLatitude(.meanEquinoxOfTheDate),
                                   epsilon: epsilon)
    }
    
    /**
     This is the position angle of the northern extremity of the axis of rotation,
     measured eastwards from the North Point of the solar disk.
    
     - returns: The position angle in degrees.
     */
    func positionAngleOfNorthernRotationAxisPoint() -> Degree {
        return self.physicalDetails.P
    }
    
    /**
     The heliographic latitude of the center of the solar disk. It represents the tilt
     of the Sun's north pole toward (+) or away (-) from Earth. It is zero about June 6
     and December 7, and reaches a maximum value about March 6 (-7º.25) and September 8
     (+7º.25).
     
     - returns: The latitude in degrees.
     */
    func heliographicLatitudeOfSolarDiskCenter() -> Degree {
        return self.physicalDetails.B0
    }
    
    /**
     The heliographic longitude of the center of the solar disk. It decreases by about 
     13.2 degrees per day.
     
     - returns: The longitude in degrees.
     */
    func heliographicLongitudeOfSolarDiskCenter() -> Degree {
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
