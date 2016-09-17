//
//  ObjectBase.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/07/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

/**
 *  This protocol aims at providing the base used by all types of astronomical objects considered in SwiftAA,
 *  planets, moons etc.
 */
public protocol ObjectBase {
    var julianDay: JulianDay { get }
    var highPrecision: Bool { get }
    
    /**
     Initialization of an object
     
     - parameter julianDay:     The julian day at which one will consider the object
     - parameter highPrecision: If true, the VSOP87 theory will be used to increase precision significantly.
     
     - returns: A new instance of a ObjectBase object
     */
    init(julianDay: JulianDay, highPrecision: Bool)    
}
