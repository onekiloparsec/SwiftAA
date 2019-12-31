//
//  KPCAAJupiter.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

double KPCAAJupiter_EclipticLongitude(double JD, BOOL highPrecision);
double KPCAAJupiter_EclipticLatitude(double JD, BOOL highPrecision);
double KPCAAJupiter_RadiusVector(double JD, BOOL highPrecision);

#if __cplusplus
}
#endif
