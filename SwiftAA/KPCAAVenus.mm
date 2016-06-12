//
//  KPCAAVenus.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAVenus.h"
#import "AAVenus.h"

double KPCAAVenusEclipticLongitude(double JD, BOOL highPrecision)
{
    return CAAVenus::EclipticLongitude(JD, highPrecision);
}

double KPCAAVenusEclipticLatitude(double JD, BOOL highPrecision)
{
    return CAAVenus::EclipticLatitude(JD, highPrecision);
}

double KPCAAVenusRadiusVector(double JD, BOOL highPrecision)
{
    return CAAVenus::RadiusVector(JD, highPrecision);
}
