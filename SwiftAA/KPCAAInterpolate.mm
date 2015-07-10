//
//  KPCAAInterpolate.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAInterpolate.h"
#import "AAInterpolate.h"

@implementation KPCAAInterpolate

+ (double)Interpolate:(double)n Y1:(double)Y1 Y2:(double)Y2 Y3:(double)Y3
{
    return CAAInterpolate::Interpolate(n, Y1, Y2, Y3);
}

+ (double)Interpolate:(double)n Y1:(double)Y1 Y2:(double)Y2 Y3:(double)Y3 Y4:(double)Y4 Y5:(double)Y5
{
    return CAAInterpolate::Interpolate(n, Y1, Y2, Y3, Y4, Y5);
}

+ (double)InterpolateToHalves:(double)Y1 Y2:(double)Y2 Y3:(double)Y3 Y4:(double)Y4
{
    return CAAInterpolate::InterpolateToHalves(Y1, Y2, Y3, Y4);
}

+ (double)LagrangeInterpolate:(double)X n:(int)n  pX:(double *)pX pY:(double *)pY
{
    return CAAInterpolate::LagrangeInterpolate(X, n, pX, pY);
}

+ (double)Extremum:(double)Y1 Y2:(double)Y2 Y3:(double)Y3 nm:(double *)nm
{
    return CAAInterpolate::Extremum(Y1, Y2, Y3, *nm);
}

+ (double)Extremum:(double)Y1 Y2:(double)Y2 Y3:(double)Y3 Y4:(double)Y4 Y5:(double)Y5 nm:(double *)nm
{
    return CAAInterpolate::Extremum(Y1, Y2, Y3, Y4, Y5, *nm);
}

+ (double)Zero:(double)Y1 Y2:(double)Y2 Y3:(double)Y3
{
    return CAAInterpolate::Zero(Y1, Y2, Y3);
}

+ (double)Zero:(double)Y1 Y2:(double)Y2 Y3:(double)Y3 Y4:(double)Y4 Y5:(double)Y5
{
    return CAAInterpolate::Zero(Y1, Y2, Y3, Y4, Y5);
}

+ (double)Zero2:(double)Y1 Y2:(double)Y2 Y3:(double)Y3
{
    return CAAInterpolate::Zero2(Y1, Y2, Y3);
}

+ (double)Zero2:(double)Y1 Y2:(double)Y2 Y3:(double)Y3 Y4:(double)Y4 Y5:(double)Y5
{
    return CAAInterpolate::Zero2(Y1, Y2, Y3, Y4, Y5);
}

@end
