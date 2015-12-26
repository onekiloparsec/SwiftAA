//
//  KPCAAUranus.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAUranus.h"
#import "AAUranus.h"

double KPCAAUranusEclipticLongitude(double JD, BOOL highPrecision)
{
    return CAAUranus::EclipticLongitude(JD, highPrecision);
}

double KPCAAUranusEclipticLatitude(double JD, BOOL highPrecision)
{
    return CAAUranus::EclipticLatitude(JD, highPrecision);
}

double KPCAAUranusRadiusVector(double JD, BOOL highPrecision)
{
    return CAAUranus::RadiusVector(JD, highPrecision);
}
