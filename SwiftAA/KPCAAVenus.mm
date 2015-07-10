//
//  KPCAAVenus.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAVenus.h"
#import "AAVenus.h"

@implementation KPCAAVenus

+ (double)EclipticLongitude:(double)JD
{
    return CAAVenus::EclipticLongitude(JD);
}

+ (double)EclipticLatitude:(double)JD
{
    return CAAVenus::EclipticLatitude(JD);
}

+ (double)RadiusVector:(double)JD
{
    return CAAVenus::RadiusVector(JD);
}


@end
