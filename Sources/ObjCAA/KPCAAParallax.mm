//
//  KPCAAParallax.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAParallax.h"
#import "AAParallax.h"

KPCAA2DCoordinateComponents KPCAAParallax_Equatorial2TopocentricDelta(double Alpha, double Delta, double Distance, double Longitude, double Latitude, double Height, double JD)
{
    CAA2DCoordinate coords = CAAParallax::Equatorial2TopocentricDelta(Alpha, Delta, Distance, Longitude, Latitude, Height, JD);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}

KPCAA2DCoordinateComponents KPCAAParallax_Equatorial2Topocentric(double Alpha, double Delta, double Distance, double Longitude, double Latitude, double Height, double JD)
{
    CAA2DCoordinate coords = CAAParallax::Equatorial2Topocentric(Alpha, Delta, Distance, Longitude, Latitude, Height, JD);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}

KPCAATopocentricEclipticDetails KPCAAParallax_Ecliptic2Topocentric(double Lambda, double Beta, double Semidiameter, double Distance, double Epsilon, double Latitude, double Height, double JD)
{
    CAATopocentricEclipticDetails detailsPlus = CAAParallax::Ecliptic2Topocentric(Lambda, Beta, Semidiameter, Distance, Epsilon, Latitude, Height, JD);
    struct KPCAATopocentricEclipticDetails details;
    details.Lambda = detailsPlus.Lambda;
    details.Beta = detailsPlus.Beta;
    details.Semidiameter = detailsPlus.Semidiameter;
    return details;
}

double KPCAAParallax_ParallaxToDistance(double Parallax)
{
    return CAAParallax::ParallaxToDistance(Parallax);
}

double KPCAAParallax_DistanceToParallax(double Distance)
{
    return CAAParallax::DistanceToParallax(Distance);
}

