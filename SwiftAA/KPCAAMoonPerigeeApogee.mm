//
//  KPCAAMoonPerigeeApogee.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAMoonPerigeeApogee.h"
#import "AAMoonPerigeeApogee.h"

@implementation KPCAAMoonPerigeeApogee

+ (double)K:(double)Year
{
    return CAAMoonPerigeeApogee::K(Year);
}

+ (double)MeanPerigee:(double)k
{
    return CAAMoonPerigeeApogee::MeanPerigee(k);
}

+ (double)MeanApogee:(double)k
{
    return CAAMoonPerigeeApogee::MeanApogee(k);
}

+ (double)TruePerigee:(double)k
{
    return CAAMoonPerigeeApogee::TruePerigee(k);
}

+ (double)TrueApogee:(double)k
{
    return CAAMoonPerigeeApogee::TrueApogee(k);
}

+ (double)PerigeeParallax:(double)k
{
    return CAAMoonPerigeeApogee::PerigeeParallax(k);
}

+ (double)ApogeeParallax:(double)k
{
    return CAAMoonPerigeeApogee::ApogeeParallax(k);
}

@end
