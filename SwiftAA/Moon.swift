//
//  Moon.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 28/08/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

//public struct Moon : ObjectBase, OrbitingObject {
//    public fileprivate(set) var julianDay: JulianDay
//    public fileprivate(set) var highPrecision: Bool
//    
//    public let diameter: Meters = 3476000.0
//
//    public init(julianDay: JulianDay, highPrecision: Bool = true) {
//        self.julianDay = julianDay
//        self.highPrecision = highPrecision
//    }
//        
//    // MARK: - OrbitingObject
//    
//    public var eclipticLongitude: Degrees {
//        get { return KPCAAMoon_EclipticLongitude(self.julianDay) }
//    }
//    
//    public var eclipticLatitude: Degrees {
//        get { return KPCAAMoon_EclipticLatitude(self.julianDay) }
//    }
//    
//    public var radiusVector: AU {
//        get { return KPCAAMoon_RadiusVector(self.julianDay) }
//    }
//    
//    // MARK: - KPCAAMoon
//
//    public var meanLongitude: Degrees {
//        get { return KPCAAMoon_MeanLongitude(self.julianDay) }
//    }
//
//    public var meanElongation: Degrees {
//        get { return KPCAAMoon_MeanElongation(self.julianDay) }
//    }
//
//    public var meanAnomaly: Degrees {
//        get { return KPCAAMoon_MeanAnomaly(self.julianDay) }
//    }
//
//    public var argumentOfLatitude: Degrees {
//        get { return KPCAAMoon_ArgumentOfLatitude(self.julianDay) }
//    }
//
//    public var meanLongitudeOfAscendingNode: Degrees {
//        get { return KPCAAMoon_MeanLongitudeAscendingNode(self.julianDay) }
//    }
//
//    public var meanLongitudeOfPerigee: Degrees {
//        get { return KPCAAMoon_MeanLongitudePerigee(self.julianDay) }
//    }
//
//    public var trueLongitudeOfAscendingNode: Degrees {
//        get { return KPCAAMoon_TrueLongitudeAscendingNode(self.julianDay) }
//    }
//
//    // MARK: - Statics
//    
//    static func horizontalParallax(fromRadiusVector radiusVector: AU) -> Degrees {
//        return KPCAAMoon_RadiusVectorToHorizontalParallax(radiusVector)
//    }
//    
//    static func radiusVector(fromHorizontalParallax parallax: Degrees) -> AU {
//        return KPCAAMoon_HorizontalParallaxToRadiusVector(parallax)
//    }
//    
//    // MARK: - KPCAAMoonPhases
//
//    func timeOfPhase(forPhase ph: MoonPhase, mean: Bool = true) -> JulianDay {
//        var k = round(KPCAAMoonPhases_K(Double(self.julianDay.date().fractionalYear)))
//        switch ph {
//        case .new:
//            k = k + 0.0
//        case .firstQuarter:
//            k = k + 0.25
//        case .full:
//            k = k + 0.50
//        case .lastQuarter: 
//            k = k + 0.75
//        }
//        return mean ? KPCAAMoonPhases_MeanPhase(k) : KPCAAMoonPhases_TruePhase(k)
//    }
//}
//
//
