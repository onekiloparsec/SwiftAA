//
//  KPCAAPhysicalJupiter.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAPhysicalJupiter.h"
#import "AAPhysicalJupiter.h"

KPCAAPhysicalJupiterDetails KPCAAPhysicalJupiter_CalculateDetails(double JD, BOOL highPrecision)
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
