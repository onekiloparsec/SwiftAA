//
//  KPCAAEarth.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

double KPCAAEarth_EclipticLongitude(double JD, BOOL highPrecision);
double KPCAAEarth_EclipticLatitude(double JD, BOOL highPrecision);
double KPCAAEarth_RadiusVector(double JD, BOOL highPrecision);
    
// AA+ what for?
double KPCAAEarth_SunMeanAnomaly(double JD);
    
// AA+ Lower precision than double CAAElementsPlanetaryOrbit::EarthEccentricity(double JD)?
double KPCAAEarth_Eccentricity(double JD);
    
double KPCAAEarth_EclipticLongitudeJ2000(double JD, BOOL highPrecision);
double KPCAAEarth_EclipticLatitudeJ2000(double JD, BOOL highPrecision);

#if __cplusplus
}
#endif
