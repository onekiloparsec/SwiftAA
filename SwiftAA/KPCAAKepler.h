//
//  KPCAAKepler.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

// Pass nIterations=0 to use default (53).
// M = mean anomaly
// e = eccentricity of planet orbit.
double KPCAAKepler_Calculate(double M, double e, int nIterations);

#if __cplusplus
}
#endif
