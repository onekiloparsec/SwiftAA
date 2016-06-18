//
//  KPCAAVenus.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

double KPCAAVenus_EclipticLongitude(double JD, BOOL highPrecision);
double KPCAAVenus_EclipticLatitude(double JD, BOOL highPrecision);
double KPCAAVenus_RadiusVector(double JD, BOOL highPrecision);

#if __cplusplus
}
#endif
