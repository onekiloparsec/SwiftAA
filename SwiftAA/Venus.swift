//
//  Venus.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public class Venus: Planet {
    public class override var averageColor: Color {
        get { return Color(red: 0.784, green:0.471, blue:0.137, alpha: 1.0) }
    }
    
    public var magnitude: Double {
        get { return KPCAAIlluminatedFraction_VenusMagnitudeAA(self.radiusVector, self.apparentGeocentricDistance, self.phaseAngle) }
    }
}
