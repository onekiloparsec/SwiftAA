//
//  KPCAAEarth.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAEarth.h"
#import "AAEarth.h"

double KPCAAEarthEclipticLongitude(double JD, BOOL highPrecision)
{
    return CAAEarth::EclipticLongitude(JD, highPrecision);
}

double KPCAAEarthEclipticLatitude(double JD, BOOL highPrecision)
{
    return CAAEarth::EclipticLatitude(JD, highPrecision);
}

double KPCAAEarthRadiusVector(double JD, BOOL highPrecision)
{
    return CAAEarth::RadiusVector(JD, highPrecision);
}

double KPCAAEarthSunMeanAnomaly(double JD)
{
    return CAAEarth::SunMeanAnomaly(JD);
}

double KPCAAEarthEccentricity(double JD)
{
    return CAAEarth::Eccentricity(JD);
}

double KPCAAEarthEclipticLongitudeJ2000(double JD, BOOL highPrecision)
{
    return CAAEarth::EclipticLongitudeJ2000(JD, highPrecision);
}

double KPCAAEarthEclipticLatitudeJ2000(double JD, BOOL highPrecision)
{
    return CAAEarth::EclipticLatitudeJ2000(JD, highPrecision);
}

