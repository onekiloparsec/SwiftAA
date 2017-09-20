//
//  Aberration.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/10/2016.
//  MIT Licence. See LICENCE file.
//

import Foundation

public extension EquatorialCoordinates {
    
    /// Return new ecliptic coordinates corrected for the annual aberration of the Earth. It must be used for star coordinates, not planets.
    /// See AA, p149.
    ///
    /// - parameter julianDay:     The julian day for which the aberration is computed.
    /// - parameter highPrecision: If `false`, the Ron-Vondrák algorithm is used. See AA p.153. If `true`, the newer VSOP87 theory is used.
    ///
    /// - returns: Corected ecliptic coordinates of the star.
    public func correctedForAnnualAberration(julianDay: JulianDay, highPrecision: Bool = true) -> EquatorialCoordinates {
        let diff = KPCAAAberration_EquatorialAberration(self.alpha.value, self.delta.value, julianDay.value, highPrecision)
        return EquatorialCoordinates(alpha: Hour(self.alpha.value+diff.X), delta: Degree(self.delta.value+diff.Y), epoch: self.epoch)
    }
}

public extension EclipticCoordinates {
    
    /// Return new ecliptic coordinates corrected for the annual aberration of the Earth. It must be used for star coordinates, not planets.
    /// See AA, p149.
    ///
    /// - parameter julianDay:     The julian day for which the aberration is computed.
    /// - parameter highPrecision: If `false`, the Ron-Vondrák algorithm is used. See AA p.153. If `true`, the newer VSOP87 theory is used.OSun
    ///
    /// - returns: Corected ecliptic coordinates of the star.
    public func correctedForAnnualAberration(julianDay: JulianDay, highPrecision: Bool = true) -> EclipticCoordinates {
        let diff = KPCAAAberration_EclipticAberration(self.lambda.value, self.beta.value, julianDay.value, highPrecision)
        return EclipticCoordinates(lambda: Degree(self.lambda.value+diff.X), beta: Degree(self.beta.value+diff.Y), epoch: self.epoch)
    }
}
