//
//  EclipticObject.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

protocol EclipticObject {
    var julianDay: JulianDay { get set }
    
    /**
     Identifies the ecliptical object.
     */
    var eclipticObject: KPCEclipticObject { get }
    
    init(julianDay: JulianDay)
    
    /**
     Compute the ecliptic (=heliocentric) longitude of the planet
     
     - parameter hp: If true, will use the latest VSOP implementation to increase precision.
     
     - returns: the ecliptic longitude in AU
     */
    func eclipticLongitude(highPrecision: Bool) -> AU
    
    /**
     Compute the ecliptic (=heliocentric) latitude of the planet
     
     - parameter hp: If true, will use the latest VSOP implementation to increase precision.
     
     - returns: the ecliptic latitude in AU
     */
    func eclipticLatitude(highPrecision: Bool) -> AU
    
    /**
     Compute the radius vector (=distance to the Sun)
     
     - parameter hp: If true, will use the latest VSOP implementation to increase precision.
     
     - returns: the radius vector in AU
     */
    func radiusVector(highPrecision: Bool) -> AU
}

extension EclipticObject {
    func eclipticLongitude(highPrecision: Bool = true) -> AU {
        return KPCAAEclipticalElement_EclipticalLongitude(self.julianDay, self.eclipticObject, highPrecision)
    }
    
    func eclipticLatitude(highPrecision: Bool = true) -> AU {
        return KPCAAEclipticalElement_EclipticalLatitude(self.julianDay, self.eclipticObject, highPrecision)
    }
    
    func radiusVector(highPrecision: Bool = true) -> AU {
        return KPCAAEclipticalElement_RadiusVector(self.julianDay, self.eclipticObject, highPrecision)
    }
}
