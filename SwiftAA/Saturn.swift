//
//  Saturn.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

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
    public fileprivate(set) var Iapetus: SaturnianMoon

    public fileprivate(set) var ringSystem: SaturnRingSystem

    /// The list of saturnian moons, in increasing order of distance from the planet.
    public var moons: [SaturnianMoon] {
        get { return [self.Mimas, self.Enceladus, self.Tethys, self.Dione, self.Rhea, self.Titan, self.Iapetus] }
    }
    
    /// Returns a Saturn object.
    ///
    /// - Parameters:
    ///   - julianDay: The julian day at which the planet is considered.
    ///   - highPrecision: A boolean indicating whether high precision (VSOP87 theory) must be used. Default is true.
    public required init(julianDay: JulianDay, highPrecision: Bool = true) {
        let details = KPCAASaturnMoonsDetails_Calculate(julianDay.value, highPrecision)
        self.Mimas = SaturnianMoon(name: "Mimas", details: details.Satellite1)
        self.Enceladus = SaturnianMoon(name: "Enceladus", details: details.Satellite2)
        self.Tethys = SaturnianMoon(name: "Tethys", details: details.Satellite3)
        self.Dione = SaturnianMoon(name: "Dione", details: details.Satellite4)
        self.Rhea = SaturnianMoon(name: "Rhea", details: details.Satellite5)
        self.Titan = SaturnianMoon(name: "Titan", details: details.Satellite6)
        self.Iapetus = SaturnianMoon(name: "Iapetus", details: details.Satellite7)
        
        let ringDetails = KPCAASaturnRings_Calculate(julianDay.value, highPrecision)
        self.ringSystem = SaturnRingSystem(ringDetails)
        
        super.init(julianDay: julianDay, highPrecision: highPrecision)
    }
    
    /// The magnitude of the planet. Includes the contribution from the ring.
    public var magnitude: Double {
        get { return KPCAAIlluminatedFraction_SaturnMagnitudeAA(self.radiusVector.value,
                                                                self.apparentGeocentricDistance.value,
                                                                self.ringSystem.saturnicentricSunEarthLongitudesDifference.value,
                                                                self.ringSystem.saturnicentricEarthLatitude.value) } }
    
    /// The magnitude 'Muller' of the planet. Includes the contribution from the ring.
    public var magnitudeMuller: Double {
        get { return KPCAAIlluminatedFraction_SaturnMagnitudeMuller(self.radiusVector.value,
                                                                    self.apparentGeocentricDistance.value,
                                                                    self.ringSystem.saturnicentricSunEarthLongitudesDifference.value,
                                                                    self.ringSystem.saturnicentricEarthLatitude.value) } }
}

