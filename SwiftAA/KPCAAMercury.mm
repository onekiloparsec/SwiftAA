//
//  KPCAAMercury.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAMercury.h"
#import "AAMercury.h"

double KPCAAMercuryEclipticLongitude(double JD, BOOL highPrecision)
{
    return CAAMercury::EclipticLongitude(JD, highPrecision);
}

double KPCAAMercuryEclipticLatitude(double JD, BOOL highPrecision)
{
    return CAAMercury::EclipticLatitude(JD, highPrecision);
}

double KPCAAMercuryRadiusVector(double JD, BOOL highPrecision)
{
    return CAAMercury::RadiusVector(JD, highPrecision);
}

