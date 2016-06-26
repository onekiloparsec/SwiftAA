//
//  KPCAAMercury.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

double KPCAAMercury_EclipticLongitude(double JD, BOOL highPrecision);
double KPCAAMercury_EclipticLatitude(double JD, BOOL highPrecision);
double KPCAAMercury_RadiusVector(double JD, BOOL highPrecision);

#if __cplusplus
}
#endif
