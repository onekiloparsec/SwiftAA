//
//  Coordinates.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/07/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct EquatorialCoordinates {
    private(set) var rightAscension: Hour
    private(set) var declination: Degrees
    public let epoch: Double
    
    var alpha: Hour {
        get { return self.rightAscension }
        set { self.rightAscension = newValue }
    }
    
    var delta: Degrees {
        get { return self.declination }
        set { self.declination = newValue }
    }
    
    init(alpha: Hour, delta: Degrees, epsilon: Double) {
        self.rightAscension = alpha
        self.declination = delta
        self.epoch = epsilon
    }
    
    func toEclipticCoordinates() -> EclipticCoordinates {
        let components = KPCAACoordinateTransformation_Equatorial2Ecliptic(self.rightAscension, self.declination, self.epoch)
        return EclipticCoordinates(lambda: components.X, beta: components.Y, epsilon: self.epoch)
    }
    
    func toGalacticCoordinates() -> GalacticCoordinates {
        let components = KPCAACoordinateTransformation_Equatorial2Galactic(self.rightAscension, self.declination)
        return GalacticCoordinates(l: components.X, b: components.Y)
    }
    
    func precessedCoordinates(to newEpoch: Double) -> EquatorialCoordinates {
        let components = KPCAAPrecession_PrecessEquatorial(self.rightAscension, self.declination, self.epoch, newEpoch)
        return EquatorialCoordinates(alpha: components.X, delta: components.Y, epsilon: newEpoch)
    }
}

public struct EclipticCoordinates {
    private(set) var celestialLongitude: Degrees
    private(set) var celestialLatitude: Degrees
    public let epoch: Double
    
    var lambda: Degrees {
        get { return self.celestialLongitude }
        set { self.celestialLongitude = newValue }
    }
    
    var beta: Degrees {
        get { return self.celestialLatitude }
        set { self.celestialLatitude = newValue }
    }
    
    init(lambda: Hour, beta: Degrees, epsilon: Double) {
        self.celestialLongitude = lambda
        self.celestialLatitude = beta
        self.epoch = epsilon
    }
    
    func precessedCoordinates(to newEpoch: Double) -> EclipticCoordinates {
        let components = KPCAAPrecession_PrecessEcliptic(self.celestialLongitude, self.celestialLatitude, self.epoch, newEpoch)
        return EclipticCoordinates(lambda: components.X, beta: components.Y, epsilon: newEpoch)
    }
}

public struct GalacticCoordinates {
    private(set) var galacticLongitude: Degrees
    private(set) var galacticLatitude: Degrees
    
    var l: Degrees {
        get { return self.galacticLongitude }
        set { self.galacticLongitude = newValue }
    }
    
    var b: Degrees {
        get { return self.galacticLatitude }
        set { self.galacticLatitude = newValue }
    }

    init(l: Degrees, b: Degrees) {
        self.galacticLongitude = l
        self.galacticLatitude = b
    }
}
