//
//  Moon.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 28/08/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Moon : ObjectBase, OrbitingObject {
    public private(set) var julianDay: JulianDay
    public private(set) var highPrecision: Bool
    
    public init(julianDay: JulianDay, highPrecision: Bool = true) {
        self.julianDay = julianDay
        self.highPrecision = highPrecision
    }
    
    public init(date: NSDate, highPrecision: Bool = true) {
        self.init(julianDay: KPCAADate(gregorianCalendarDate: date).Julian(), highPrecision: highPrecision)
    }
    
    // MARK: - OrbitingObject
    
    public var eclipticLongitude: Degrees {
        get { return KPCAAMoon_EclipticLongitude(self.julianDay) }
    }
    
    public var eclipticLatitude: Degrees {
        get { return KPCAAMoon_EclipticLatitude(self.julianDay) }
    }
    
    public var radiusVector: AU {
        get { return KPCAAMoon_RadiusVector(self.julianDay) }
    }
    
    // MARK: - KPCAAMoon

    public var meanLongitude: Degrees {
        get { return KPCAAMoon_MeanLongitude(self.julianDay) }
    }

    public var meanElongation: Degrees {
        get { return KPCAAMoon_MeanElongation(self.julianDay) }
    }

    public var meanAnomaly: Degrees {
        get { return KPCAAMoon_MeanAnomaly(self.julianDay) }
    }

    public var argumentOfLatitude: Degrees {
        get { return KPCAAMoon_ArgumentOfLatitude(self.julianDay) }
    }

    public var meanLongitudeOfAscendingNode: Degrees {
        get { return KPCAAMoon_MeanLongitudeAscendingNode(self.julianDay) }
    }

    public var meanLongitudeOfPerigee: Degrees {
        get { return KPCAAMoon_MeanLongitudePerigee(self.julianDay) }
    }

    public var trueLongitudeOfAscendingNode: Degrees {
        get { return KPCAAMoon_TrueLongitudeAscendingNode(self.julianDay) }
    }

    // MARK: - Statics
    
    static func horizontalParallax(fromRadiusVector radiusVector: AU) -> Degrees {
        return KPCAAMoon_RadiusVectorToHorizontalParallax(radiusVector)
    }
    
    static func radiusVector(fromHorizontalParallax parallax: Degrees) -> AU {
        return KPCAAMoon_HorizontalParallaxToRadiusVector(parallax)
    }
}