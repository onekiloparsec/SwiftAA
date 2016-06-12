//
//  KPCAAPhysicalSun.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

typedef struct KPCAAPhysicalSunDetails {
    double P;
    double B0;
    double L0;
} KPCAAPhysicalSunDetails;

KPCAAPhysicalSunDetails KPCAAPhysicalSunCalculateDetails(double JD, BOOL highPrecision);
double KPCAAPhysicalSunTimeOfStartOfRotation(long C);
