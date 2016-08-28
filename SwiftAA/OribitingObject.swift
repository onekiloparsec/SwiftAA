//
//  OribitingObject.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 28/08/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public protocol OrbitingObject {
    /// The ecliptic (=heliocentric) longitude of the object
    var eclipticLongitude: Degrees { get }
    
    /// The ecliptic (=heliocentric) latitude of the object
    var eclipticLatitude: Degrees { get }
    
    /// The radius vector (=distance to the Sun)
    var radiusVector: AU { get }
}

