//
//  Mercury.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public class Mercury: Planet {
    public class override var averageColor: Color {
        get { return Color(red: 0.569, green:0.545, blue:0.506, alpha: 1.0) }
    }
    
    public var magnitude: Double {
        get { return KPCAAIlluminatedFraction_MercuryMagnitudeAA(self.radiusVector,
                                                                 self.apparentGeocentricDistance,
                                                                 self.phaseAngle) }
    }
}
