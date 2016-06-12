//
//  KPCAAMoon.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 09/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAMoon.h"
#import "AAMoon.h"

double KPCAAMoonMeanLongitude(double JD)
{
    return CAAMoon::MeanLongitude(JD);
}

double KPCAAMoonMeanElongation(double JD)
{
    return CAAMoon::MeanElongation(JD);
}

double KPCAAMoonMeanAnomaly(double JD)
{
    return CAAMoon::MeanAnomaly(JD);
}

double KPCAAMoonArgumentOfLatitude(double JD)
{
    return CAAMoon::ArgumentOfLatitude(JD);
}

double KPCAAMoonMeanLongitudeAscendingNode(double JD)
{
    return CAAMoon::MeanLongitudeAscendingNode(JD);
}

double KPCAAMoonMeanLongitudePerigee(double JD)
{
    return CAAMoon::MeanLongitudePerigee(JD);
}

double KPCAAMoonTrueLongitudeAscendingNode(double JD)
{
    return CAAMoon::TrueLongitudeAscendingNode(JD);
}


double KPCAAMoonEclipticLongitude(double JD)
{
    return CAAMoon::EclipticLongitude(JD);
}

double KPCAAMoonEclipticLatitude(double JD)
{
    return CAAMoon::EclipticLatitude(JD);
}

double KPCAAMoonRadiusVector(double JD)
{
    return CAAMoon::RadiusVector(JD);
}


double KPCAAMoonRadiusVectorToHorizontalParallax(double RadiusVector)
{
    return CAAMoon::RadiusVectorToHorizontalParallax(RadiusVector);
}

double KPCAAMoonHorizontalParallaxToRadiusVector(double Parallax)
{
    return CAAMoon::HorizontalParallaxToRadiusVector(Parallax);
}

