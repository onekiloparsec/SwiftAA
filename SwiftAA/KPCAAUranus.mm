//
//  KPCAAUranus.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAUranus.h"
#import "AAUranus.h"

@implementation KPCAAUranus

+ (double)EclipticLongitude:(double)JD
{
    return CAAUranus::EclipticLongitude(JD);
}

+ (double)EclipticLatitude:(double)JD
{
    return CAAUranus::EclipticLatitude(JD);
}

+ (double)RadiusVector:(double)JD
{
    return CAAUranus::RadiusVector(JD);
}

@end
