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
    private var objectName: String = ""
    public private(set) var equatorialCoordinates: EquatorialCoordinates
    
    public var equatorialSemiDiameter: Degree = 0.0
    public var polarSemiDiameter: Degree = 0.0
    
    public override var name: String { get { return self.objectName } }
    
    public init(name: String, coordinates: EquatorialCoordinates, julianDay: JulianDay) {
        self.objectName = name
        self.equatorialCoordinates = coordinates
        super.init(julianDay: julianDay)
    }
    
    public required init(julianDay: JulianDay, highPrecision: Bool) {
        fatalError("init(julianDay:highPrecision:) has not been implemented")
    }
    
    /// The radius vector (i.e. the distance to the Sun). Returns -1. Only for conformance to CelestialBody.
    public var radiusVector: AstronomicalUnit {
        get { return -1 }
    }
    
    public var eclipticCoordinates: EclipticCoordinates {
        get { return self.equatorialCoordinates.makeEclipticCoordinates() }
    }
    
    public var apparentEclipticCoordinates: EclipticCoordinates {
        get { return self.eclipticCoordinates }
    }

    public var apparentEquatorialCoordinates: EquatorialCoordinates {
        get { return self.eclipticCoordinates.makeApparentEquatorialCoordinates() }
    }
    
    public static let apparentRiseSetAltitude = ArcMinute(-34).inDegrees // See AA p.101
    
}
