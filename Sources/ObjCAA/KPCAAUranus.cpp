//
//  KPCAAUranus.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAUranus.h"
#import "AAUranus.h"

double KPCAAUranus_EclipticLongitude(double JD, bool highPrecision)
{
    return CAAUranus::EclipticLongitude(JD, highPrecision);
}

double KPCAAUranus_EclipticLatitude(double JD, bool highPrecision)
{
    return CAAUranus::EclipticLatitude(JD, highPrecision);
}

double KPCAAUranus_RadiusVector(double JD, bool highPrecision)
{
    return CAAUranus::RadiusVector(JD, highPrecision);
}
