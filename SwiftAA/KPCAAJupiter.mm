//
//  KPCAAJupiter.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAJupiter.h"
#import "AAJupiter.h"

@implementation KPCAAJupiter

+ (double)EclipticLongitude:(double)JD
{
    return CAAJupiter::EclipticLongitude(JD);
}

+ (double)EclipticLatitude:(double)JD
{
    return CAAJupiter::EclipticLatitude(JD);
}

+ (double)RadiusVector:(double)JD
{
    return CAAJupiter::RadiusVector(JD);
}

@end
