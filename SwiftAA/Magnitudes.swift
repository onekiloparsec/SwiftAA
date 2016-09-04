//
//  Magnitudes.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/09/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public extension Magnitude {
    public func combine(withMagnitude m2: Magnitude) -> Magnitude {
        return KPCAAStellarMagnitudes_CombinedMagnitude(self, m2)
    }
    
    public func brightnessRatio(withMagnitude m2: Magnitude) -> Double {
        return KPCAAStellarMagnitudes_BrightnessRatio(self, m2)
    }

    public func distance(forAbsoluteMagnitude M: Magnitude, visualAbsorption Av: Double = 0.0) -> Parsec {
        return pow(10.0, (m + 5.0 - M - Av)/5.0)
    }
    
    static public func magnitudeDifference(forBrightnessRatio r: Double) -> Double {
        return KPCAAStellarMagnitudes_MagnitudeDifference(r)
    }
}
