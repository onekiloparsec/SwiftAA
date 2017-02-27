//
//  Magnitudes.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/09/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public extension Magnitude {
    public func combine(with m2: Magnitude) -> Magnitude {
        return Magnitude(KPCAAStellarMagnitudes_CombinedMagnitude(self.value, m2.value))
    }
    
    public func brightnessRatio(with m2: Magnitude) -> Double {
        return KPCAAStellarMagnitudes_BrightnessRatio(self.value, m2.value)
    }

    public func distance(forAbsoluteMagnitude M: Magnitude, visualAbsorption Av: Magnitude = 0.0) -> Parsec {
        return Parsec(pow(10.0, (self.value + 5.0 - M.value - Av.value)/5.0))
    }
    
    static public func magnitudeDifference(forBrightnessRatio r: Double) -> Magnitude {
        return Magnitude(KPCAAStellarMagnitudes_MagnitudeDifference(r))
    }
}
