//
//  Pluto.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  MIT Licence. See LICENCE file.
//

import Foundation

/// The Pluto dwarf planet.
public class Pluto: DwarfPlanet {
    /// The average color of the planet.
    public class var averageColor: Color {
        return Color(red: 0.776, green: 0.620, blue: 0.486, alpha: 1.0)
    }

    public var magnitude: Magnitude {
        return Magnitude(-1.00 + 5*log10(self.radiusVector.value*self.allPlanetaryDetails.ApparentGeocentricDistance))
    }
}
