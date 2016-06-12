//
//  KPCAADynamicalTime.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAADynamicalTime.h"
#import "AADynamicalTime.h"

double KPCAADynamicalTimeDeltaT(double JD)
{
    return CAADynamicalTime::DeltaT(JD);
}

double KPCAADynamicalTimeCumulativeLeapSeconds(double JD)
{
    return CAADynamicalTime::CumulativeLeapSeconds(JD);
}

double KPCAADynamicalTimeTT2UTC(double JD)
{
    return CAADynamicalTime::TT2UTC(JD);
}

double KPCAADynamicalTimeUTC2TT(double JD)
{
    return CAADynamicalTime::UTC2TT(JD);
}

double KPCAADynamicalTimeTT2TAI(double JD)
{
    return CAADynamicalTime::TT2TAI(JD);
}

double KPCAADynamicalTimeTAI2TT(double JD)
{
    return CAADynamicalTime::TAI2TT(JD);
}

double KPCAADynamicalTimeTT2UT1(double JD)
{
    return CAADynamicalTime::TT2UT1(JD);
}

double KPCAADynamicalTimeUT12TT(double JD)
{
    return CAADynamicalTime::UT12TT(JD);
}

double KPCAADynamicalTimeUT1MinusUTC(double JD)
{
    return CAADynamicalTime::UT1MinusUTC(JD);
}

