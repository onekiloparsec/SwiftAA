//
//  KPCAAMars.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "PlatformHelpers.h"

#ifdef __cplusplus
extern "C" {
#endif

double KPCAAMars_EclipticLongitude(double JD, bool highPrecision);
double KPCAAMars_EclipticLatitude(double JD, bool highPrecision);
double KPCAAMars_RadiusVector(double JD, bool highPrecision);

#if __cplusplus
}
#endif
