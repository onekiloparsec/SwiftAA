//
//  KPCPhysicalMars.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
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

