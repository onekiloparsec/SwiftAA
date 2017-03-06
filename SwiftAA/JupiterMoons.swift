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

/// The GalileanMoon struct encompasses all properties of Galilean moons
public struct GalileanMoon {
    fileprivate var details: KPCAAGalileanMoonDetails

    /// The name of the Moon
    public var name: String

    public var MeanLongitude: Degree { get { return Degree(self.details.MeanLongitude) } }
    public var TrueLongitude: Degree { get { return Degree(self.details.TrueLongitude) } }
    public var TropicalLongitude: Degree { get { return Degree(self.details.TropicalLongitude) } }
    public var EquatorialLatitude: Degree { get { return Degree(self.details.EquatorialLatitude) } }

    public var radiusVector: AstronomicalUnit { get { return AstronomicalUnit(self.details.r) } }

    /// Returns whether the Moon is in transit or not (i.e. in front of Jupiter disk).
    public var inTransit: Bool { get { return self.details.inTransit.boolValue } }
    
    /// Returns whether the Moon is in occultation or not (i.e. behind the Jupiter disk).
    public var inOccultation: Bool { get { return self.details.inOccultation.boolValue } }

    /// Returns whether the Moon is eclipsing Jupiter.
    public var inEclipse: Bool { get { return self.details.inEclipse.boolValue } }
    
    /// Returns whether the Moon is eclipsed by Jupiter.
    public var inShadowTransit: Bool { get { return self.details.inShadowTransit.boolValue } }

    /// Returns a GalileanMoon object
    ///
    /// - Parameters:
    ///   - name: the name of the Moon
    ///   - details: the details of the moon. See Jupiter class.
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

