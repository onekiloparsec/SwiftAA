//
//  KPCAAPhysicalSun.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct KPCAAPhysicalSunDetails {
    double P;
    double B0;
    double L0;
} KPCAAPhysicalSunDetails;

KPCAAPhysicalSunDetails KPCAAPhysicalSunCalculateDetails(double JD, BOOL highPrecision);
double KPCAAPhysicalSunTimeOfStartOfRotation(long C);
