//
//  KPCAAMars.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAMars.h"
#import "AAMars.h"

@implementation KPCAAMars

+ (double)EclipticLongitude:(double)JD
{
    return CAAMars::EclipticLongitude(JD);
}

+ (double)EclipticLatitude:(double)JD
{
    return CAAMars::EclipticLatitude(JD);
}

+ (double)RadiusVector:(double)JD
{
    return CAAMars::RadiusVector(JD);
}

@end
