//
//  KPCAANeptune.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAANeptune.h"
#import "AANeptune.h"

@implementation KPCAANeptune

+ (double)EclipticLongitude:(double)JD
{
    return CAANeptune::EclipticLongitude(JD);
}

+ (double)EclipticLatitude:(double)JD
{
    return CAANeptune::EclipticLatitude(JD);
}

+ (double)RadiusVector:(double)JD
{
    return CAANeptune::RadiusVector(JD);
}

@end
