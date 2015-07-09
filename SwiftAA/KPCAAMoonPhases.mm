//
//  KPCAAMoonPhases.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAMoonPhases.h"
#import "AAMoonPhases.h"

@implementation KPCAAMoonPhases

+ (double)K:(double)Year
{
    return CAAMoonPhases::K(Year);
}

+ (double)MeanPhase:(double)k
{
    return CAAMoonPhases::MeanPhase(k);
}

+ (double)TruePhase:(double)k
{
    return CAAMoonPhases::TruePhase(k);
}

@end
