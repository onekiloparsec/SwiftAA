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
 *  planets, moons, the Earth, the Sun etc.
 */
public protocol ObjectBase {
    
    /// The julian day at which one considers the object.
    var julianDay: JulianDay { get }
    
    /// A boolean indicating whether high precision (i.e. VSOP87 theory) must be used.
    var highPrecision: Bool { get }
    
    /// The object name
    var name: String { get }

    /**
     Initialization of an object
     
     - parameter julianDay:     The julian day at which one will consider the object
     - parameter highPrecision: If true, the VSOP87 theory will be used to increase precision significantly.
     
     - returns: A new instance of a ObjectBase object
     */
    init(julianDay: JulianDay, highPrecision: Bool)    
}

/// The base class of all objects (Planets, Sun, Moons etc.).
open class Object : ObjectBase {
    public fileprivate(set) var julianDay: JulianDay
    public fileprivate(set) var highPrecision: Bool
    
    /// A convenience accesor returning the name of the object class.
    public var name: String {
         return String(describing: type(of: self)) 
    }

    /// Returns a new instance of the object.
    ///
    /// - Parameters:
    ///   - julianDay: The julian day at which one will consider the object
    ///   - highPrecision: A optional boolean indicating whether high precision (i.e. VSOP87 theory) must be used. 
    ///     Default is true.
    public required init(julianDay: JulianDay, highPrecision: Bool = true) {
        self.julianDay = julianDay
        self.highPrecision = highPrecision
    }
}
