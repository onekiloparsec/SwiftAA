//
//  KPCAAParallactic.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAParallactic.h"
#import "AAParallactic.h"

@implementation KPCAAParallactic

+ (double)ParallacticAngle:(double)HourAngle Latitude:(double)Latitude delta:(double)delta
{
    return CAAParallactic::ParallacticAngle(HourAngle, Latitude, delta);
}

+ (double)EclipticLongitudeOnHorizon:(double)LocalSiderealTime ObliquityOfEcliptic:(double)ObliquityOfEcliptic Latitude:(double)Latitude
{
    return CAAParallactic::EclipticLongitudeOnHorizon(LocalSiderealTime, ObliquityOfEcliptic, Latitude);
}

+ (double)AngleBetweenEclipticAndHorizon:(double)LocalSiderealTime ObliquityOfEcliptic:(double)ObliquityOfEcliptic Latitude:(double)Latitude
{
    return CAAParallactic::AngleBetweenEclipticAndHorizon(LocalSiderealTime, ObliquityOfEcliptic, Latitude);
}

+ (double)AngleBetweenNorthCelestialPoleAndNorthPoleOfEcliptic:(double)Lambda Beta:(double)Beta  ObliquityOfEcliptic:(double)ObliquityOfEcliptic
{
    return CAAParallactic::AngleBetweenNorthCelestialPoleAndNorthPoleOfEcliptic(Lambda, Beta, ObliquityOfEcliptic);
}

@end
