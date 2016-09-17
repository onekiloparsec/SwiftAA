//
//  Uranus.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Uranus: Planet {
    public static var color: Color {
        get { return Color(red: 0.639, green:0.804, blue:0.839, alpha: 1.0) }
    }
 
    public fileprivate(set) var julianDay: JulianDay
    public fileprivate(set) var highPrecision: Bool
    
    public init(julianDay: JulianDay, highPrecision: Bool = true) {
        self.julianDay = julianDay
        self.highPrecision = highPrecision
    }
        
    public var magnitude: Double { get { return KPCAAIlluminatedFraction_UranusMagnitudeAA(self.radiusVector, self.apparentGeocentricDistance) } }
}
