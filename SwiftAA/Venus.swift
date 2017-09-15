//
//  Venus.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  MIT Licence. See LICENCE file.
//

import Foundation

/// The Venus planet
public class Venus: Planet {
    
    /// The average color of the planet.
    public class override var averageColor: Color {
        get { return Color(red: 0.784, green:0.471, blue:0.137, alpha: 1.0) }
    }
}
