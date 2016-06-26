//
//  KPCAAInterpolate.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

double KPCAAInterpolate_Interpolate_1234(double n, double Y1, double Y2, double Y3);
double KPCAAInterpolate_Interpolate_12345(double n, double Y1, double Y2, double Y3, double Y4, double Y5);
double KPCAAInterpolate_InterpolateToHalves(double Y1, double Y2, double Y3, double Y4);
double KPCAAInterpolate_LagrangeInterpolate(double X, int n, double *pX, double *pY);
double KPCAAInterpolate_Extremum_123(double Y1, double Y2, double Y3, double *nm);
double KPCAAInterpolate_Extremum_12345(double Y1, double Y2, double Y3, double Y4, double Y5, double *nm);
double KPCAAInterpolate_Zero_123(double Y1, double Y2, double Y3);
double KPCAAInterpolate_Zero_12345(double Y1, double Y2, double Y3, double Y4, double Y5);
double KPCAAInterpolate_Zero2_123(double Y1, double Y2, double Y3);
double KPCAAInterpolate_Zero2_12345(double Y1, double Y2, double Y3, double Y4, double Y5);

#if __cplusplus
}
#endif

