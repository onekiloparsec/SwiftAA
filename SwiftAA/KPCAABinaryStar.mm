//
//  KPCAABinaryStar.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAABinaryStar.h"
#import "AABinaryStar.h"

KPCAABinaryStarDetails KPCAABinaryStar_CalculateDetails(double t, double P, double T, double e, double a, double i, double Omega, double w)
{
    CAABinaryStarDetails detailsPlus = CAABinaryStar::Calculate(t, P, T, e, a, i, Omega, w);
    
    struct KPCAABinaryStarDetails details;
    details.r = detailsPlus.r;
    details.Theta = detailsPlus.Theta;
    details.Rho = detailsPlus.Rho;
    
    return details;
}

double KPCAABinaryStar_ApparentEccentricity(double e, double i, double w)
{
    return CAABinaryStar::ApparentEccentricity(e, i, w);
}

