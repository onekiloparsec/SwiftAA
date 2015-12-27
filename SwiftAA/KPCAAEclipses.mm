//
//  KPCAAEclipses.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAEclipses.h"
#import "AAEclipses.h"

KPCAASolarEclipseDetails KPCAAEclipsesCalculateSolar(double k)
{
    CAASolarEclipseDetails detailsPlus = CAAEclipses::CalculateSolar(k);

    struct KPCAASolarEclipseDetails details;
    details.eclipse = detailsPlus.bEclipse;
    details.TimeOfMaximumEclipse = detailsPlus.TimeOfMaximumEclipse;
    details.F = detailsPlus.F;
    details.u = detailsPlus.u;
    details.gamma = detailsPlus.gamma;
    details.GreatestMagnitude = detailsPlus.GreatestMagnitude;
    
    return details;
}

KPCAALunarEclipseDetails KPCAAEclipsesCalculateLunar(double k)
{
    CAALunarEclipseDetails detailsPlus = CAAEclipses::CalculateLunar(k);
    
    struct KPCAALunarEclipseDetails details;
    details.eclipse = detailsPlus.bEclipse;
    details.TimeOfMaximumEclipse = detailsPlus.TimeOfMaximumEclipse;
    details.F = detailsPlus.F;
    details.u = detailsPlus.u;
    details.gamma = detailsPlus.gamma;
    details.PenumbralRadii = detailsPlus.PenumbralRadii;
    details.UmbralRadii = detailsPlus.UmbralRadii;
    details.PenumbralMagnitude = detailsPlus.PenumbralMagnitude;
    details.UmbralMagnitude = detailsPlus.UmbralMagnitude;
    details.PartialPhaseSemiDuration = detailsPlus.PartialPhaseSemiDuration;
    details.TotalPhaseSemiDuration = detailsPlus.TotalPhaseSemiDuration;
    details.PartialPhasePenumbraSemiDuration = detailsPlus.PartialPhasePenumbraSemiDuration;
    
    return details;
}

