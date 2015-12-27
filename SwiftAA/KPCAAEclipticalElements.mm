//
//  KPCAAEclipticalElements.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 05/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAEclipticalElements.h"
#import "AAEclipticalElements.h"

KPCAAEclipticalElementDetails KPCAAEclipticalElementCalculateDetails(double i0, double w0, double omega0, double JD0, double JD)
{
    CAAEclipticalElementDetails detailsPlus = CAAEclipticalElements::Calculate(i0, w0, omega0, JD0, JD);
    
    struct KPCAAEclipticalElementDetails details;
    details.i = detailsPlus.i;
    details.w = detailsPlus.w;
    details.omega = detailsPlus.omega;
    
    return details;
}

KPCAAEclipticalElementDetails KPCAAEclipticalElementFK4B1950ToFK5J2000(double i0, double w0, double omega0)
{
    CAAEclipticalElementDetails detailsPlus = CAAEclipticalElements::FK4B1950ToFK5J2000(i0, w0, omega0);

    struct KPCAAEclipticalElementDetails details;
    details.i = detailsPlus.i;
    details.w = detailsPlus.w;
    details.omega = detailsPlus.omega;
    
    return details;
}
