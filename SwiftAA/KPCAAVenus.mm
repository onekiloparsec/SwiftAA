//
//  KPCAAVenus.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
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
