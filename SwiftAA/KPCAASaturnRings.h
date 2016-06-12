//
//  KPCAASaturnRings.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

typedef struct KPCAASaturnRingDetails {
    double B;
    double Bdash;
    double P;
    double a;
    double b;
    double DeltaU;
} KPCAASaturnRingDetails;

KPCAASaturnRingDetails KPCAASaturnRings(double JD, BOOL highPrecision);