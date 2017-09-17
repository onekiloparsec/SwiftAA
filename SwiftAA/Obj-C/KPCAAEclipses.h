//
//  KPCAAEclipses.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct KPCAASolarEclipseDetails {
    unsigned int Flags;
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

KPCAASolarEclipseDetails KPCAAEclipses_CalculateSolar(double k);
KPCAALunarEclipseDetails KPCAAEclipses_CalculateLunar(double k);

#if __cplusplus
}
#endif
