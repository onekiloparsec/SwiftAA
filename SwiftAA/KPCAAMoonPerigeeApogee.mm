//
//  KPCAAMoonPerigeeApogee.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAMoonPerigeeApogee.h"
#import "AAMoonPerigeeApogee.h"

double KPCAAMoonPerigeeApogee_K(double Year)
{
    return CAAMoonPerigeeApogee::K(Year);
}

double KPCAAMoonPerigeeApogee_MeanPerigee(double k)
{
    return CAAMoonPerigeeApogee::MeanPerigee(k);
}

double KPCAAMoonPerigeeApogee_MeanApogee(double k)
{
    return CAAMoonPerigeeApogee::MeanApogee(k);
}

double KPCAAMoonPerigeeApogee_TruePerigee(double k)
{
    return CAAMoonPerigeeApogee::TruePerigee(k);
}

double KPCAAMoonPerigeeApogee_TrueApogee(double k)
{
    return CAAMoonPerigeeApogee::TrueApogee(k);
}

double KPCAAMoonPerigeeApogee_PerigeeParallax(double k)
{
    return CAAMoonPerigeeApogee::PerigeeParallax(k);
}

double KPCAAMoonPerigeeApogee_ApogeeParallax(double k)
{
    return CAAMoonPerigeeApogee::ApogeeParallax(k);
}
