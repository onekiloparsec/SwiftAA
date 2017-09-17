//
//  KPCAAParallactic.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

double KPCAAParallactic_ParallacticAngle(double HourAngle, double Latitude, double delta);
double KPCAAParallactic_EclipticLongitudeOnHorizon(double LocalSiderealTime, double ObliquityOfEcliptic, double Latitude);
double KPCAAParallactic_AngleBetweenEclipticAndHorizon(double LocalSiderealTime, double ObliquityOfEcliptic, double Latitude);
double KPCAAParallactic_AngleBetweenNorthCelestialPoleAndNorthPoleOfEcliptic(double Lambda, double Beta, double ObliquityOfEcliptic);
    
#if __cplusplus
}
#endif
