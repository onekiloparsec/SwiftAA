//
//  KPCAAPhysicalJupiter.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAPhysicalJupiter.h"
#import "AAPhysicalJupiter.h"

KPCAAPhysicalJupiterDetails KPCAAPhysicalJupiterCalculateDetails(double JD, BOOL highPrecision)
{
    CAAPhysicalJupiterDetails detailsPlus = CAAPhysicalJupiter::Calculate(JD, highPrecision);
    
    struct KPCAAPhysicalJupiterDetails details;
    details.DE = detailsPlus.DE;
    details.DS = detailsPlus.DS;
    details.Geometricw1 = detailsPlus.Geometricw1;
    details.Geometricw2 = detailsPlus.Geometricw2;
    details.Apparentw1 = detailsPlus.Apparentw1;
    details.Apparentw2 = detailsPlus.Apparentw2;
    details.P = detailsPlus.P;

    return details;
}
