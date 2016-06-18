//
//  KPCAAPhysicalMoon.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAPhysicalMoon.h"
#import "AAPhysicalMoon.h"

KPCAAPhysicalMoonDetails KPCAAPhysicalMoonDetailsMake(CAAPhysicalMoonDetails details); // prototype
KPCAAPhysicalMoonDetails KPCAAPhysicalMoonDetailsMake(CAAPhysicalMoonDetails details) {
    KPCAAPhysicalMoonDetails results;
    results.ldash = details.ldash;
    results.bdash = details.bdash;
    results.ldash2 = details.ldash2;
    results.bdash2 = details.bdash2;
    results.l = details.l;
    results.b = details.b;
    results.P = details.P;
    return results;
}

KPCAASelenographicMoonDetails KPCAASelenographicMoonDetailsMake(CAASelenographicMoonDetails details); // prototype
KPCAASelenographicMoonDetails KPCAASelenographicMoonDetailsMake(CAASelenographicMoonDetails details) {
    KPCAASelenographicMoonDetails results;
    results.l0 = details.l0;
    results.b0 = details.b0;
    results.c0 = details.c0;
    return results;
}

KPCAAPhysicalMoonDetails KPCPhysicalMoon_CalculateGeocentric(double JD)
{
    return KPCAAPhysicalMoonDetailsMake(CAAPhysicalMoon::CalculateGeocentric(JD));
}

KPCAAPhysicalMoonDetails KPCPhysicalMoon_CalculateTopocentric(double JD, double Longitude, double Latitude)
{
    return KPCAAPhysicalMoonDetailsMake(CAAPhysicalMoon::CalculateTopocentric(JD, Longitude, Latitude));
}

KPCAASelenographicMoonDetails KPCPhysicalMoon_SelenographicPositionOfSun(double JD, BOOL highPrecision)
{
    return KPCAASelenographicMoonDetailsMake(CAAPhysicalMoon::CalculateSelenographicPositionOfSun(JD, highPrecision));
}

double KPCPhysicalMoon_AltitudeOfSun(double JD, double Longitude, double Latitude, BOOL highPrecision)
{
    return CAAPhysicalMoon::AltitudeOfSun(JD, Longitude, Latitude, highPrecision);
}

double KPCPhysicalMoon_TimeOfSunrise(double JD, double Longitude, double Latitude, BOOL highPrecision)
{
    return CAAPhysicalMoon::TimeOfSunrise(JD, Longitude, Latitude, highPrecision);
}

double KPCPhysicalMoon_TimeOfSunset(double JD, double Longitude, double Latitude, BOOL highPrecision)
{
    return CAAPhysicalMoon::TimeOfSunset(JD, Longitude, Latitude, highPrecision);
}

