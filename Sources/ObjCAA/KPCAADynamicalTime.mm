//
//  KPCAADynamicalTime.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAADynamicalTime.h"
#import "AADynamicalTime.h"

double KPCAADynamicalTime_DeltaT(double JD)
{
    return CAADynamicalTime::DeltaT(JD);
}

double KPCAADynamicalTime_CumulativeLeapSeconds(double JD)
{
    return CAADynamicalTime::CumulativeLeapSeconds(JD);
}

double KPCAADynamicalTime_TT2UTC(double JD)
{
    return CAADynamicalTime::TT2UTC(JD);
}

double KPCAADynamicalTime_UTC2TT(double JD)
{
    return CAADynamicalTime::UTC2TT(JD);
}

double KPCAADynamicalTime_TT2TAI(double JD)
{
    return CAADynamicalTime::TT2TAI(JD);
}

double KPCAADynamicalTime_TAI2TT(double JD)
{
    return CAADynamicalTime::TAI2TT(JD);
}

double KPCAADynamicalTime_TT2UT1(double JD)
{
    return CAADynamicalTime::TT2UT1(JD);
}

double KPCAADynamicalTime_UT12TT(double JD)
{
    return CAADynamicalTime::UT12TT(JD);
}

double KPCAADynamicalTime_UT1MinusUTC(double JD)
{
    return CAADynamicalTime::UT1MinusUTC(JD);
}

