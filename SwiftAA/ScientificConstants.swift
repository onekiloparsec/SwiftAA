//
//  ScientificConstants.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 17/12/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public let ModifiedJulianDayZero = 2400000.5
public let JulianYear: Day = 365.25            // See p.133 of AA.
public let BesselianYear: Day = 365.2421988    // See p.133 of AA.
public let JulianDayB1950: JulianDay = 2433282.4235	// See p.133 of AA.

public let StandardEpoch_J2000_0 = 2451545.0 // See p.133 of AA.
public let StandardEpoch_B1950_0 = 2433282.4235 // See p.133 of AA.

public let UNDEFINED_SCIENTIFIC_VALUE = -999999999999.0

public typealias Parsec=Double // parsecs
public typealias Kilogram=Double
public typealias Day=Double
public typealias Magnitude=Double
public typealias Celsius=Double
public typealias Millibar=Double

public enum Equinox {
    case meanEquinoxOfTheDate
    case standardJ2000
}

public enum Season {
    case spring
    case summer
    case autumn
    case winter
}

public enum MoonPhase {
    case new
    case firstQuarter
    case full
    case lastQuarter
}
