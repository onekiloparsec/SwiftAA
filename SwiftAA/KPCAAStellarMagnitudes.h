//
//  KPCAAStellarMagnitudes.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

double KPCAAStellarMagnitudes_CombinedMagnitude(double m1, double m2);
double KPCAAStellarMagnitudes_BrightnessRatio(double m1, double m2);
double KPCAAStellarMagnitudes_MagnitudeDifference(double brightnessRatio);

#if __cplusplus
}
#endif
