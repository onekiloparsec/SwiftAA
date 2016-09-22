//
//  Neptune.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public class Neptune: Planet {
    public class override var averageColor: Color {
        get { return Color(red: 0.392, green:0.518, blue:0.871, alpha: 1.0) }
    }

    public var magnitude: Double {
        get { return KPCAAIlluminatedFraction_NeptuneMagnitudeAA(self.radiusVector, self.apparentGeocentricDistance) }
    }
}

