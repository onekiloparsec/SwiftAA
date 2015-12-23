//
//  KPCAAPhysicalMoon.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct KPCAAPhysicalMoonDetails {
    double ldash;
    double bdash;
    double ldash2;
    double bdash2;
    double l;
    double b;
    double P;
} KPCAAPhysicalMoonDetails;

typedef struct KPCAASelenographicMoonDetails {
    double l0;
    double b0;
    double c0;
} KPCAASelenographicMoonDetails;


KPCAAPhysicalMoonDetails KPCPhysicalMoonGeocentric(double JD);
KPCAAPhysicalMoonDetails KPCPhysicalMoonTopocentric(double JD, double Longitude, double Latitude);
KPCAASelenographicMoonDetails KPCPhysicalMoonSelenographicPositionOfSun(double JD, BOOL highPrecision);

double KPCPhysicalMoonAltitudeOfSun(double JD, double Longitude, double Latitude, BOOL highPrecision);
double KPCPhysicalMoonTimeOfSunrise(double JD, double Longitude, double Latitude, BOOL highPrecision);
double KPCPhysicalMoonTimeOfSunset(double JD, double Longitude, double Latitude, BOOL highPrecision);

