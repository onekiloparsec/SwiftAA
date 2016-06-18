//
//  KPCAAEarth.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAEarth.h"
#import "AAEarth.h"

double KPCAAEarth_EclipticLongitude(double JD, BOOL highPrecision)
{
    return CAAEarth::EclipticLongitude(JD, highPrecision);
}

double KPCAAEarth_EclipticLatitude(double JD, BOOL highPrecision)
{
    return CAAEarth::EclipticLatitude(JD, highPrecision);
}

double KPCAAEarth_RadiusVector(double JD, BOOL highPrecision)
{
    return CAAEarth::RadiusVector(JD, highPrecision);
}

double KPCAAEarth_SunMeanAnomaly(double JD)
{
    return CAAEarth::SunMeanAnomaly(JD);
}

double KPCAAEarth_Eccentricity(double JD)
{
    return CAAEarth::Eccentricity(JD);
}

double KPCAAEarth_EclipticLongitudeJ2000(double JD, BOOL highPrecision)
{
    return CAAEarth::EclipticLongitudeJ2000(JD, highPrecision);
}

double KPCAAEarth_EclipticLatitudeJ2000(double JD, BOOL highPrecision)
{
    return CAAEarth::EclipticLatitudeJ2000(JD, highPrecision);
}

