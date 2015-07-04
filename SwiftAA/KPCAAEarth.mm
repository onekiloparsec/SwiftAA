//
//  KPCAAEarth.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAEarth.h"
#import "AAEarth.h"

@implementation KPCAAEarth

+ (double)EclipticLongitude:(double)JD
{
    return CAAEarth::EclipticLongitude(JD);
}

+ (double)EclipticLatitude:(double)JD
{
    return CAAEarth::EclipticLatitude(JD);
}

+ (double)RadiusVector:(double)JD
{
    return CAAEarth::RadiusVector(JD);
}

+ (double)SunMeanAnomaly:(double)JD
{
    return CAAEarth::SunMeanAnomaly(JD);
}

+ (double)Eccentricity:(double)JD
{
    return CAAEarth::Eccentricity(JD);
}

+ (double)EclipticLongitudeJ2000:(double)JD
{
    return CAAEarth::EclipticLongitudeJ2000(JD);
}

+ (double)EclipticLatitudeJ2000:(double)JD
{
    return CAAEarth::EclipticLatitudeJ2000(JD);
}


@end
