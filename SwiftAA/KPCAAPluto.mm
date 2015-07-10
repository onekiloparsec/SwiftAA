//
//  KPCAAPluto.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAPluto.h"
#import "AAPluto.h"

@implementation KPCAAPluto

+ (double)EclipticLongitude:(double)JD
{
    return CAAPluto::EclipticLongitude(JD);
}

+ (double)EclipticLatitude:(double)JD
{
    return CAAPluto::EclipticLatitude(JD);
}

+ (double)RadiusVector:(double)JD
{
    return CAAPluto::RadiusVector(JD);
}

@end
