//
//  KPCAAParallax.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAParallax.h"
#import "AAParallax.h"

KPCAA2DCoordinateComponents KPCAAParallaxEquatorial2TopocentricDelta(double Alpha, double Delta, double Distance, double Longitude, double Latitude, double Height, double JD)
{
    CAA2DCoordinate coords = CAAParallax::Equatorial2TopocentricDelta(Alpha, Delta, Distance, Longitude, Latitude, Height, JD);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}

KPCAA2DCoordinateComponents KPCAAParallaxEquatorial2Topocentric(double Alpha, double Delta, double Distance, double Longitude, double Latitude, double Height, double JD)
{
    CAA2DCoordinate coords = CAAParallax::Equatorial2Topocentric(Alpha, Delta, Distance, Longitude, Latitude, Height, JD);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}

KPCAATopocentricEclipticDetails KPCAAParallaxEcliptic2Topocentric(double Lambda, double Beta, double Semidiameter, double Distance, double Epsilon, double Latitude, double Height, double JD)
{
    CAATopocentricEclipticDetails detailsPlus = CAAParallax::Ecliptic2Topocentric(Lambda, Beta, Semidiameter, Distance, Epsilon, Latitude, Height, JD);
    struct KPCAATopocentricEclipticDetails details;
    details.Lambda = detailsPlus.Lambda;
    details.Beta = detailsPlus.Beta;
    details.Semidiameter = detailsPlus.Semidiameter;
    return details;
}

double KPCAAParallaxParallaxToDistance(double Parallax)
{
    return CAAParallax::ParallaxToDistance(Parallax);
}

double KPCAAParallaxDistanceToParallax(double Distance)
{
    return CAAParallax::DistanceToParallax(Distance);
}

