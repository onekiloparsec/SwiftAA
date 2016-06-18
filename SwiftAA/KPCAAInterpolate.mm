//
//  KPCAAInterpolate.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAInterpolate.h"
#import "AAInterpolate.h"

double KPCAAInterpolate_Interpolate_1234(double n, double Y1, double Y2, double Y3)
{
    return CAAInterpolate::Interpolate(n, Y1, Y2, Y3);
}

double KPCAAInterpolate_Interpolate_12345(double n, double Y1, double Y2, double Y3, double Y4, double Y5)
{
    return CAAInterpolate::Interpolate(n, Y1, Y2, Y3, Y4, Y5);
}

double KPCAAInterpolate_InterpolateToHalves(double Y1, double Y2, double Y3, double Y4)
{
    return CAAInterpolate::InterpolateToHalves(Y1, Y2, Y3, Y4);
}

double KPCAAInterpolate_LagrangeInterpolate(double X, int n, double *pX, double *pY)
{
    return CAAInterpolate::LagrangeInterpolate(X, n, pX, pY);
}

double KPCAAInterpolate_Extremum_123(double Y1, double Y2, double Y3, double *nm)
{
    return CAAInterpolate::Extremum(Y1, Y2, Y3, *nm);
}

double KPCAAInterpolate_Extremum_12345(double Y1, double Y2, double Y3, double Y4, double Y5, double *nm)
{
    return CAAInterpolate::Extremum(Y1, Y2, Y3, Y4, Y5, *nm);
}

double KPCAAInterpolate_Zero_123(double Y1, double Y2, double Y3)
{
    return CAAInterpolate::Zero(Y1, Y2, Y3);
}

double KPCAAInterpolate_Zero_12345(double Y1, double Y2, double Y3, double Y4, double Y5)
{
    return CAAInterpolate::Zero(Y1, Y2, Y3, Y4, Y5);
}

double KPCAAInterpolate_Zero2_123(double Y1, double Y2, double Y3)
{
    return CAAInterpolate::Zero2(Y1, Y2, Y3);
}

double KPCAAInterpolate_Zero2_12345(double Y1, double Y2, double Y3, double Y4, double Y5)
{
    return CAAInterpolate::Zero2(Y1, Y2, Y3, Y4, Y5);
}

