//
//  KPCAAEclipticalElements.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 05/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct KPCAAEclipticalElementDetails {
    double i;
    double w;
    double omega;
} KPCAAEclipticalElementDetails;

KPCAAEclipticalElementDetails KPCAAEclipticalElementCalculateDetails(double i0, double w0, double omega0, double JD0, double JD);
KPCAAEclipticalElementDetails KPCAAEclipticalElementFK4B1950ToFK5J2000(double i0, double w0, double omega0);
