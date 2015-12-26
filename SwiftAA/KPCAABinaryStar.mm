//
//  KPCAABinaryStar.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAABinaryStar.h"
#import "AABinaryStar.h"

KPCAABinaryStarDetails KPCAABinaryStarCalculateDetails(double t, double P, double T, double e, double a, double i, double Omega, double w)
{
    CAABinaryStarDetails detailsPlus = CAABinaryStar::Calculate(t, P, T, e, a, i, Omega, w);
    
    struct KPCAABinaryStarDetails details;
    details.r = detailsPlus.r;
    details.Theta = detailsPlus.Theta;
    details.Rho = detailsPlus.Rho;
    
    return details;
}

double KPCAABinaryStarApparentEccentricity(double e, double i, double w)
{
    return CAABinaryStar::ApparentEccentricity(e, i, w);
}

