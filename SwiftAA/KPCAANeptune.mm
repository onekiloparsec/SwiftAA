//
//  KPCAANeptune.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAANeptune.h"
#import "AANeptune.h"

double KPCAANeptuneEclipticLongitude(double JD, BOOL highPrecision)
{
    return CAANeptune::EclipticLongitude(JD, highPrecision);
}

double KPCAANeptuneEclipticLatitude(double JD, BOOL highPrecision)
{
    return CAANeptune::EclipticLatitude(JD, highPrecision);
}

double KPCAANeptuneRadiusVector(double JD, BOOL highPrecision)
{
    return CAANeptune::RadiusVector(JD, highPrecision);
}

