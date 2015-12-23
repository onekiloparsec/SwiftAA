//
//  AA2DCoordinate.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 23/12/15.
//  Copyright © 2015 onekiloparsec. All rights reserved.
//

import Foundation

public struct AA2DCoordinates {
    var X: Double;
    var Y: Double;

    public init(X: Double = 0, Y: Double = 0) {
        self.X = X;
        self.Y = Y;
    }
    
    public init(components: KPCAA2DCoordinateComponents) {
        self.X = components.X;
        self.Y = components.Y;
    }
}