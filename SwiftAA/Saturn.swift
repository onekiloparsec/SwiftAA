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

// Additional data is taken from this source (referenced by Wikipedia):
// http://nssdc.gsfc.nasa.gov/planetary/factsheet/saturniansatfact.html

public struct SaturnianMoon {
    private var details: KPCAASaturnMoonDetails
    
    public var name: String
    
    public var inTransit: Bool { get { return Bool(self.details.inTransit) } }
    public var inOccultation: Bool { get { return Bool(self.details.inOccultation) } }
    public var inEclipse: Bool { get { return Bool(self.details.inEclipse) } }
    public var inShadowTransit: Bool { get { return Bool(self.details.inShadowTransit) } }
    
    init(name: String, details: KPCAASaturnMoonDetails) {
        self.name = name
        self.details = details
    }
    
    public func rectangularCoordinates(apparent: Bool = true) -> KPCAA3DCoordinateComponents {
        return (apparent == true) ? self.details.ApparentRectangularCoordinateComponents : self.details.TrueRectangularCoordinateComponents
    }
}

public struct Saturn: Planet {
    public static var color: Color {
        get { return Color(red: 0.941, green:0.827, blue:0.616, alpha: 1.0) }
    }

    public private(set) var julianDay: JulianDay
    public private(set) var highPrecision: Bool
    
    public private(set) var Mimas: SaturnianMoon
    public private(set) var Enceladus: SaturnianMoon
    public private(set) var Tethys: SaturnianMoon
    public private(set) var Dione: SaturnianMoon
    public private(set) var Rhea: SaturnianMoon
    public private(set) var Titan: SaturnianMoon
    public private(set) var Iapetus: SaturnianMoon
    
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
    }
    
    public init(date: NSDate, highPrecision: Bool = true) {
        self.init(julianDay: KPCAADate(gregorianCalendarDate: date).Julian(), highPrecision: highPrecision)
    }    
}

