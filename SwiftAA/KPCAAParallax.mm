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
    return [KPCAA2DCoordinate coordinateByWrapping:CAAParallax::Equatorial2TopocentricDelta(Alpha, Delta, Distance, Longitude, Latitude, Height, JD)];
}

KPCAA2DCoordinateComponents KPCAAParallaxEquatorial2Topocentric(double Alpha, double Delta, double Distance, double Longitude, double Latitude, double Height, double JD)
{
    return [KPCAA2DCoordinate coordinateByWrapping:CAAParallax::Equatorial2Topocentric(Alpha, Delta, Distance, Longitude, Latitude, Height, JD)];
}

KPCAATopocentricEclipticDetails KPCAAParallaxEcliptic2Topocentric(double Lambda, double Beta, double Semidiameter, double Distance, double Epsilon, double Latitude, double Height, double JD)
{
    return [KPCAATopocentricEclipticDetails detailsByWrapping:CAAParallax::Ecliptic2Topocentric(Lambda, Beta, Semidiameter, Distance, Epsilon, Latitude, Height, JD)];
}

double KPCAAParallaxParallaxToDistance(double Parallax)
{
    return CAAParallax::ParallaxToDistance(Parallax);
}

double KPCAAParallaxDistanceToParallax(double Distance)
{
    return CAAParallax::DistanceToParallax(Distance);
}

