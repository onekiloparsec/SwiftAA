//
//  KPCAAPhysicalSun.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAPhysicalSun.h"
#import "AAPhysicalSun.h"

KPCAAPhysicalSunDetails KPCAAPhysicalSunCalculateDetails(double JD, BOOL highPrecision)
{
    CAAPhysicalSunDetails details = CAAPhysicalSun::Calculate(JD, highPrecision);
    KPCAAPhysicalSunDetails results;
    results.P = details.P;
    results.B0 = details.B0;
    results.L0 = details.L0;
    return results;
}

double KPCAAPhysicalSunTimeOfStartOfRotation(long C)
{
    return CAAPhysicalSun::TimeOfStartOfRotation(C);
}
