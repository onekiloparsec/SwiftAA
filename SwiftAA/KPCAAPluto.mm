//
//  KPCAAPluto.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAPluto.h"
#import "AAPluto.h"


double KPCAAPluto_EclipticLongitude(double JD)
{
    return CAAPluto::EclipticLongitude(JD);
}

double KPCAAPluto_EclipticLatitude(double JD)
{
    return CAAPluto::EclipticLatitude(JD);
}

double KPCAAPluto_RadiusVector(double JD)
{
    return CAAPluto::RadiusVector(JD);
}

