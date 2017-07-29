//
//  Planets.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 03/07/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation


/// The Planet class encompasses all the shared properties of the planets, to be understood as "non-Earth" planets.
public class Planet: Object, CelestialBody, PlanetaryBase, PlanetaryPhenomena, ElementsOfPlanetaryOrbit, EllipticalPlanetaryDetails, IlluminatedFraction  {

    /// Convenience accesor for the average color of the planet, making it easier to draw a solar system. :-)
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
    
    
    /// The coordinates of the object in the equatorial system (based on Earth equator).
    public var equatorialCoordinates: EquatorialCoordinates {
        get { return self.apparentGeocentricEquatorialCoordinates }
    }
    
    /// The heliocentric coordinates of the planet. That is, its apparent position on the celestial sphere, as
    /// as it would be seen by an observer at rest at the barycenter of the solar system, and referred to the 
    /// instantaneous equator, ecliptic and equinox.
    /// It accounts for 1) the effect of light-time and 2) the effect of the Earth motion. See AA p224.
    public var heliocentricEclipticCoordinates: EclipticCoordinates {
        get {
            let longitude = KPCAAEclipticalElement_EclipticLongitude(self.julianDay.value, self.planet, self.highPrecision)
            let latitude = KPCAAEclipticalElement_EclipticLatitude(self.julianDay.value, self.planet, self.highPrecision)
            // Using standard epoch, thus standard value for the equinox, thus the mean obliquity.
            return EclipticCoordinates(lambda: Degree(longitude), beta: Degree(latitude))
        }
    }
    
    /// The radius vector of the planet (that is, its distance to the Sun).
    public var radiusVector: AstronomicalUnit {
        get { return AstronomicalUnit(KPCAAEclipticalElement_RadiusVector(self.julianDay.value, self.planet, self.highPrecision)) }
    }
    
    /// The equatorial semi diameter of the planet
    public var equatorialSemiDiameter: Degree {
        get { return Degree(KPCAADiameters_EquatorialSemiDiameterB(self.planet, self.radiusVector.value)) }
    }
    
    /// The polar semi diameter of the planet
    public var polarSemiDiameter: Degree {
        get { return Degree(KPCAADiameters_PolarSemiDiameterB(self.planet, self.radiusVector.value)) }
    }
    
    /// the standard altitude of the planet, that is, the geometric altitude of the center of the body at the time
    /// of apparent rising or setting. There is a value for the stars and planets, and one for the Sun.
    /// See AA p.101 for more explanations
    public static let apparentRiseSetAltitude = ArcMinute(-34).inDegrees
    
}

// special Pluto:
public class DwarfPlanet: Object, PlanetaryBase {}


