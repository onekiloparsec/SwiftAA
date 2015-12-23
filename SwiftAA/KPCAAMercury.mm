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

+ (double)EclipticLongitude:(double)JD highPrecision:(BOOL)highPrecision
{
    return CAAMercury::EclipticLongitude(JD, highPrecision);
}

+ (double)EclipticLatitude:(double)JD highPrecision:(BOOL)highPrecision
{
    return CAAMercury::EclipticLatitude(JD, highPrecision);
}

+ (double)RadiusVector:(double)JD highPrecision:(BOOL)highPrecision
{
    return CAAMercury::RadiusVector(JD, highPrecision);
}

@end
