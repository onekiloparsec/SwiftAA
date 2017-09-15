//
//  Aberration.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/10/2016.
//  MIT Licence. See LICENCE file.
//

import Foundation

public extension EclipticCoordinates {
    
    /// Return new ecliptic coordinates corrected for the annual aberration of the Earth.
    /// See AA, p149.
    ///
    /// - parameter julianDay:     The julian day of
    /// - parameter highPrecision: `true` if one wants high precision
    ///
    /// - returns: Corected ecliptic coordinates of the star.
    public func correctedForAnnualAberration(julianDay: JulianDay, highPrecision: Bool = true) -> EclipticCoordinates {
        let diff = KPCAAAberration_EclipticAberration(self.lambda.value, self.beta.value, julianDay.value, highPrecision)
        return EclipticCoordinates(lambda: Degree(self.lambda.value+diff.X), beta: Degree(self.beta.value+diff.Y), epoch: self.epoch)
    }
}
