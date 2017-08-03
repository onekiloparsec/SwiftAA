//
//  Magnitudes.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/09/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public extension SpaceMagnitude {
    public func combine(with m2: SpaceMagnitude) -> SpaceMagnitude {
        return SpaceMagnitude(KPCAAStellarMagnitudes_CombinedMagnitude(self.value, m2.value))
    }
    
    public func brightnessRatio(with m2: SpaceMagnitude) -> Double {
        return KPCAAStellarMagnitudes_BrightnessRatio(self.value, m2.value)
    }

    public func distance(forAbsoluteMagnitude M: SpaceMagnitude, visualAbsorption Av: SpaceMagnitude = 0.0) -> Parsec {
        return Parsec(pow(10.0, (self.value + 5.0 - M.value - Av.value)/5.0))
    }
    
    static public func magnitudeDifference(forBrightnessRatio r: Double) -> SpaceMagnitude {
        return SpaceMagnitude(KPCAAStellarMagnitudes_MagnitudeDifference(r))
    }
}
