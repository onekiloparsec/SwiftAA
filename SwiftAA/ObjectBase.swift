//
//  ObjectBase.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/07/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public protocol ObjectBase {
    var julianDay: JulianDay { get }
    var highPrecision: Bool { get }
    
    /**
     Initialization of an object
     
     - parameter julianDay:     The julian day at which one will consider the object
     - parameter highPrecision: If true, the VSOP87 theory will be used to increase precision significantly.
     
     - returns: A new instance of a PlanetaryBase object
     */
    init(julianDay: JulianDay, highPrecision: Bool)
    
    /**
     Initialization of an object
     
     - parameter date:          The date at which one will consider the object
     - parameter highPrecision: If true, the VSOP87 theory will be used to increase precision significantly.
     
     - returns: A new instance of a PlanetaryBase object
     */
    init(date: NSDate, highPrecision: Bool)
}