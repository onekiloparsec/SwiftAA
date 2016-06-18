//
//  KPCAAEclipticalElements.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 05/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAEclipticalElements.h"
#import "AAEclipticalElements.h"

KPCAAEclipticalElementDetails KPCAAEclipticalElement_CalculateDetails(double i0, double w0, double omega0, double JD0, double JD)
{
    CAAEclipticalElementDetails detailsPlus = CAAEclipticalElements::Calculate(i0, w0, omega0, JD0, JD);
    
    struct KPCAAEclipticalElementDetails details;
    details.i = detailsPlus.i;
    details.w = detailsPlus.w;
    details.omega = detailsPlus.omega;
    
    return details;
}

KPCAAEclipticalElementDetails KPCAAEclipticalElement_FK4B1950ToFK5J2000(double i0, double w0, double omega0)
{
    CAAEclipticalElementDetails detailsPlus = CAAEclipticalElements::FK4B1950ToFK5J2000(i0, w0, omega0);

    struct KPCAAEclipticalElementDetails details;
    details.i = detailsPlus.i;
    details.w = detailsPlus.w;
    details.omega = detailsPlus.omega;
    
    return details;
}
