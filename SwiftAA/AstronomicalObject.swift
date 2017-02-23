//
//  AstronomicalObject.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/12/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

// AstronomicalObject inherits from CelestialBody to benefit from the generic calculation of Rise and Set Times.
class AstronomicalObject: Object, CelestialBody {
    public private(set) var name: String = ""
    public private(set) var equatorialCoordinates: EquatorialCoordinates
    
    public var equatorialSemiDiameter: Degree = 0.0
    public var polarSemiDiameter: Degree = 0.0
    
    public init(name: String, coordinates: EquatorialCoordinates, julianDay: JulianDay) {
        self.name = name
        self.equatorialCoordinates = coordinates
        super.init(julianDay: julianDay)
    }
    
    public required init(julianDay: JulianDay, highPrecision: Bool) {
        fatalError("init(julianDay:highPrecision:) has not been implemented")
    }
    
    public var radiusVector: AU {
        get { return -1 }
    }
    
    public var eclipticCoordinates: EclipticCoordinates {
        get { return self.equatorialCoordinates.makeEclipticCoordinates() }
    }
    
    public var apparentEquatorialCoordinates: EquatorialCoordinates {
        get { return self.eclipticCoordinates.makeApparentEquatorialCoordinates() }
    }
    
    public let apparentRiseSetAltitude = ArcMinute(-34).inDegrees // See AA p.101
    
}
