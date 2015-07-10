//
//  KPCAASidereal.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAASidereal.h"
#import "AASidereal.h"

@implementation KPCAASidereal

+ (double)MeanGreenwichSiderealTime:(double)JD
{
    return CAASidereal::MeanGreenwichSiderealTime(JD);
}

+ (double)ApparentGreenwichSiderealTime:(double)JD
{
    return CAASidereal::ApparentGreenwichSiderealTime(JD);
}

@end
