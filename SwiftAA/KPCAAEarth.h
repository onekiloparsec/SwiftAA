//
//  KPCAAEarth.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

double KPCAAEarthEclipticLongitude(double JD, BOOL highPrecision);
double KPCAAEarthEclipticLatitude(double JD, BOOL highPrecision);
double KPCAAEarthRadiusVector(double JD, BOOL highPrecision);
double KPCAAEarthSunMeanAnomaly(double JD);
double KPCAAEarthEccentricity(double JD);
double KPCAAEarthEclipticLongitudeJ2000(double JD, BOOL highPrecision);
double KPCAAEarthEclipticLatitudeJ2000(double JD, BOOL highPrecision);
