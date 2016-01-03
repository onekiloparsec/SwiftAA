//
//  KPCAAMercury.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
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

