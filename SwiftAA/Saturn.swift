//
//  Saturn.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Saturn: Planet {
    public var julianDay: JulianDay
    public var eclipticObject: KPCEclipticObject { return .Saturn }
    public var planet: KPCPlanetaryObject { return .SATURN }
    
    public init(julianDay: JulianDay) {
        self.julianDay = julianDay
    }
    
    public var color: Color {
        get { return Color(red: 145.0/255.0, green:139.0/255.0, blue:129.0/255.0, alpha: 1.0) }
    }
    
    func ringsDetails(highPrecision: Bool = true) -> KPCAASaturnRingDetails {
        return KPCAASaturnRings_Calculate(self.julianDay, highPrecision)
    }
    
    func moonsDetails(highPrecision: Bool = true) -> KPCAASaturnMoonsDetails {
        return KPCAASaturnMoonsDetails_Calculate(self.julianDay, highPrecision)
    }
}

