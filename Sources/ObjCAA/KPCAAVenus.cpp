//
//  KPCAAVenus.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAVenus.h"
#import "AAVenus.h"

double KPCAAVenus_EclipticLongitude(double JD, bool highPrecision)
{
    return CAAVenus::EclipticLongitude(JD, highPrecision);
}

double KPCAAVenus_EclipticLatitude(double JD, bool highPrecision)
{
    return CAAVenus::EclipticLatitude(JD, highPrecision);
}

double KPCAAVenus_RadiusVector(double JD, bool highPrecision)
{
    return CAAVenus::RadiusVector(JD, highPrecision);
}
