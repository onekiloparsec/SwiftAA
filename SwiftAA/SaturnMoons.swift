//
//  SaturnMoons.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/11/2016.
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

