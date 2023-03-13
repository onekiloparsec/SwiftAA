//
//  KPCAAUranus.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "PlatformHelpers.h"

#ifdef __cplusplus
extern "C" {
#endif

double KPCAAUranus_EclipticLongitude(double JD, bool highPrecision);
double KPCAAUranus_EclipticLatitude(double JD, bool highPrecision);
double KPCAAUranus_RadiusVector(double JD, bool highPrecision);

#if __cplusplus
}
#endif
