//
//  KPCAAEclipses.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct KPCAASolarEclipseDetails {
    BOOL eclipse;
    double TimeOfMaximumEclipse;
    double F;
    double u;
    double gamma;
    double GreatestMagnitude;
} KPCAASolarEclipseDetails;

typedef struct KPCAALunarEclipseDetails {
    BOOL eclipse;
    double TimeOfMaximumEclipse;
    double F;
    double u;
    double gamma;
    double PenumbralRadii;
    double UmbralRadii;
    double PenumbralMagnitude;
    double UmbralMagnitude;
    double PartialPhaseSemiDuration;
    double TotalPhaseSemiDuration;
    double PartialPhasePenumbraSemiDuration;
} KPCAALunarEclipseDetails;

KPCAASolarEclipseDetails KPCAAEclipsesCalculateSolar(double k);
KPCAALunarEclipseDetails KPCAAEclipsesCalculateLunar(double k);

