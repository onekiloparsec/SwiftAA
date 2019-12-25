//
//  KPCAAMars.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

double KPCAAMars_EclipticLongitude(double JD, BOOL highPrecision);
double KPCAAMars_EclipticLatitude(double JD, BOOL highPrecision);
double KPCAAMars_RadiusVector(double JD, BOOL highPrecision);

#if __cplusplus
}
#endif
