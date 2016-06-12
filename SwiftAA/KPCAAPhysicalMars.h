//
//  KPCPhysicalMars.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

typedef struct KPCAAPhysicalMarsDetails {
    double DE;
    double DS;
    double w;
    double P;
    double X;
    double k;
    double q;
    double d;
} KPCAAPhysicalMarsDetails;

KPCAAPhysicalMarsDetails KPCAAPhysicalMarsCalculateDetails(double JD, BOOL highPrecision);

