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
        return Magnitude(KPCAAStellarMagnitudes_CombinedMagnitude(self.value, m2.value))
    }
    
    public func brightnessRatio(withMagnitude m2: Magnitude) -> Double {
        return KPCAAStellarMagnitudes_BrightnessRatio(self.value, m2.value)
    }

    public func distance(forAbsoluteMagnitude M: Magnitude, visualAbsorption Av: Double = 0.0) -> Parsec {
        return Parsec(pow(10.0, (self.value + 5.0 - M.value - Av)/5.0))
    }
    
    static public func magnitudeDifference(forBrightnessRatio r: Double) -> Double {
        return KPCAAStellarMagnitudes_MagnitudeDifference(r)
    }
}
