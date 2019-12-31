//
//  Magnitudes.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/09/16.
//  MIT Licence. See LICENCE file.
//

import Foundation
import ObjCAA

public extension Magnitude {
    /// Combine two magnitudes.
    ///
    /// - Parameter m2: The secondary magnitude
    /// - Returns: The combined magnitude.
    func combine(with m2: Magnitude) -> Magnitude {
        return Magnitude(KPCAAStellarMagnitudes_CombinedMagnitude(self.value, m2.value))
    }
    
    /// Compute the brightness ratio, for a given secondary magnitude.
    ///
    /// - Parameter m2: The other magnitude.
    /// - Returns: The brightness ratio.
    func brightnessRatio(with m2: Magnitude) -> Double {
        return KPCAAStellarMagnitudes_BrightnessRatio(self.value, m2.value)
    }

    /// Compute the geometrical distance, in parsec, for the current apparent magnitude.
    ///
    /// - Parameters:
    ///   - M: The absolute magnitude of the object.
    ///   - Av: The visual absorption factor.
    /// - Returns: The distance, in parsec.
    func distance(forAbsoluteMagnitude M: Magnitude, visualAbsorption Av: Magnitude = 0.0) -> Parsec {
        return Parsec(pow(10.0, (self.value + 5.0 - M.value - Av.value)/5.0))
    }
    
    /// Compute the magnitude difference for a given brightness ratio.
    ///
    /// - Parameter r: The brightness ratio.
    /// - Returns: The magnitude difference.
    static func magnitudeDifference(forBrightnessRatio r: Double) -> Magnitude {
        return Magnitude(KPCAAStellarMagnitudes_MagnitudeDifference(r))
    }
}
