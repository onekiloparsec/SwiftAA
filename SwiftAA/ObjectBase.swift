//
//  ObjectBase.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/07/16.
//  MIT Licence. See LICENCE file.
//

import Foundation

/// Base protocol used by all types of astronomical objects considered in SwiftAA,
/// planets, moons, the Earth, the Sun etc.
public protocol ObjectBase {
    
    /// The julian day at which one considers the object.
    var julianDay: JulianDay { get }
    
    /// A boolean indicating whether high precision (i.e. VSOP87 theory) must be used.
    var highPrecision: Bool { get }
    
    /// The object name
    var name: String { get }

    /// Creates an object instance
    ///
    /// - Parameters:
    ///   - julianDay: The julian day at which one will consider the object
    ///   - highPrecision: If true (default), the VSOP87 theory is used when relevant to increase precision 
    ///     significantly. Is probably computationally slower compared to low-precision algorithms.
    init(julianDay: JulianDay, highPrecision: Bool)
}

/// The base class of all objects (Planets, Sun, Moons etc.).
open class Object : ObjectBase {
    /// The Julian Day at which the object is considered.
    public fileprivate(set) var julianDay: JulianDay
    
    /// The precision flag.
    public fileprivate(set) var highPrecision: Bool
    
    /// A convenience accesor returning the name of the object class.
    public var name: String {
         return String(describing: type(of: self)) 
    }

    /// Creates a new instance of the object.
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
