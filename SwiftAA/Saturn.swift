//
//  Saturn.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

// Saturnian Moons are a world by themselves! We'll consider the 7 most important for now.
// Quoting Wikipedia (July 2016):
// The moons of Saturn are numerous and diverse, ranging from tiny moonlets less than 1 kilometer across to the enormous Titan, which is larger than the planet Mercury. Saturn has 62 moons with confirmed orbits, 53 of which have names and only 13 of which have diameters larger than 50 kilometers. Seven Saturnian moons are large enough to be ellipsoidal in shape, though only two of those, Titan and Rhea, are currently in hydrostatic equilibrium, as well as dense rings with complex orbital motions of their own. Particularly notable among Saturn's moons are Titan, the second-largest moon (after Jupiter's Ganymede) in the Solar System, with a nitrogen-rich Earth-like atmosphere and a landscape including hydrocarbon lakes and dry river networks;[5] and Enceladus, which is seemingly similar in chemical makeup to comets, emits jets of gas and dust and may harbor liquid water under its south pole region.

// Additional data can be taken from this source (referenced by Wikipedia):
// http://nssdc.gsfc.nasa.gov/planetary/factsheet/saturniansatfact.html

public struct SaturnianMoon {
    fileprivate var details: KPCAASaturnMoonDetails
    
    public var name: String
    
    public var inTransit: Bool { get { return self.details.inTransit.boolValue } }
    public var inOccultation: Bool { get { return self.details.inOccultation.boolValue } }
    public var inEclipse: Bool { get { return self.details.inEclipse.boolValue } }
    public var inShadowTransit: Bool { get { return self.details.inShadowTransit.boolValue } }
    
    init(name: String, details: KPCAASaturnMoonDetails) {
        self.name = name
        self.details = details
    }
    
    public func rectangularCoordinates(_ apparent: Bool = true) -> KPCAA3DCoordinateComponents {
        return (apparent == true) ? self.details.ApparentRectangularCoordinateComponents : self.details.TrueRectangularCoordinateComponents
    }
}

// Saturn has many rings. Here we consider the ring system as a whole.
public struct SaturnRingSystem {
    fileprivate var details: KPCAASaturnRingDetails

    /**
     The Saturnicentric latitude of the Earth referred to the plane of the ring (B),
     positive towards the north. When B is positive, the visible surface of the ring is
     the northern one.
    */
    public var saturnicentricEarthLatitude: Degrees { get { return self.details.B } }
    
    /**
     The Saturnicentric latitude of the Sun referred to the plane of the ring (B'),
     positive towards the north. When B' is positive, the illuminated surface of the ring is
     the northern one.
     */
    public var saturnicentricSunLatitude: Degrees { get { return self.details.Bdash } }
    
    /**
     The position angle of the north pole of rotation of the planet. Because the ring is
     situated exactly in Saturn's equator plane, P is also the geocentric position angle of the
     northern semiminor axis of the apparent ellipse of the ring, measured from the North towards
     the East (trust me... see AA p.317)
    */
    public var northPolePositionAngle: Degrees { get { return self.details.P } }
    
    /**
     The major axis of the outer edge of the outer ring.
    */
    public var majorAxis: Degrees { get { return self.details.a / 3600.0 } }

    /**
     The minor axis of the outer edge of the outer ring.
     */
    public var minorAxis: Degrees { get { return self.details.b / 3600.0 } }
    
    /**
     The difference between the Saturnicentric longitude of the Sun and the Earth, measured in 
     the plane of the ring. Used to compute Saturn's magnitude.
    */
    public var saturnicentricSunEarthLongitudesDifference: Degrees { get { return self.details.DeltaU } }
    
    init(_ details: KPCAASaturnRingDetails) {
        self.details = details
    }
    
}

/**
 *  Saturn
 */
public struct Saturn: Planet {
    public static var color: Color {
        get { return Color(red: 0.941, green:0.827, blue:0.616, alpha: 1.0) }
    }

    public fileprivate(set) var julianDay: JulianDay
    public fileprivate(set) var highPrecision: Bool
    
    public fileprivate(set) var Mimas: SaturnianMoon
    public fileprivate(set) var Enceladus: SaturnianMoon
    public fileprivate(set) var Tethys: SaturnianMoon
    public fileprivate(set) var Dione: SaturnianMoon
    public fileprivate(set) var Rhea: SaturnianMoon
    public fileprivate(set) var Titan: SaturnianMoon
    public fileprivate(set) var Iapetus: SaturnianMoon

    public fileprivate(set) var ringSystem: SaturnRingSystem

    public var moons: [SaturnianMoon] {
        get { return [self.Mimas, self.Enceladus, self.Tethys, self.Dione, self.Rhea, self.Titan, self.Iapetus] }
    }
    
    public init(julianDay: JulianDay, highPrecision: Bool = true) {
        self.julianDay = julianDay
        self.highPrecision = highPrecision
        
        let details = KPCAASaturnMoonsDetails_Calculate(julianDay, highPrecision)
        self.Mimas = SaturnianMoon(name: "Mimas", details: details.Satellite1)
        self.Enceladus = SaturnianMoon(name: "Enceladus", details: details.Satellite2)
        self.Tethys = SaturnianMoon(name: "Tethys", details: details.Satellite3)
        self.Dione = SaturnianMoon(name: "Dione", details: details.Satellite4)
        self.Rhea = SaturnianMoon(name: "Rhea", details: details.Satellite5)
        self.Titan = SaturnianMoon(name: "Titan", details: details.Satellite6)
        self.Iapetus = SaturnianMoon(name: "Iapetus", details: details.Satellite7)
        
        let ringDetails = KPCAASaturnRings_Calculate(self.julianDay, self.highPrecision)
        self.ringSystem = SaturnRingSystem(ringDetails)
    }
    
    public init(date: Date, highPrecision: Bool = true) {
        self.init(julianDay: KPCAADate(gregorianCalendarDate: date).julian(), highPrecision: highPrecision)
    }
    
    /// Includes the contribution from the ring.
    public var magnitude: Double { get { return KPCAAIlluminatedFraction_SaturnMagnitudeAA(self.radiusVector, self.apparentGeocentricDistance, self.ringSystem.details.DeltaU, self.ringSystem.details.B) } }
}

