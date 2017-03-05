//
//  Uranus.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

/// The Uranus planet
public class Uranus: Planet {
    
    /// The average color of the planet
    public class override var averageColor: Color {
        get { return Color(red: 0.639, green:0.804, blue:0.839, alpha: 1.0) }
    } 
}
