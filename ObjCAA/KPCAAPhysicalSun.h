//
//  KPCAAPhysicalSun.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct KPCAAPhysicalSunDetails {
    double P;
    double B0;
    double L0;
} KPCAAPhysicalSunDetails;

KPCAAPhysicalSunDetails KPCAAPhysicalSun_CalculateDetails(double JD, BOOL highPrecision);
double KPCAAPhysicalSun_TimeOfStartOfRotation(long C);

#if __cplusplus
}
#endif
