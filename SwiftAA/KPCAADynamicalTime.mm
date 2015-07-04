//
//  KPCAADynamicalTime.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAADynamicalTime.h"
#import "AADynamicalTime.h"

@implementation KPCAADynamicalTime

+ (double)DeltaT:(double)JD
{
    return CAADynamicalTime::DeltaT(JD);
}

+ (double)CumulativeLeapSeconds:(double)JD
{
    return CAADynamicalTime::CumulativeLeapSeconds(JD);
}

+ (double)TT2UTC:(double)JD
{
    return CAADynamicalTime::TT2UTC(JD);
}

+ (double)UTC2TT:(double)JD
{
    return CAADynamicalTime::UTC2TT(JD);
}

+ (double)TT2TAI:(double)JD
{
    return CAADynamicalTime::TT2TAI(JD);
}

+ (double)TAI2TT:(double)JD
{
    return CAADynamicalTime::TAI2TT(JD);
}

+ (double)TT2UT1:(double)JD
{
    return CAADynamicalTime::TT2UT1(JD);
}

+ (double)UT12TT:(double)JD
{
    return CAADynamicalTime::UT12TT(JD);
}

+ (double)UT1MinusUTC:(double)JD
{
    return CAADynamicalTime::UT1MinusUTC(JD);
}

@end
