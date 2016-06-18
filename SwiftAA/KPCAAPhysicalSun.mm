//
//  KPCAAPhysicalSun.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAPhysicalSun.h"
#import "AAPhysicalSun.h"

KPCAAPhysicalSunDetails KPCAAPhysicalSun_CalculateDetails(double JD, BOOL highPrecision)
{
    CAAPhysicalSunDetails details = CAAPhysicalSun::Calculate(JD, highPrecision);
    KPCAAPhysicalSunDetails results;
    results.P = details.P;
    results.B0 = details.B0;
    results.L0 = details.L0;
    return results;
}

double KPCAAPhysicalSun_TimeOfStartOfRotation(long C)
{
    return CAAPhysicalSun::TimeOfStartOfRotation(C);
}
