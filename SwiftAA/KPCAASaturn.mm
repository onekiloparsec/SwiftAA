//
//  KPCAASaturn.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAASaturn.h"
#import "AASaturn.h"

double KPCAASaturnEclipticLongitude(double JD, BOOL highPrecision)
{
    return CAASaturn::EclipticLongitude(JD, highPrecision);
}

double KPCAASaturnEclipticLatitude(double JD, BOOL highPrecision)
{
    return CAASaturn::EclipticLatitude(JD, highPrecision);
}

double KPCAASaturnRadiusVector(double JD, BOOL highPrecision)
{
    return CAASaturn::RadiusVector(JD, highPrecision);
}

