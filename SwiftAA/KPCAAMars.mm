//
//  KPCAAMars.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAMars.h"
#import "AAMars.h"

double KPCAAMarsEclipticLongitude(double JD, BOOL highPrecision)
{
    return CAAMars::EclipticLongitude(JD, highPrecision);
}

double KPCAAMarsEclipticLatitude(double JD, BOOL highPrecision)
{
    return CAAMars::EclipticLatitude(JD, highPrecision);
}

double KPCAAMarsRadiusVector(double JD, BOOL highPrecision)
{
    return CAAMars::RadiusVector(JD, highPrecision);
}

