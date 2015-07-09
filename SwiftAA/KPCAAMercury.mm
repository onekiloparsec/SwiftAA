//
//  KPCAAMercury.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAMercury.h"
#import "AAMercury.h"

@implementation KPCAAMercury

+ (double)EclipticLongitude:(double)JD
{
    return CAAMercury::EclipticLongitude(JD);
}

+ (double)EclipticLatitude:(double)JD
{
    return CAAMercury::EclipticLatitude(JD);
}

+ (double)RadiusVector:(double)JD
{
    return CAAMercury::RadiusVector(JD);
}

@end
