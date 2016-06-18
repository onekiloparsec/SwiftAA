//
//  KPCAAPhysicalMoon.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

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


KPCAAPhysicalMoonDetails KPCPhysicalMoon_CalculateGeocentric(double JD);
KPCAAPhysicalMoonDetails KPCPhysicalMoon_CalculateTopocentric(double JD, double Longitude, double Latitude);
KPCAASelenographicMoonDetails KPCPhysicalMoon_SelenographicPositionOfSun(double JD, BOOL highPrecision);

double KPCPhysicalMoon_AltitudeOfSun(double JD, double Longitude, double Latitude, BOOL highPrecision);
double KPCPhysicalMoon_TimeOfSunrise(double JD, double Longitude, double Latitude, BOOL highPrecision);
double KPCPhysicalMoon_TimeOfSunset(double JD, double Longitude, double Latitude, BOOL highPrecision);

#if __cplusplus
}
#endif
