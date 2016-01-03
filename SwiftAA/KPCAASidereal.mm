//
//  KPCAASidereal.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAASidereal.h"
#import "AASidereal.h"

double KPCAAMeanGreenwichSiderealTime(double JD)
{
    return CAASidereal::MeanGreenwichSiderealTime(JD);
}

double KPCAAApparentGreenwichSiderealTime(double JD)
{
    return CAASidereal::ApparentGreenwichSiderealTime(JD);
}

