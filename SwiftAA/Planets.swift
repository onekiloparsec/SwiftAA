//
//  Planets.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 03/07/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

// To be understood as a "non-Earth" planet
public class Planet: Object, CelestialBody, PlanetaryBase, PlanetaryPhenomena, ElementsOfPlanetaryOrbit, EllipticalPlanetaryDetails, IlluminatedFraction  {

    public class var averageColor: Color {
        get { return Color.white }
    }
        
    public lazy var planetaryDetails: KPCAAEllipticalPlanetaryDetails = {
        [unowned self] in
        return KPCAAElliptical_CalculatePlanetaryDetails(self.julianDay.value, self.planetaryObject, self.highPrecision)
        }()
    
    public lazy var ellipticalObjectDetails: KPCAAEllipticalObjectDetails = {
        [unowned self] in
        return KPCAAElliptical_CalculateObjectDetailsNoElements(self.julianDay.value, self.highPrecision)
        }()
    
    public var equatorialCoordinates: EquatorialCoordinates {
        get { return self.eclipticCoordinates.toEquatorialCoordinates() }
    }
    
    public var apparentEquatorialCoordinates: EquatorialCoordinates {
        get {
            let ra = Hour(planetaryDetails.ApparentGeocentricRA)
            let dec = Degree(planetaryDetails.ApparentGeocentricDeclination)
            let result = EquatorialCoordinates(alpha: ra, delta: dec)
            return result
        }
    }
    
    public var eclipticCoordinates: EclipticCoordinates {
        get {
            let longitude = KPCAAEclipticalElement_EclipticLongitude(self.julianDay.value, self.planet, self.highPrecision)
            let latitude = KPCAAEclipticalElement_EclipticLatitude(self.julianDay.value, self.planet, self.highPrecision)
            return EclipticCoordinates(lambda: Degree(longitude), beta: Degree(latitude))
        }
    }

    public var radiusVector: AU {
        get { return AU(KPCAAEclipticalElement_RadiusVector(self.julianDay.value, self.planet, self.highPrecision)) }
    }
    
    public var equatorialSemiDiameter: Degree {
        get { return Degree(KPCAADiameters_EquatorialSemiDiameterB(self.planet, self.radiusVector.value)) }
    }
    
    public var polarSemiDiameter: Degree {
        get { return Degree(KPCAADiameters_PolarSemiDiameterB(self.planet, self.radiusVector.value)) }
    }
    
    public let apparentRiseSetAltitude = ArcMinute(-34).inDegrees // See AA p.101
    
}

// special Pluto:
public class DwarfPlanet: Object, PlanetaryBase {}


