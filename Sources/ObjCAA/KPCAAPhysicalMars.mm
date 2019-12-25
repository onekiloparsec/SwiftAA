//
//  KPCPhysicalMars.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAPhysicalMars.h"
#import "AAPhysicalMars.h"

KPCAAPhysicalMarsDetails KPCAAPhysicalMars_CalculateDetails(double JD, BOOL highPrecision)
{
    CAAPhysicalMarsDetails detailsPlus = CAAPhysicalMars::Calculate(JD, highPrecision);
    
    KPCAAPhysicalMarsDetails details;
    details.DE = detailsPlus.DE;
    details.DS = detailsPlus.DS;
    details.w = detailsPlus.w;
    details.P = detailsPlus.P;
    details.X = detailsPlus.X;
    details.k = detailsPlus.k;
    details.q = detailsPlus.q;
    details.d = detailsPlus.d;
    
    return details;
}
