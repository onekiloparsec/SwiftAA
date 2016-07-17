//
//  Saturn.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Saturn: Planet {
    public static var color: Color {
        get { return Color(red: 0.941, green:0.827, blue:0.616, alpha: 1.0) }
    }

    public private(set) var julianDay: JulianDay
    public private(set) var highPrecision: Bool
    
    public init(julianDay: JulianDay, highPrecision: Bool = true) {
        self.julianDay = julianDay
        self.highPrecision = highPrecision
    }
    
    public init(date: NSDate, highPrecision: Bool = true) {
        self.init(julianDay: KPCAADate(gregorianCalendarDate: date).Julian(), highPrecision: highPrecision)
    }
    
    func ringsDetails(highPrecision: Bool = true) -> KPCAASaturnRingDetails {
        return KPCAASaturnRings_Calculate(self.julianDay, highPrecision)
    }
    
    func moonsDetails(highPrecision: Bool = true) -> KPCAASaturnMoonsDetails {
        return KPCAASaturnMoonsDetails_Calculate(self.julianDay, highPrecision)
    }
}

