//
//  JupiterMoons.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/11/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

typealias JupiterEquatorialRadius = Double


/// These coordinates describe the position of the four great satellites of Jupiter, with respect to the planet,
/// as seen from the Earth. These apparent rectangular coordinates Z and Y are measured from the center of the disk
/// of Jupiter, in units of the planet's equatorial radius.
/// X is measured positively to the west of Jupiter, the axis coinciding with equator of the planet.
/// Y is measured positively to the north, the axis coinciding with the rotation axis of the planet.
/// Z is negative if the satellite is closer to the Earth than Jupiter, and positive otherwise.
public struct GalileanMoonRectangularCoordinates {
    fileprivate(set) var X: JupiterEquatorialRadius
    fileprivate(set) var Y: JupiterEquatorialRadius
    fileprivate(set) var Z: Double
    
    init(X: JupiterEquatorialRadius, Y: JupiterEquatorialRadius, Z: Double) {
        self.X = X
        self.Y = Y
        self.Z = Z
    }

    init(components: KPCAA3DCoordinateComponents) {
        self.X = components.X
        self.Y = components.Y
        self.Z = components.Z
    }
}

public struct GalileanMoon {
    fileprivate var details: KPCAAGalileanMoonDetails

    public var name: String

    public var MeanLongitude: Degree { get { return Degree(self.details.MeanLongitude) } }
    public var TrueLongitude: Degree { get { return Degree(self.details.TrueLongitude) } }
    public var TropicalLongitude: Degree { get { return Degree(self.details.TropicalLongitude) } }
    public var EquatorialLatitude: Degree { get { return Degree(self.details.EquatorialLatitude) } }

    public var radiusVector: AU { get { return AU(self.details.r) } }

    public var inTransit: Bool { get { return self.details.inTransit.boolValue } }
    public var inOccultation: Bool { get { return self.details.inOccultation.boolValue } }
    public var inEclipse: Bool { get { return self.details.inEclipse.boolValue } }
    public var inShadowTransit: Bool { get { return self.details.inShadowTransit.boolValue } }

    init(name: String, details: KPCAAGalileanMoonDetails) {
        self.name = name
        self.details = details
    }

    // TODO: Improve this by not returning KPCAA3DCoordinateComponents and also add doc.
    public func rectangularCoordinates(_ apparent: Bool = true) -> GalileanMoonRectangularCoordinates {
        let components = (apparent == true) ? self.details.ApparentRectangularCoordinateComponents : self.details.TrueRectangularCoordinateComponents
        return GalileanMoonRectangularCoordinates(components: components)
    }
}

