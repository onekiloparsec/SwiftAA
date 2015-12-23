//
//  AA3DCoordinate.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 23/12/15.
//  Copyright © 2015 onekiloparsec. All rights reserved.
//

import Foundation

public struct AA3DCoordinates {
    var X: Double;
    var Y: Double;
    var Z: Double;
    
    public init(X: Double, Y: Double, Z: Double) {
        self.X = X;
        self.Y = Y;
        self.Z = Z;
    }
    
    public init(components: KPCAA3DCoordinateComponents) {
        self.X = components.X;
        self.Y = components.Y;
        self.Z = components.Z;
    }
}