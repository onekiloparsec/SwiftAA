//
//  KPCAASaturn.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAASaturn.h"
#import "AASaturn.h"

double KPCAASaturn_EclipticLongitude(double JD, BOOL highPrecision)
{
    return CAASaturn::EclipticLongitude(JD, highPrecision);
}

double KPCAASaturn_EclipticLatitude(double JD, BOOL highPrecision)
{
    return CAASaturn::EclipticLatitude(JD, highPrecision);
}

double KPCAASaturn_RadiusVector(double JD, BOOL highPrecision)
{
    return CAASaturn::RadiusVector(JD, highPrecision);
}

