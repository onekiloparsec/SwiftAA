//
//  KPCAAMoonPerigeeApogee.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

double KPCAAMoonPerigeeApogee_K(double Year);
double KPCAAMoonPerigeeApogee_MeanPerigee(double k);
double KPCAAMoonPerigeeApogee_MeanApogee(double k);
double KPCAAMoonPerigeeApogee_TruePerigee(double k);
double KPCAAMoonPerigeeApogee_TrueApogee(double k);
double KPCAAMoonPerigeeApogee_PerigeeParallax(double k);
double KPCAAMoonPerigeeApogee_ApogeeParallax(double k);

#if __cplusplus
}
#endif
