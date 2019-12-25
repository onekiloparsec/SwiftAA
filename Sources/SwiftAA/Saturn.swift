//
//  Saturn.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  MIT Licence. See LICENCE file.
//

import Foundation
import ObjCAA

/// The Saturn planet.
public class Saturn: Planet {
    
    /// The average color of the planet.
    public class override var averageColor: Color {
        get { return Color(red: 0.941, green:0.827, blue:0.616, alpha: 1.0) }
    }

    public fileprivate(set) var Mimas: SaturnianMoon
    public fileprivate(set) var Enceladus: SaturnianMoon
    public fileprivate(set) var Tethys: SaturnianMoon
    public fileprivate(set) var Dione: SaturnianMoon
    public fileprivate(set) var Rhea: SaturnianMoon
    public fileprivate(set) var Titan: SaturnianMoon
    public fileprivate(set) var Hyperion: SaturnianMoon
    public fileprivate(set) var Iapetus: SaturnianMoon

    public fileprivate(set) var ringSystem: SaturnRingSystem

    /// The list of saturnian moons, in increasing order of distance from the planet.
    public var moons: [SaturnianMoon] {
        get { return [self.Mimas, self.Enceladus, self.Tethys, self.Dione, self.Rhea, self.Titan, self.Hyperion, self.Iapetus] }
    }
    
    /// Returns a Saturn object.
    ///
    /// - Parameters:
    ///   - julianDay: The julian day at which the planet is considered.
    ///   - highPrecision: A boolean indicating whether high precision (VSOP87 theory) must be used. Default is true.
    public required init(julianDay: JulianDay, highPrecision: Bool = true) {
        let details = KPCAASaturnMoonsDetails_Calculate(julianDay.value, highPrecision)
        self.Mimas = SaturnianMoon(name: "Mimas", details: details.Satellite1, synodicPeriod: 0.9425, visualMagnitude: 12.9, diameter: 400.0)
        self.Enceladus = SaturnianMoon(name: "Enceladus", details: details.Satellite2, synodicPeriod: 1.3704, visualMagnitude: 11.7, diameter: 498)
        self.Tethys = SaturnianMoon(name: "Tethys", details: details.Satellite3, synodicPeriod: 1.8881, visualMagnitude: 10.2, diameter: 1046.0)
        self.Dione = SaturnianMoon(name: "Dione", details: details.Satellite4, synodicPeriod: 2.7376, visualMagnitude: 10.4, diameter: 1120.0)
        self.Rhea = SaturnianMoon(name: "Rhea", details: details.Satellite5, synodicPeriod: 4.5194, visualMagnitude: 9.7, diameter: 1528.0)
        self.Titan = SaturnianMoon(name: "Titan", details: details.Satellite6, synodicPeriod: 15.9691, visualMagnitude: 8.3, diameter: 5150.0)
        self.Hyperion = SaturnianMoon(name: "Hyperion", details: details.Satellite7, synodicPeriod: 21.3188, visualMagnitude: 14.2, diameter: 286.0)
        self.Iapetus = SaturnianMoon(name: "Iapetus", details: details.Satellite8, synodicPeriod: 79.9202, visualMagnitude: 10.2, diameter: 1460.0)
        
        let ringDetails = KPCAASaturnRings_Calculate(julianDay.value, highPrecision)
        self.ringSystem = SaturnRingSystem(ringDetails, julianDay: julianDay)
        
        super.init(julianDay: julianDay, highPrecision: highPrecision)
    }
    
    /// The magnitude of the planet. Includes the contribution from the ring.
    public var magnitude: Magnitude {
        get { return Magnitude(KPCAAIlluminatedFraction_SaturnMagnitudeAA(self.radiusVector.value,
                                                                self.apparentGeocentricDistance.value,
                                                                self.ringSystem.saturnicentricSunEarthLongitudesDifference.value,
                                                                self.ringSystem.earthCoordinates.latitude.value)) } }
    
    /// The magnitude 'Muller' of the planet. Includes the contribution from the ring.
    public var magnitudeMuller: Magnitude {
        get { return Magnitude(KPCAAIlluminatedFraction_SaturnMagnitudeMuller(self.radiusVector.value,
                                                                    self.apparentGeocentricDistance.value,
                                                                    self.ringSystem.saturnicentricSunEarthLongitudesDifference.value,
                                                                    self.ringSystem.earthCoordinates.latitude.value)) } }
}

