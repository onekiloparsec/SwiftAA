//
//  KPCAASidereal.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAASidereal.h"
#import "AASidereal.h"

double KPCAASidereal_MeanGreenwichSiderealTime(double JD)
{
    return CAASidereal::MeanGreenwichSiderealTime(JD);
}

double KPCAASidereal_ApparentGreenwichSiderealTime(double JD)
{
    return CAASidereal::ApparentGreenwichSiderealTime(JD);
}

