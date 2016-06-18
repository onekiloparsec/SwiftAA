//
//  KPCAAParallactic.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAParallactic.h"
#import "AAParallactic.h"

double KPCAAParallactic_ParallacticAngle(double HourAngle, double Latitude, double delta)
{
    return CAAParallactic::ParallacticAngle(HourAngle, Latitude, delta);
}

double KPCAAParallactic_EclipticLongitudeOnHorizon(double LocalSiderealTime, double ObliquityOfEcliptic, double Latitude)
{
    return CAAParallactic::EclipticLongitudeOnHorizon(LocalSiderealTime, ObliquityOfEcliptic, Latitude);
}

double KPCAAParallactic_AngleBetweenEclipticAndHorizon(double LocalSiderealTime, double ObliquityOfEcliptic, double Latitude)
{
    return CAAParallactic::AngleBetweenEclipticAndHorizon(LocalSiderealTime, ObliquityOfEcliptic, Latitude);
}

double KPCAAParallactic_AngleBetweenNorthCelestialPoleAndNorthPoleOfEcliptic(double Lambda, double Beta, double ObliquityOfEcliptic)
{
    return CAAParallactic::AngleBetweenNorthCelestialPoleAndNorthPoleOfEcliptic(Lambda, Beta, ObliquityOfEcliptic);
}

