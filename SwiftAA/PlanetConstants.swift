//
//  PlanetConstants.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 06/11/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

/// Source: http://nssdc.gsfc.nasa.gov/planetary/planetfact.html

import Foundation

public typealias KilogramPerCubicMeter = Double
public typealias MeterPerSquareSecond = Double
public typealias KilometerPerSecond = Double
public typealias MeterE9 = Double

public protocol PlanetConstants {
    var mass: Kilogram { get }
    var diameter: Meter { get }
    var density: KilogramPerCubicMeter { get }
    var gravity: MeterPerSquareSecond { get }
    var escapeVelocity: KilometerPerSecond { get }
    var rotationPeriod: Hour { get }
    var lengthOfDay: Hour { get }
    var distanceFromSun: MeterE9 { get }
    var perihelion: MeterE9 { get }
    var aphelion: MeterE9 { get }
    var orbitalPeriod: Day { get }
    var orbitalVelocity: KilometerPerSecond { get }
    var orbitalInclination: Degree { get }
    var orbitalEccentricity: Double { get }
    var obliquityToOrbit: Degree { get }
    var meanTemperature: Celsius { get }
    var surfacePressure: Double { get }
    var numberOfMoons: Int { get }
    var ringSystem: Bool { get }
    var globalMagneticField: Bool { get }
}

public struct JupiterConstants: PlanetConstants {
    public let mass: Kilogram = 1.898e27
    public let diameter: Meter = 142984000.0
    public let density: KilogramPerCubicMeter = 1326.0
    public let gravity: MeterPerSquareSecond = 23.1
    public let escapeVelocity: KilometerPerSecond = 59.5
    public let rotationPeriod: Hour = 9.9
    public let lengthOfDay: Hour = 9.9
    public let distanceFromSun: MeterE9 = 778.6
    public let perihelion: MeterE9 = 740.5
    public let aphelion: MeterE9 = 816.6
    public let orbitalPeriod: Day = 4331.0
    public let orbitalVelocity: KilometerPerSecond = 13.1
    public let orbitalInclination: Degree = 1.3
    public let orbitalEccentricity: Double = 0.049
    public let obliquityToOrbit: Degree = 3.1
    public let meanTemperature: Celsius = -110
    public let surfacePressure: Double
    public let numberOfMoons: Int = 67
    public let ringSystem: Bool = true
    public let globalMagneticField: Bool = true
}
